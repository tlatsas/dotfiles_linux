#!/bin/bash

# author Tasos Latsas
#
# copy contents of a file in X cliboard
# requires the xclip utility

_xclip=$(which xclip) || exit 1

if [[ ! -f "${1}" ]]; then
    echo "${1} not a regular file"
    exit 1
fi

$_xclip -in -selection clipboard < "${1}"
if [[ $? -eq 0 ]]; then
    echo "File copied successfully to clipboard"
    exit 0
fi

echo "Copy failed"
exit 1
