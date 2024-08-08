#!/bin/bash

SCRIPTS=( 01-fish 02-portainer 03-cockpit 04-home 05-samba )
SCRIPTS_BASE=./scripts

. $SCRIPTS_BASE/00-init.sh

for i in "${array[@]}"
do
    $SCRIPTS_BASE/$i.sh
done

