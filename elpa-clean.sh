#!/bin/bash

if [[ -e "$HOME/.emacs.d/elpa" ]]; then
    pushd "$HOME/.emacs.d/elpa"
else
    echo -e "\e[33mError\e[0m: \e[31memacs elpa package directory not found...\e[0m\n" && exit 1
fi
for package in $(ls -d */ | sed 's/\///g'); do
    if [[ ! $(grep -P '((?<=\w)(-(\d|\.)+))' <<< "$package") ]]; then
        continue
    else
        mv "$package" $(echo -n "$package" | perl -ne 's/((?<=\w)(-(\d|\.)+))//g && print $_')
    fi
done
ls -1
popd
