#!/bin/bash

while getopts "" opt; do
  case $opt in
  esac
done

shift $((OPTIND - 1))

if [[ $# -ne 0 ]]; then
  echo "bad options"
  exit
fi

echo "def"
