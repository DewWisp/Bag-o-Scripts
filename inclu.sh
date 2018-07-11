#!/bin/bash

usage() {
    printf "inclu.sh\n"
    printf "Description: Dynamically source multiple scripts in the current shell\n"
    printf "Usage: inclu.sh [-e|--env] --source=\"/path/to/file1, /path/to/file2\"\n"
    printf "Parameters:\n"
    printf "    \x2Dh, \x2D\x2Dhelp       Displays this message\n"
    printf "    \x2De, \x2D\x2Denv        Source files in separate environment\n"
    printf "        \x2D\x2Dsources    List of scripts to source. Double quoted and comma separated\n"
}

if [[ $# > 0 ]]; then
    for arg in "$@"; do
        case $arg in
            -h|--help)
                usage
                ;;
            -e|--env)
                use_env="true"
                ;;
            --source=*)
                IFS=, read -a src_files <<< $(echo -ne "$arg" | grep -Po '((?<=\-{2}source\=)(.*))')
                ;;
            *)
                echo -ne "\e[93mError\e[0m: \e[91mInvalid Argument Specified\e[0m\n"
                usage
                exit 1
                ;;
        esac
    done
else
    echo -ne "\e[93mError\e[0m: \e[91mNo Arguments Specified\e[0m\n"
    usage
    exit 1
fi

for file in $(seq 0 $((${#src_files[@]} - 1))); do
    if [[ -e ${src_files[$file]} ]]; then
        if [[ $use_env == "true" ]]; then
            env -i /bin/bash --posix -c "source ${src_files[$file]}"
            exit_code=$?
        else
            source ${src_files[$file]}
            exit_code=$?
        fi
        if [[ $exit_code != 0 ]]; then
            echo -ne "\e[93mError\e[0m: \e[91mFile\e[0m \"\e[92m${src_files[$file]}\e[0m\" \e[91mWas Not Included Successfully.\e[0m\n"
            continue
        else
            echo -ne "File \"\e[92m${src_files[$file]}\e[0m\" Was Included Successfully.\n"
        fi
    else
        echo -ne "\e[93mError\e[0m: \e[91mFile\e[0m \"\e[92m${src_files[$file]}\e[0m\" \e[91mDoes Not Exist\e[0m\n"
        continue
    fi
done
