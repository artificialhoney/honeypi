#!/bin/bash

mkdir -p $HONEYPI_HOME
sudo apt install git build-essential
git clone $HONEYPI_MODULES_GIT modules

HONEYPI_SUITE_INIT="${$HONEYPI_SUITE}/init.sh"
if [[ -t $HONEYPI_SUITE_INIT ]]; then
    . "${HONEYPI_SUITE_INIT}"
fi