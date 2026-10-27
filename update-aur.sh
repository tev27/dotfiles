AURDIR=AUR

cd
for aurpkg in $AURDIR/* ; do
    if [ -d "$aurpkg" ]; then
        makepkg -sicD $aurpkg --noconfirm
    fi
done
