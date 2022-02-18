#!/bin/bash

function diff() {
	local f1="$1"
	local f2="$2"
	local unique="\n"
	while IFS= read -r line1; do
		local match=false
		while IFS= read -r line2; do
			if [ "$line1" == "$line2" ]; then
				local match=true
				break
			fi
		done < $f2
		if [ $match == false ]; then
			unique="${unique}${line1}\n"
		fi
	done < $f1
	echo "$unique"
}

function common() {
	local f1="$1"
	local f2="$2"
	local common=""
	while IFS= read -r line1; do
		while IFS= read -r line2; do
			if [ "$line1" == "$line2" ]; then
				local common="${common}${line1}\n"
			fi
		done < $f2
	done < $f1
	echo "$common"
}

# ================== main ======================

file1=$1
file2=$2

if [ $# != 2 ]; then
	echo "2 args expected: file1, file2"
	exit 2
fi

if [ ! -f "$file1" ]; then
	echo "$file1 doesn't exist"
	exit 1
fi

if [ ! -f "$file2" ]; then
	echo "$file2 doesn't exist"
	exit 1
fi

echo "========COMMON========"

printf $(common $file1 $file2)

printf "\n========DIFF: $file1========"

printf $(diff $file1 $file2)

printf "\n========DIFF: $file2========"

printf $(diff $file2 $file1)