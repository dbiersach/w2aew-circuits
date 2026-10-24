#!/usr/bin/env bash
# Check that every LTspice asset a video schematic needs lives under LTspice/
# and is reached by a relative path that actually resolves.
#
# Run from anywhere:  tools/check-asset-paths.sh
# Exit status 0 when every reference is clean, 1 when anything is reported.
#
# What is checked:
#   1. No .asy, .sub, .lib, .cir or .mod file sits outside LTspice/.
#   2. Every reference to a project asset is a relative path, never absolute.
#   3. Every such path resolves to a file that exists under LTspice/.
#   4. A SYMBOL name with no leading ../ is taken as a part LTspice supplies
#      itself, such as res, cap or OpAmps\OP07, so it must not shadow an .asy
#      this repository carries.
#   5. A symbol's SYMATTR ModelFile resolves relative to the SCHEMATIC, not to
#      the symbol, so the path is re-resolved from every schematic that places
#      that symbol. A hierarchical symbol, meaning one with no SYMATTR Prefix,
#      needs its implementation .asc beside its .asy.
#
# LTspice writes a relative path with doubled separators when it saves a
# drawing, so both \ and \ are accepted.

set -uo pipefail

root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
central="$root/LTspice"
problems=0

say() { printf '  %s\n' "$1"; problems=$((problems + 1)); }

# Backslashes to forward slashes, then squeeze the doubled separators.
normalize() { printf '%s' "$1" | tr '\134' '/' | tr -s '/'; }

is_absolute() { case "$1" in [A-Za-z]:/*) return 0 ;; /*) return 0 ;; *) return 1 ;; esac; }

# A reference belongs to this project only when it is written as a relative
# path. Anything else names a part from LTspice's own installed library.
is_project_ref() { case "$1" in ../*|./*) return 0 ;; *) return 1 ;; esac; }

# Resolve $2 relative to directory $1 without requiring it to exist.
resolve() { ( cd -- "$1" 2>/dev/null && realpath -m -- "$2" ); }

# $1 what, $2 owning file for the message, $3 directory it resolves from,
# $4 the path as written, $5 suffix to append before testing existence.
# On success the resolved file is left in $ref_target.
ref_target=""
check_ref() {
    local kind=$1 owner=$2 from=$3 raw=$4 suffix=${5-} rel target
    ref_target=""
    rel=$(normalize "$raw")
    if is_absolute "$rel"; then
        say "$owner: $kind uses an absolute path: $raw"
        return 1
    fi
    target=$(resolve "$from" "$rel")
    if [[ -z "$target" ]]; then
        say "$owner: $kind cannot be resolved: $raw"
        return 1
    fi
    case "$target" in
        "$central"/*) ;;
        *) say "$owner: $kind points outside LTspice/: $raw"; return 1 ;;
    esac
    if [[ ! -f "$target$suffix" ]]; then
        say "$owner: $kind target is missing: $rel$suffix"
        return 1
    fi
    ref_target="$target$suffix"
}

echo "Checking LTspice asset references under $root"

# ---- 1: no model or symbol file outside LTspice/ --------------------------
while IFS= read -r -d '' f; do
    say "${f#"$root"/}: model or symbol file outside LTspice/"
done < <(find "$root" -path "$root/.git" -prune -o -path "$central" -prune -o \
         -type f \( -iname '*.asy' -o -iname '*.sub' -o -iname '*.lib' \
                    -o -iname '*.cir' -o -iname '*.mod' \) -print0)

# ---- 2 to 5: every reference each schematic makes -------------------------
while IFS= read -r -d '' asc; do
    rel_asc="${asc#"$root"/}"
    dir=$(dirname -- "$asc")

    # SYMBOL lines: a relative path to a project symbol, or a part LTspice
    # supplies itself.
    while IFS= read -r name; do
        [[ -n "$name" ]] || continue
        nrm=$(normalize "$name")
        if is_project_ref "$nrm"; then
            check_ref SYMBOL "$rel_asc" "$dir" "$name" .asy || continue
            sym=$ref_target
        else
            if is_absolute "$nrm"; then
                say "$rel_asc: SYMBOL uses an absolute path: $name"
                continue
            fi
            # a part LTspice supplies itself, such as res or Digital/dflop
            base=${nrm##*/}
            if [[ -f "$central/Symbols/$base.asy" ]]; then
                say "$rel_asc: SYMBOL $name does not use a relative path, but $base.asy is in LTspice/Symbols"
            fi
            continue
        fi

        # 5a: the symbol's ModelFile, re-resolved from THIS schematic
        while IFS= read -r mf; do
            [[ -n "$mf" ]] || continue
            check_ref "ModelFile, as placed by $rel_asc" "${sym#"$root"/}" "$dir" "$mf"
        done < <(grep -aiE '^SYMATTR[[:space:]]+ModelFile[[:space:]]' "$sym" |
                 sed -E 's/^[^[:space:]]+[[:space:]]+[^[:space:]]+[[:space:]]+//; s/[[:space:]]+$//')

        # 5b: a hierarchical symbol needs its implementation .asc beside it
        if ! grep -aqiE '^SYMATTR[[:space:]]+Prefix[[:space:]]' "$sym"; then
            impl_dir=$(dirname -- "$sym")
            impl_base=$(basename -- "$sym" .asy)
            found=""
            while IFS= read -r -d '' cand; do found=$cand; done \
                < <(find "$impl_dir" -maxdepth 1 -iname "$impl_base.asc" -print0)
            [[ -n "$found" ]] ||
                say "${sym#"$root"/}: hierarchical symbol has no implementation .asc beside it"
        fi
    done < <(grep -aE '^SYMBOL[[:space:]]' "$asc" |
             sed -E 's/^SYMBOL[[:space:]]+//; s/[[:space:]]+-?[0-9]+[[:space:]]+-?[0-9]+[[:space:]]+[A-Za-z0-9]+[[:space:]]*$//')

    # .include / .inc / .lib directives, wherever they sit in a TEXT line
    while IFS= read -r path; do
        [[ -n "$path" ]] || continue
        norm_inc=$(normalize "$path")
        if ! is_project_ref "$norm_inc"; then
            # A bare library name with no path at all is a library LTspice
            # supplies itself, the same way a bare SYMBOL name is. Flag it only
            # when it is absolute, or when this repository carries a file of
            # that name that the schematic should have reached relatively.
            if is_absolute "$norm_inc"; then
                say "$rel_asc: include directive uses an absolute path: $path"
            elif [[ "$norm_inc" == */* ]]; then
                say "$rel_asc: include directive does not use a relative path: $path"
            else
                shadow=$(find "$central" -type f -iname "$(basename -- "$norm_inc")" -print -quit 2>/dev/null)
                [[ -z "$shadow" ]] ||
                    say "$rel_asc: include directive names $path, but ${shadow#"$root"/} is in this repository"
            fi
            continue
        fi
        check_ref "include directive" "$rel_asc" "$dir" "$path"
    done < <(grep -aoiE '\.(include|inc|lib)[[:space:]]+("[^"]*"|[^[:space:]]+)' "$asc" |
             sed -E 's/^[^[:space:]]+[[:space:]]+//; s/^"//; s/"$//')
done < <(find "$root" -path "$root/.git" -prune -o -path "$central" -prune -o \
         -type f -iname '*.asc' -print0)

if (( problems == 0 )); then
    echo "  every project asset reference is relative and resolves under LTspice/"
    exit 0
fi
printf '\n  %s problem(s) reported\n' "$problems"
exit 1
