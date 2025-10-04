#!/bin/bash

## ########################################################################## ##
## Copy all *.deb files from /var/cache/apt/archives to new directory
##
## ########################################################################## ##
SOURCE_PATH="/var/cache/apt/archives"
DEST_PATH="./NEW.deb"

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
echo "Move all *.deb files from ${SOURCE_PATH} to ${DEST_PATH}"
[ -d "${DEST_PATH}" ] && { read -rp "${DEST_PATH} does exist!"; exit 1; }

mkdir -p "${DEST_PATH}"
cp -f "${SOURCE_PATH}"/*.deb "${DEST_PATH}"/
sudo rm -f "${SOURCE_PATH}"/*.deb

## -------------------------------------------------------------------------- ##
## pause:
echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
