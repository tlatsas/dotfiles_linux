#!/bin/bash

_sed=$(which sed) || exit 1
_inplace=""
_f="${1}"

# edit in place if first argument is "-i"
if [[ "${1}" == "-i" ]]
then
  _inplace="${1}"
  _f="${2}"
fi

$_sed $_inplace 's/$//g' "${_f}"

# vim: ts=2 sw=2 sts=2 et:
