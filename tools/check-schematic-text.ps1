<#
Reports places where an LTspice schematic's rendered text collides with
something else: other text, a wire, or a symbol body.

It parses the .asc, resolves each SYMBOL's .asy to find where that symbol
places its instance name and value by default, applies the instance's own
WINDOW overrides and rotation, and estimates the bounding box of every
string the editor will draw. Then it reports overlapping pairs.

The text boxes are estimates: LTspice's exact glyph metrics are not public,
so character width is approximated and deliberately generous. The tool is
triage, not proof. It is meant to say which drawings to look at and where,
so a human or a capture is not the first line of defence. Over-reporting is
expected; a clean report is the thing worth having.

Usage:
  check-schematic-text.ps1 -Path <file.asc or directory> [-CharWidth 11]
                           [-LineHeight 22] [-Margin 0] [-Quiet]
#>
param(
  [Parameter(Mandatory = $true)][string]$Path,
  [double]$CharWidth = 11,
  [double]$LineHeight = 22,
  [double]$Margin = 0,
  [switch]$Tier1Only,
  [switch]$Quiet
)

$ErrorActionPreference = 'Stop'

# LTspice font size codes scale the default (size 2) height.
$SizeScale = @{ 0 = 0.5; 1 = 0.75; 2 = 1.0; 3 = 1.5; 4 = 2.0; 5 = 2.5; 6 = 3.0; 7 = 3.5 }

$SymDirs = @(
  "$env:LOCALAPPDATA\LTspice\lib\sym",
  "$env:LOCALAPPDATA\Programs\ADI\LTspice\lib\sym"
)

function Get-Scale([int]$size) {
  if ($SizeScale.ContainsKey($size)) { return $SizeScale[$size] }
  return 1.0
}

# ---------------------------------------------------------------- .asy cache
$AsyCache = @{}

function Get-Asy([string]$symName, [string]$ascDir) {
  $key = "$ascDir|$symName"
  if ($AsyCache.ContainsKey($key)) { return $AsyCache[$key] }

  $file = $null
  if ($symName -match '[\\/]') {
    $cand = Join-Path $ascDir "$symName.asy"
    if (Test-Path -LiteralPath $cand) { $file = (Resolve-Path -LiteralPath $cand).Path }
  }
  if (-not $file) {
    foreach ($d in $SymDirs) {
      $cand = Join-Path $d "$symName.asy"
      if (Test-Path -LiteralPath $cand) { $file = $cand; break }
    }
  }
  if (-not $file) {
    $leaf = Split-Path $symName -Leaf
    foreach ($d in $SymDirs) {
      $cand = Join-Path $d "$leaf.asy"
      if (Test-Path -LiteralPath $cand) { $file = $cand; break }
    }
  }

  $info = [ordered]@{ Found = $false; Windows = @{}; X1 = 0; Y1 = 0; X2 = 0; Y2 = 0 }
  if ($file) {
    $info.Found = $true
    $xs = New-Object System.Collections.ArrayList
    $ys = New-Object System.Collections.ArrayList
    foreach ($line in [System.IO.File]::ReadAllLines($file)) {
      $t = $line.Trim()
      if ($t -match '^WINDOW\s+(\d+)\s+(-?\d+)\s+(-?\d+)\s+(\S+)\s+(\d+)') {
        $info.Windows[[int]$Matches[1]] = @{
          dx = [int]$Matches[2]; dy = [int]$Matches[3]
          just = $Matches[4]; size = [int]$Matches[5]
        }
      }
      elseif ($t -match '^(LINE|RECTANGLE|CIRCLE|ARC)\s+\w+\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)') {
        [void]$xs.Add([int]$Matches[2]); [void]$ys.Add([int]$Matches[3])
        [void]$xs.Add([int]$Matches[4]); [void]$ys.Add([int]$Matches[5])
      }
      elseif ($t -match '^PIN\s+(-?\d+)\s+(-?\d+)') {
        [void]$xs.Add([int]$Matches[1]); [void]$ys.Add([int]$Matches[2])
      }
    }
    if ($xs.Count) {
      $info.X1 = ($xs | Measure-Object -Minimum).Minimum
      $info.X2 = ($xs | Measure-Object -Maximum).Maximum
      $info.Y1 = ($ys | Measure-Object -Minimum).Minimum
      $info.Y2 = ($ys | Measure-Object -Maximum).Maximum
    }
  }
  $AsyCache[$key] = $info
  return $info
}

