#!/usr/bin/env bash

# just remove the first column, which has row IDs

for f in $@
do
    header=$(head -1 $f)
    echo $header
    if [ "${header:0:6}" = ",read1" ]
    then
        fileextension=${f##*.}
        shelf_file=${f/.$fileextension/.xtra_column.$fileextension}
        echo $shelf_file
        cmd="mv $f $shelf_file && cut -f2,3,4,5,6,7 -d , $shelf_file > $f"
        echo $cmd
        eval "$cmd"
    else
        "Header doesn't look like it needs to be processed, skipping: $f"
        continue
    fi
done

