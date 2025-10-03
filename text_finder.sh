#!/bin/sh

CYAN="\033[0;36m" #cyan
YELLOW="\033[1;33m" #yellow

target_text="$1"
file_pattern="$2"
if [ "$file_pattern" == "" ]; then
    file_pattern="*"
fi

find . -type f -name "$file_pattern" -print0 | while IFS= read -r -d '' file; do
    lines="$(grep -i -n "$target_text" "$file")"
    if [  "$lines" != "" ]; then 
        echo -e "${YELLOW}$file"
        echo -e  "${CYAN}$lines"; 
    fi; 
done