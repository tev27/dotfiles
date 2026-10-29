#!/bin/bash

source ./install-base.sh # vars

cd
for aurpkg in $AURDIR/* ; do
    if [ -d "$aurpkg" ]; then
	    echo "updating $aurpkg"
        cd $aurpkg
        git reset --hard HEAD
        git pull
        makepkg -sic --noconfirm
    fi
done