# ------------------------------------------------------------- geometry bits
function Convert-Offset([int]$dx, [int]$dy, [string]$rot) {
  # Returns the offset rotated into the instance frame. M* mirrors in x first.
  $m = $rot.StartsWith('M')
  $deg = [int]($rot -replace '^[RM]', '')
  if ($m) { $dx = -$dx }
  switch ($deg) {
    0   { return @($dx, $dy) }
    90  { return @(-$dy, $dx) }
    180 { return @(-$dx, -$dy) }
    270 { return @($dy, -$dx) }
  }
  return @($dx, $dy)
}

function New-TextBox($x, $y, [string]$text, [string]$just, [int]$size, [string]$kind, [string]$what) {
  if ([string]::IsNullOrWhiteSpace($text)) { return $null }
  $s = Get-Scale $size
  $w = $text.Length * $CharWidth * $s
  $h = $LineHeight * $s

  # The V-prefixed justifications are VERTICAL ALIGNMENT, not vertical text.
  # LTspice uses them on rotated symbols and still draws the string
  # horizontally: VBottom anchors the text's bottom edge at the point, so the
  # string sits above it, and VTop anchors the top edge, so it sits below.
  # Treating them as rotated text was wrong and reported every rotated
  # component's own name and value as overlapping each other.
  if ($just -match '^V') {
    switch ($just -replace '^V', '') {
      'Top'    { $y1 = $y;        $y2 = $y + $h }
      'Bottom' { $y1 = $y - $h;   $y2 = $y }
      default  { $y1 = $y - $h/2; $y2 = $y + $h/2 }
    }
    $x1 = $x - $w/2; $x2 = $x + $w/2
  }
  else {
    switch ($just) {
      'Left'   { $x1 = $x;        $x2 = $x + $w }
      'Right'  { $x1 = $x - $w;   $x2 = $x }
      default  { $x1 = $x - $w/2; $x2 = $x + $w/2 }
    }
    $y1 = $y - $h/2; $y2 = $y + $h/2
  }
  return [pscustomobject]@{
    Kind = $kind; What = $what; Text = $text
    X1 = $x1 - $Margin; Y1 = $y1 - $Margin; X2 = $x2 + $Margin; Y2 = $y2 + $Margin
  }
}

function Test-BoxOverlap($a, $b) {
  return -not ($a.X2 -le $b.X1 -or $b.X2 -le $a.X1 -or $a.Y2 -le $b.Y1 -or $b.Y2 -le $a.Y1)
}

function Get-OverlapArea($a, $b) {
  $w = [Math]::Min($a.X2, $b.X2) - [Math]::Max($a.X1, $b.X1)
  $h = [Math]::Min($a.Y2, $b.Y2) - [Math]::Max($a.Y1, $b.Y1)
  if ($w -le 0 -or $h -le 0) { return 0 }
  return $w * $h
}

function Test-SegmentCrossesBox($seg, $box) {
  # Axis-aligned wires only, which is what these schematics use.
  if ($seg.X1 -eq $seg.X2) {
    $lo = [Math]::Min($seg.Y1, $seg.Y2); $hi = [Math]::Max($seg.Y1, $seg.Y2)
    return ($seg.X1 -gt $box.X1 -and $seg.X1 -lt $box.X2 -and $hi -gt $box.Y1 -and $lo -lt $box.Y2)
  }
  if ($seg.Y1 -eq $seg.Y2) {
    $lo = [Math]::Min($seg.X1, $seg.X2); $hi = [Math]::Max($seg.X1, $seg.X2)
    return ($seg.Y1 -gt $box.Y1 -and $seg.Y1 -lt $box.Y2 -and $hi -gt $box.X1 -and $lo -lt $box.X2)
  }
  return $false
}

