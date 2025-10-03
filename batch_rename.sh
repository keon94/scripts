#!/bin/bash

if [ $# != 2 ]; then
	echo "Expected args: [file-regex-with-grouping] [substitution-regex]"
	exit 1
fi

pattern=$1
replace=$2

subs=
declare -A subs_map
while read f; do
	target="$(echo "$f" | sed -rn "s/$pattern/$replace/p")"
	if [ "$target" != "" ]; then
	  subs="$subs$f -> $target\n"
	  subs_map["$f"]="$target"
	fi
done < <(ls -f)
printf "$subs"
read -p "${#subs_map[@]} renamings to be done. Proceed? (Ctrl+C to cancel)"

for f in "${!subs_map[@]}"
do
	target="${subs_map[$f]}"
	mv "$f" "$target"
done