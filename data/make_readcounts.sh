#!/usr/bin/env bash

readcount() {
    fname=$1
    gunzipped=${fname/.gz/}
    if [ -e $gunzipped ]
    then
        filearg=$gunzipped
    else
        #filearg="<(gzip -dc $fname)"
        filearg=$fname
    fi

    cmd="seqtk size $filearg"
    echo $cmd 1>&2
    time eval $cmd
}

filearg=$1
outarg=${filearg}.size

echo "seqtk size into $outarg" 1>&2
#declare -f readcount
cmd="readcount $filearg > $outarg"
echo $cmd
time eval "$cmd"

