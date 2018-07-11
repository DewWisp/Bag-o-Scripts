#!/bin/bash

get-hash() {
    sha256sum --binary "$1" | grep -Po '(^.+ )'
}

if [[ $# == 2 ]]; then
    if [[ $(get-hash "$1") == $(get-hash "$2") ]]; then
        printf "\e[32mIdentical Hash Sums\e[0m:\n-> %s\n-> %s\n" "$(get-hash "$1")" "$(get-hash "$2")"
    else
        printf "\e[91mConflicting Hash Sums\e[0m:\n-> %s\n-> %s\n" "$(get-hash "$1")" "$(get-hash "$2")"
    fi
fi
