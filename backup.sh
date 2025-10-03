#!/bin/sh

new_files_txt="new-files.txt"

function abs() {
	_path=
	if [ -d "$1" ]; then
		cd "$1"
		_path="$PWD"
		cd - >& "/dev/null"
	else 
		echo "$1 doesn't exist"
		exit 1
	fi
	echo "$_path"
}

function get_parents() {
	_parents="${1%/*}"
	_x="$(echo "$_parents" | egrep "*\.+")"
	if [ "$_x" != "" ]; then
		echo ""
	else
		echo "$_parents"
	fi
}

if [ $# != 2 ]; then
	echo "Expected params: src(new) dest(existing)"
	exit 1
fi

src="$(abs "$1")"
dest="$(abs "$2")"
backup_name="pre - ${src##*/}"
backup_dir="$dest/auto-backups/$backup_name"

echo "Creating $backup_dir ..."
mkdir -p "$backup_dir"
if [ ! -d "$backup_dir" ]; then
	echo "$backup_dir could not be created"
	exit 1
fi

cd "$dest"
find "$src" -name '*.*' -print0 | while IFS= read -r -d '' f; do 
	subpath=$(echo "$f" | sed -r "s:$src/::g")
	if [ -f "$subpath" ]; then
		backup_path="$subpath"		
		if [ $(echo "$subpath" | egrep "*.*") != "" ]; then
			backup_path="$backup_dir/$(get_parents $subpath)"
			echo "Creating $backup_path"
			mkdir -p "$backup_path"
		fi
		yes | cp -arvf "$dest/$subpath" "$backup_path"
	else
		if [ ! -f "$backup_dir/$new_files_txt" ]; then
			touch "$backup_dir/$new_files_txt"
		fi
		echo "$subpath" >> "$backup_dir/$new_files_txt"
	fi
done
