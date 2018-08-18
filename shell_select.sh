#!/bin/bash

shells=(
    "/bin/bash"
    "/usr/bin/zsh"
    "/usr/local/bin/fish"
    "/usr/local/bin/xonsh"
)

printf "Select a shell:\n"
for i in $(seq 0 $((${#shells[@]} - 1))); do
    printf "[\e[93m%d\e[0m]: \e[92m%s\e[0m\n" $((i+1)) $(echo -ne "${shells[$i]}" | grep -Po '(\w+$)')
done
read -e -n 1 -p "-> " selected
${shells[$(($selected - 1))]}
