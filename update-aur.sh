#!/bin/bash

source ./install-base.sh # vars

cd
for aurpkg in ~/$AURDIR/* ; do
  if [[ -d "$aurpkg" ]]; then
    cd $aurpkg
    git fetch
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse origin)
    if [ $LOCAL != $REMOTE ]; then
      git diff $LOCAL $REMOTE
      read -p "update $aurpkg? [ync]: " yn
      case $yn in
	[Yy]*)
	  git merge origin
	  makepkg -sic --noconfirm;;
	[Nn]*)
	  echo "skipping $aurpkg";;
	[Cc]*)
	  echo "quitting script"
	  return || exit;;
      esac
    else
      echo "nothing to do in $aurpkg"
    fi
  fi
done
