#!/usr/bin/env bash
set -o posix

if [[ -e "$HOME/.emacs.d/elpa" ]]; then
    pushd "$HOME/.emacs.d/elpa" >>/dev/null
else
    echo -e "\e[33mError\e[0m: \e[31memacs elpa package directory not found...\e[0m\n" && exit 1
fi
for package in $(ls -d */ | sed 's/\///g'); do
    if [[ ! $(grep -P '((?<=\w)(-(\d|\.)+))' <<< "$package") ]] || [[ "$package" =~ (gnupg|archives) ]]; then
        continue
    else
        mv "$package" $(printf "$package" | perl -ne 's/((?<=\w)(-(\d|\.)+))//g && print $_')
    fi
done
printf "emacs Packages:\n"
for item in $(ls -1 | grep -Pv '(gnupg|archives)'); do
    printf -- "-> %s\n" $item
done
popd >>/dev/null
