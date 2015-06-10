#!/bin/sh

NAME=pyax12
VERSION=$(cat VERSION)
DIST_DIR=dist

rm -rf debian

# TODO
mkdir -p     debian/usr/local/lib/python3.0/dist-packages
cp -r pyax12 debian/usr/local/lib/python3.0/dist-packages
chmod 644    $(find debian/usr/local/lib -type f)

mkdir -p      "debian/usr/share/doc/$NAME/"
cp COPYING    "debian/usr/share/doc/$NAME/copyright"
chmod 644     "debian/usr/share/doc/$NAME/copyright"

mkdir -p debian/DEBIAN

# section list : http://packages.debian.org/stable/
cat > debian/DEBIAN/control << EOF
Package: $NAME
Version: $VERSION
Section: libs
Priority: optional
Maintainer: Jérémie DECOCK <jd.jdhp@gmail.com>
Architecture: all
Depends: python (>= 3.0), python3-serial
Description: A library to control dynamixel AX-12+ servos with python
EOF

fakeroot dpkg-deb -b debian

mkdir -p "$DIST_DIR"
mv debian.deb "$DIST_DIR/${NAME}_${VERSION}_all.deb"