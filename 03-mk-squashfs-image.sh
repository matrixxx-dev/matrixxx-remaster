#!/bin/bash

## ########################################################################## ##
## generate a squashfs image from a directory
## - Collect the content of the *.tar.gz archives from all
##   selected list directories
## - generate a squashfs image file from this collection
##
## ########################################################################## ##
CALL="$1"

## includes:
source ./init--process-control
source ./lib/func_update-archive-handling
source ./lib/func_mk-squasfs-image-handling

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_init_collection_dir
func_LIST_handling "${COMMON_CONTAINER}"
func_rm_collection_dir

## -------------------------------------------------------------------------- ##
## pause:
[ "${CALL}" = "true" ] || { echo "Press enter to continue..."; read -r; }

## ########################################################################## ##
exit 0
