#!/bin/bash

# motivation:
# multiple directorys with sub-directorys and no defined depht contain pictures
# these pictures should be extraced to one folder, no picture should appear twice
# and the time modifyed should be the original time

# FUNCTIONS
doFile() {
    local file=$1
    local date=$(date +%s -r $file)
    local extension=${file#*.}
	local md5=$(md5sum "$1" | cut -c 1-32)
    local newfile="./$outputDir/$md5.$extension"
    if [ ! -f $newfile  ];
    then
        cp $file $newfile
        touch -m -d @$date $newfile
    else
        echo "did not copy $file (filehash already existed)"
    fi
}

# START
if [ -z "$1" ]; then
    echo "no arguments supplied"
    echo "usage: sortImg.sh <output-folder>"
    exit 1
fi

# create directory from the first parameter, if not already present
if [ ! -d "$1" ]; then
  mkdir "$1"
fi

outputDir=$1

echo "This process may take some time."

#run doFile for each file in all sub-directorys
files="$(find -L */* -type f)"
echo "$files" | while read file; do
	doFile $file
done

echo "Finished processing $(echo -n "$files \n" | wc -l) files."