# ------------------------------------------------------------------ one file
function Test-Schematic([string]$ascPath) {
  $dir = Split-Path -Parent $ascPath
  $lines = [System.IO.File]::ReadAllLines($ascPath)

  $texts = New-Object System.Collections.ArrayList   # rendered strings
  $wires = New-Object System.Collections.ArrayList   # wire segments
  $bodies = New-Object System.Collections.ArrayList  # symbol bodies
  $missing = New-Object System.Collections.ArrayList
  $flags = New-Object System.Collections.ArrayList   # every FLAG, by coordinate
  $defaulted = New-Object System.Collections.ArrayList # symbols with no WINDOW set

  # Wires first, so a FLAG can be placed relative to the wire it attaches to.
  foreach ($line in $lines) {
    if ($line.Trim() -match '^WIRE\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)') {
      [void]$wires.Add([pscustomobject]@{
        X1 = [int]$Matches[1]; Y1 = [int]$Matches[2]
        X2 = [int]$Matches[3]; Y2 = [int]$Matches[4]
      })
    }
  }

  $i = 0
  while ($i -lt $lines.Length) {
    $t = $lines[$i].Trim()

    if ($t -match '^TEXT\s+(-?\d+)\s+(-?\d+)\s+(\S+)\s+(\d+)\s+(.*)$') {
      $body = $Matches[5]
      $disp = $body -replace '^[;!]', ''
      # LTspice breaks a directive or comment on a literal backslash-n.
      $parts = $disp -split '\\n'
      $lineNo = 0
      foreach ($p in $parts) {
        $b = New-TextBox ([int]$Matches[1]) ([int]$Matches[2] + $lineNo * $LineHeight * (Get-Scale ([int]$Matches[4]))) `
             $p $Matches[3] ([int]$Matches[4]) 'TEXT' ('TEXT line ' + ($i + 1))
        if ($b) { [void]$texts.Add($b) }
        $lineNo++
      }
    }
    elseif ($t -match '^FLAG\s+(-?\d+)\s+(-?\d+)\s+(\S+)$') {
      $fx = [int]$Matches[1]; $fy = [int]$Matches[2]; $name = $Matches[3]
      [void]$flags.Add([pscustomobject]@{ X = $fx; Y = $fy; Name = $name })
      # Which wires land exactly on this node, and which way they leave it.
      $att = @(); $goesLeft = $false; $goesRight = $false
      $goesUp = $false; $goesDown = $false
      foreach ($w in $wires) {
        $hit = $false; $ox = 0; $oy = 0
        if ($w.X1 -eq $fx -and $w.Y1 -eq $fy) { $hit = $true; $ox = $w.X2 - $fx; $oy = $w.Y2 - $fy }
        elseif ($w.X2 -eq $fx -and $w.Y2 -eq $fy) { $hit = $true; $ox = $w.X1 - $fx; $oy = $w.Y1 - $fy }
        if ($hit) {
          $att += $w
          if ($ox -lt 0) { $goesLeft = $true }; if ($ox -gt 0) { $goesRight = $true }
          if ($oy -lt 0) { $goesUp = $true };   if ($oy -gt 0) { $goesDown = $true }
        }
      }

      if ($name -eq '0') {
        # Ground glyph, drawn downward from the node, about 16 units tall.
        [void]$bodies.Add([pscustomobject]@{
          Kind = 'GROUND'; What = "ground flag at $fx,$fy"; Text = '0'
          X1 = $fx - 16 - $Margin; Y1 = $fy - $Margin; X2 = $fx + 16 + $Margin; Y2 = $fy + 16 + $Margin
        })
      }
      else {
        # A net label is drawn on the far side of the node from its wire, and
        # runs along the wire's axis. Its own wires are excluded from the
        # crossing test, because touching them is how a label attaches.
        $w = $name.Length * $CharWidth
        $h = $LineHeight
        if (($goesUp -or $goesDown) -and -not ($goesLeft -or $goesRight)) {
          # Attached to a vertical wire: the editor rotates the string.
          $x1 = $fx - $h/2; $x2 = $fx + $h/2
          if ($goesDown) { $y1 = $fy - $w; $y2 = $fy } else { $y1 = $fy; $y2 = $fy + $w }
        }
        elseif ($goesRight -and -not $goesLeft) { $x1 = $fx - $w; $x2 = $fx; $y1 = $fy - $h/2; $y2 = $fy + $h/2 }
        elseif ($goesLeft -and -not $goesRight) { $x1 = $fx; $x2 = $fx + $w; $y1 = $fy - $h/2; $y2 = $fy + $h/2 }
        else {
          # Mid-wire or unattached: side is not determined, so span both.
          $x1 = $fx - $w; $x2 = $fx + $w; $y1 = $fy - $h/2; $y2 = $fy + $h/2
        }
        [void]$texts.Add([pscustomobject]@{
          Kind = 'FLAG'; What = "net label $name at $fx,$fy"; Text = $name
          X1 = $x1 - $Margin; Y1 = $y1 - $Margin; X2 = $x2 + $Margin; Y2 = $y2 + $Margin
          Exclude = $att
        })
      }
    }
    elseif ($t -match '^SYMBOL\s+(\S+)\s+(-?\d+)\s+(-?\d+)\s+(\S+)') {
      $sym = $Matches[1]; $sx = [int]$Matches[2]; $sy = [int]$Matches[3]; $rot = $Matches[4]
      $asy = Get-Asy $sym $dir
      if (-not $asy.Found) { [void]$missing.Add($sym) }

      # Collect this instance's WINDOW overrides and attributes.
      $ovr = @{}; $inst = $null; $val = $null
      $j = $i + 1
      while ($j -lt $lines.Length) {
        $u = $lines[$j].Trim()
        if ($u -match '^WINDOW\s+(\d+)\s+(-?\d+)\s+(-?\d+)\s+(\S+)\s+(\d+)') {
          $ovr[[int]$Matches[1]] = @{
            dx = [int]$Matches[2]; dy = [int]$Matches[3]
            just = $Matches[4]; size = [int]$Matches[5]
          }
        }
        elseif ($u -match '^SYMATTR\s+InstName\s+(.+)$') { $inst = $Matches[1].Trim() }
        elseif ($u -match '^SYMATTR\s+Value\s+(.+)$')    { $val = $Matches[1].Trim() }
        elseif ($u -match '^(SYMBOL|WIRE|FLAG|TEXT|IOPIN|LINE|RECTANGLE|CIRCLE|DATAFLAG)\b') { break }
        $j++
      }

      if ($asy.Found) {
        $p1 = Convert-Offset $asy.X1 $asy.Y1 $rot
        $p2 = Convert-Offset $asy.X2 $asy.Y2 $rot
        [void]$bodies.Add([pscustomobject]@{
          Kind = 'SYMBOL'; What = "$inst body"; Text = $sym
          X1 = $sx + [Math]::Min($p1[0], $p2[0]) - $Margin
          Y1 = $sy + [Math]::Min($p1[1], $p2[1]) - $Margin
          X2 = $sx + [Math]::Max($p1[0], $p2[0]) + $Margin
          Y2 = $sy + [Math]::Max($p1[1], $p2[1]) + $Margin
        })
      }

      # Record instances that never set a text position of their own.
      if ($inst -and -not $ovr.ContainsKey(0) -and -not $ovr.ContainsKey(3)) {
        $longest = $inst.Length
        if ($val -and $val.Length -gt $longest) { $longest = $val.Length }
        $anchor = if ($asy.Windows.ContainsKey(0)) { $asy.Windows[0] } else { @{ dx = 0; dy = 0 } }
        $off = Convert-Offset $anchor.dx $anchor.dy $rot
        [void]$defaulted.Add([pscustomobject]@{
          Inst = $inst; X = $sx + $off[0]; Y = $sy + $off[1]; Len = $longest
        })
      }

      foreach ($wid in 0, 3) {
        $spec = if ($ovr.ContainsKey($wid)) { $ovr[$wid] } elseif ($asy.Windows.ContainsKey($wid)) { $asy.Windows[$wid] } else { $null }
        if (-not $spec) { continue }
        if ($spec.just -eq 'Invisible' -or $spec.size -eq 0) { continue }
        $str = if ($wid -eq 0) { $inst } else { $val }
        if (-not $str) { continue }
        $off = Convert-Offset $spec.dx $spec.dy $rot
        $b = New-TextBox ($sx + $off[0]) ($sy + $off[1]) $str $spec.just $spec.size `
             $(if ($wid -eq 0) { 'NAME' } else { 'VALUE' }) "$inst $(if($wid -eq 0){'name'}else{'value'})"
        if ($b) { [void]$texts.Add($b) }
      }
      $i = $j - 1
    }
    $i++
  }

  # ------------------------------------------------------------- comparisons
  $hits = New-Object System.Collections.ArrayList

  # --- Tier 1: coordinate-only checks. No font metrics, no WINDOW transform,
  # so these are reliable rather than advisory.

  # Crowded flags. A ground glyph is about 16 units tall and a net label needs
  # its own row, so two flags nearer than this on a shared axis will collide
  # whichever way the editor orients them.
  for ($a = 0; $a -lt $flags.Count; $a++) {
    for ($b = $a + 1; $b -lt $flags.Count; $b++) {
      $fa = $flags[$a]; $fb = $flags[$b]
      $dx = [Math]::Abs($fa.X - $fb.X); $dy = [Math]::Abs($fa.Y - $fb.Y)
      if ($dx -le 32 -and $dy -le 48 -and ($dx + $dy) -gt 0) {
        [void]$hits.Add([pscustomobject]@{
          Tier = 1; Severity = 'flags crowded'; Area = (100 - $dx - $dy)
          A = "$($fa.Name) at $($fa.X),$($fa.Y)"
          B = "$($fb.Name) at $($fb.X),$($fb.Y)  (dx $dx, dy $dy)"
        })
      }
    }
  }

  # A net label on a node with three or more wires has no free side for the
  # editor to put its text on, so it lands on top of the junction.
  foreach ($f in $flags) {
    if ($f.Name -eq '0') { continue }
    $n = 0
    foreach ($w in $wires) {
      if (($w.X1 -eq $f.X -and $w.Y1 -eq $f.Y) -or ($w.X2 -eq $f.X -and $w.Y2 -eq $f.Y)) { $n++ }
    }
    if ($n -ge 3) {
      [void]$hits.Add([pscustomobject]@{
        Tier = 2; Severity = 'label on a junction'; Area = $n
        A = "net label $($f.Name) at $($f.X),$($f.Y)"
        B = "$n wires meet here, so no side is free for the text"
      })
    }
  }

  # Instance text left at the symbol's own defaults. Every fault reported on
  # video 5 involved a symbol whose WINDOW 0 and WINDOW 3 were never set, so
  # its text went wherever the .asy happened to put it. Flagged only when
  # another symbol body sits within a text-length of the default anchor.
  foreach ($d in $defaulted) {
    foreach ($bd in $bodies) {
      if ($bd.Kind -ne 'SYMBOL' -or $bd.What -eq "$($d.Inst) body") { continue }
      # The default text runs rightward from its anchor. Report only when the
      # span it would occupy actually overlaps the neighbour's body, and when
      # that body shares the text's rows.
      $textX1 = $d.X; $textX2 = $d.X + $d.Len * 12
      $rowsOverlap = ($bd.Y1 -lt $d.Y + 40) -and ($bd.Y2 -gt $d.Y - 40)
      $colsOverlap = ($bd.X1 -lt $textX2) -and ($bd.X2 -gt $textX1)
      if ($rowsOverlap -and $colsOverlap) {
        $over = [Math]::Min($bd.X2, $textX2) - [Math]::Max($bd.X1, $textX1)
        [void]$hits.Add([pscustomobject]@{
          Tier = 1; Severity = 'default text runs into a neighbour'; Area = [int]$over
          A = "$($d.Inst) leaves its name and value where the symbol puts them"
          B = "$($bd.What) overlaps that span by $([int]$over)"
        })
      }
    }
  }

  if ($Tier1Only) { return [pscustomobject]@{ Path = $ascPath; Hits = $hits; Missing = ($missing | Select-Object -Unique); TextCount = $texts.Count } }

  # --- Tier 2: advisory. These depend on estimated glyph widths and on how
  # LTspice rotates a WINDOW offset, which is not documented. Confirm each
  # against the rendered drawing before acting on it.

  for ($a = 0; $a -lt $texts.Count; $a++) {
    for ($b = $a + 1; $b -lt $texts.Count; $b++) {
      if (Test-BoxOverlap $texts[$a] $texts[$b]) {
        [void]$hits.Add([pscustomobject]@{
          Tier = 2; Severity = 'text over text'
          Area = [int](Get-OverlapArea $texts[$a] $texts[$b])
          A = "$($texts[$a].What): '$($texts[$a].Text)'"
          B = "$($texts[$b].What): '$($texts[$b].Text)'"
        })
      }
    }
  }

  foreach ($tb in $texts) {
    foreach ($w in $wires) {
      if ($tb.PSObject.Properties['Exclude'] -and $tb.Exclude -contains $w) { continue }
      if (Test-SegmentCrossesBox $w $tb) {
        [void]$hits.Add([pscustomobject]@{
          Tier = 2; Severity = 'wire through text'
          Area = 0
          A = "$($tb.What): '$($tb.Text)'"
          B = "wire ($($w.X1),$($w.Y1))-($($w.X2),$($w.Y2))"
        })
      }
    }
    foreach ($bd in $bodies) {
      if ($bd.What -eq "$($tb.What -replace ' (name|value)$','') body") { continue }
      if (Test-BoxOverlap $tb $bd) {
        [void]$hits.Add([pscustomobject]@{
          Tier = 2; Severity = 'text over ' + $bd.Kind.ToLower()
          Area = [int](Get-OverlapArea $tb $bd)
          A = "$($tb.What): '$($tb.Text)'"
          B = $bd.What
        })
      }
    }
  }

  return [pscustomobject]@{
    Path = $ascPath; Hits = $hits; Missing = ($missing | Select-Object -Unique)
    TextCount = $texts.Count
  }
}

