#!/bin/bash

## ########################################################################## ##
## generate a single archive for every list entry in selected sub directory
## - Copy the *.tar.gz archives from  a list entry to a new *.tar.gz
##   archiv file - now with the name of the sub directory
##
## ########################################################################## ##
CALL="$1"

## includes:
source ./init--process-control
source ./lib/func_update-archive-handling

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_LIST_handling "${SINGLE_ARCHIVE}"

## -------------------------------------------------------------------------- ##
## pause:
[ "${CALL}" = "true" ] || { echo "Press enter to continue..."; read -r; }

## ########################################################################## ##
exit 0
