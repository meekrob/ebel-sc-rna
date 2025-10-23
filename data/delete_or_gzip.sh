#!/usr/bin/env bash

for f in $@
do
    if [ -e ${f}.gz ]
    then
        echo "${f}.gz exists... deleting original"
        rm -v $f
    else
        echo "compressing $f"
        gzip -v $f
    fi
done
