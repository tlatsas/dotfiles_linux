#!/bin/sh

# Author: Tasos Latsas
#
# (modified script found at Archlinux wiki)
#
# Easily extract any compressed file with one command


check_bin() {
    type ${1} > /dev/null 2>&1

    if [ $? -ne 0 ]; then
        echo "You need ${1} to uncompress this file."
        echo "Aborting..."
        return 1
    fi

    return 0
}

FILE=$@

if [ -f "${FILE}" ]; then
    case "${FILE}" in
        *.tar.bz2 | *.tbz | *.tbz2)
            tar xvjf "${FILE}"
            ;;

        *.tar.gz | *.tgz)
            tar xvzf "${FILE}"
            ;;

        *.tar.xz | *.txz)
            tar xvJf "${FILE}"
            ;;

        *.bz2 | *.bz)
            bunzip2 "${FILE}"
            ;;

        *.gz)        
            gunzip "${FILE}"
            ;;

        *.rar)
            check_bin unrar || exit 1
            unrar x "${FILE}"
            ;;

        *.tar)       
            tar xvf "${FILE}"
            ;;

        *.zip)
            check_bin unzip || exit 1
            unzip "${FILE}"
            ;;

        *.Z)         
            uncompress "${FILE}"
            ;;

        *.7z)
            check_bin 7z || exit 1
            7z x "${FILE}"
            ;;

        *)           
            echo "don't know how to extract '${FILE}'..."
            exit 1
            ;;
    esac
else
    echo "'${FILE}' is not a valid file!"
    exit 1
fi
exit 0

# vim: ts=4 sw=4 et:
