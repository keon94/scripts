#!/bin/bash

cwd="$PWD"
find . -name "main.go" ! -print0 | while IFS= read -r -d '' file; do
	dir=$(dirname "$file")
	cd "$dir"
	echo "Generating diagram from $PWD"
	go-callvis -file="$cwd/$(basename "$PWD")" .
	cd -
done