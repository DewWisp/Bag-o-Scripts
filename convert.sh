#!/bin/bash
IFS=$'\n'
for item in $('ls' -1A $1); do
    if [[ $item =~ ' ' ]]; then
        mv "$item" "$(ssed -R 's/( |-(?!(\d|\.)+))/_/g' <<< $item)" 2>/dev/null
    fi
done
