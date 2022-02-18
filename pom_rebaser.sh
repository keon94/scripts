#!/bin/bash

le="\r"
find . -type f -name "pom.xml" -print0 | while IFS= read -r -d '' file; do
    echo "Rebasing $file"
    perl -i -pe 's/\r\n/\n/g' "$file" # fix line endings first
    perl -i -pe 's/\r/\n/g' "$file" # fix line endings first
    perl -i -pe "s/<<<<<<< HEAD\n.*<version>.*<\/version>\n=======\n(.*<version>.*<\/version>\n)>>>>>>>.*\n/\1/g" "$file"
    if [ $? != 0 ]; then
        echo "Error rebasing $file"
        exit 1
    fi
done
echo "Done rebasing poms"