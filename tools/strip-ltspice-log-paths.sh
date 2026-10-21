#!/bin/sh
# Git clean filter for LTspice .log files.
#
# LTspice records absolute paths in each log's "Circuit:" line and in its
# "Files loaded:" list. This reduces every such path to its bare filename, so
# a local username and folder layout never reach the repository while the log
# still shows which netlist and model libraries were loaded.
#
# Everything else, including the .meas results, is passed through untouched.
# Reads a log on stdin and writes the cleaned log on stdout.
#
# Enable once per clone, from the repository root:
#   git config filter.ltspicelog.clean "sh tools/strip-ltspice-log-paths.sh"

exec sed 's#[A-Za-z]:\\.*\\##'
