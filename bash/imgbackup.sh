#!/bin/bash

# motivation:
# multiple directorys with sub-directorys and no defined depht contain pictures
# these pictures should be extraced to one folder, no picture should appear twice
# and the time modifyed should be the original time

# FUNCTIONS
doFile() {
    local file="$1"
    local date=$(date +%s -r $file)
    local filename=$(basename "$file")
    local extension="${filename##*.}"
	local md5=$(md5sum "$file" | cut -c 1-32)
    local newfile="./$outputDir/$md5.$extension"

    if [ ! -f $newfile  ];
    then
        cp "$file" "$newfile"
        touch -m -d "@$date" "$newfile"
    else
        echo "did not copy $file (filehash already existed)"
    fi
}

# START
if [ "$#" -ne 2 ]; then
    echo "usage: sortImg.sh <input directory> <output directory>"
    exit 1
fi

inputDir="$1"
outputDir="$2"

echo "This process may take some time."
echo "Files with spaces will fail."

read -p "Do you want to permantly replace spaces in files with '_' in $inputDir? [y/n]? " CONT
if [ "$CONT" = "y" ]; then
  find "$inputDir" -depth -name "* *" -execdir rename 's/ /_/g' "{}" \;
fi

# create directory from the first parameter, if not already present
if [ ! -d "$outputDir" ]; then
  mkdir "$outputDir"
fi

#run doFile for each file in all sub-directorys
files="$(find -L "$inputDir" -type f)"
echo "$files" | while read file; do
	doFile "$file"
done

echo "Finished processing $(echo -n "$files \n" | wc -l) files."
