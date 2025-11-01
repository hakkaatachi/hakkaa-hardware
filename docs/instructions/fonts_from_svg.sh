#!/usr/bin/env bash
# Extracts and lists all unique font-family names used in a given SVG file.
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 file.svg"
  exit 1
fi

SVG="$1"
if [ ! -f "$SVG" ]; then
  echo "File not found: $SVG"
  exit 1
fi

grep -oP '(?i)font-family\s*:\s*[^;"]+' "$SVG" \
  | sed -E 's/^[^:]+:\s*//' \
  | tr ',' '\n' \
  | sed -E "s/^[[:space:]]+//; s/[[:space:]]+$//; s/^['\"]//; s/['\"]$//" \
  | sort -fu

