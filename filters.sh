#!/bin/sh
filters() {
        if [ $# -le 1 ]; then
                local grepopt=''
                case "$1" in
                        ('no '?*) set -- "${1#no }"; grepopt='-v' ;;
                esac
                case "$1" in
                        (*'=ANY')
                                grep $grepopt -- '\<'"${1%=*}"'=ANY\>'; return $?
                        ;;
                        (*'=')
                                grep $grepopt -- '\<'"$1"'.*\>'; return $?
                        ;;
                esac
                grep $grepopt -- '\<\('"$1"'\|'"${1%=*}"'=ANY\)\>'
                return $?
        fi
        local a1="$1";shift;
        filters "$a1" | filters "$@"
}
filters "$@"