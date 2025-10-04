#!/bin/bash

## ########################################################################## ##
## generate a common archive
## - Collect the content of the *.tar.gz archives from all
##   selected list directories
## - generate a new *.tar.gz archiv file from this collection
##
## ########################################################################## ##
CALL="$1"

## includes:
source ./init--process-control
source ./lib/func_update-archive-handling

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_init_collection_dir
func_LIST_handling "${COMMON_ARCHIVE}"
func_rm_collection_dir

## -------------------------------------------------------------------------- ##
## pause:
[ "${CALL}" = "true" ] || { echo "Press enter to continue..."; read -r; }

## ########################################################################## ##
exit 0
