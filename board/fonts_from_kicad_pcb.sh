#!/usr/bin/env bash
# Extracts and lists all unique font names used in a given KiCad PCB file.
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 file.kicad_pcb"
  exit 1
fi

PCB="$1"
if [ ! -f "$PCB" ]; then
  echo "File not found: $PCB"
  exit 1
fi

awk '
/\(face "/ { 
    # Alles nach (face " bis zum nächsten " nehmen
    match($0, /\(face "([^"]+)"/, arr)
    if (arr[1] != "") print arr[1]
}
' "$PCB" \
| sort -fu