# ---------------------------------------------------------------------- main
$targets = @()
if (Test-Path -LiteralPath $Path -PathType Container) {
  $targets = Get-ChildItem -LiteralPath $Path -Recurse -Filter *.asc | Sort-Object FullName
}
else {
  $targets = @(Get-Item -LiteralPath $Path)
}

$totalHits = 0
$dirty = 0
foreach ($f in $targets) {
  $r = Test-Schematic $f.FullName
  if ($r.Missing) {
    Write-Output "  ? $($f.Name): no .asy found for $($r.Missing -join ', ')"
  }
  if ($r.Hits.Count -gt 0) {
    $dirty++
    $totalHits += $r.Hits.Count
    Write-Output ""
    Write-Output "=== $($f.FullName)"
    foreach ($h in ($r.Hits | Sort-Object -Property @{Expression='Tier'}, @{Expression='Severity'}, @{Expression='Area';Descending=$true})) {
      $mark = if ($h.Tier -eq 1) { '!' } else { '?' }
      Write-Output ("  {0} {1}: {2}  <->  {3}" -f $mark, $h.Severity, $h.A, $h.B)
    }
  }
  elseif (-not $Quiet) {
    Write-Output "  ok $($f.Name)  ($($r.TextCount) strings)"
  }
}

Write-Output ""
Write-Output "$($targets.Count) schematic(s); $dirty with findings; $totalHits finding(s)."
