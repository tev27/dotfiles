#!/bin/bash

source ./install-base.sh # vars

cd
for aurpkg in ~/$AURDIR/* ; do
    if [[ -d "$aurpkg" ]]; then
        echo "updating $aurpkg"
        cd $aurpkg
        LOCAL=$(git rev-parse @)
        REMOTE=$(git rev-parse origin)
        if [ $LOCAL != $REMOTE ]; then
            git merge origin
            makepkg -sic --noconfirm
	else
            echo "already up to date"
	fi
    fi
done
