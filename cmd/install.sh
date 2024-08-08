#!/bin/bash

shift
cd $HONEYPI_HOME
if [[ -n $1 ]]; then
    echo "Checking install interface"
    cd modules
    if [[ -t "./install.sh" ]]; then
        echo "Found 'install.sh'. Installing! "
        if [[ -n $HONEYPI_SSH_URL ]]; then
            ssh $HONEYPI_SSH_URL "./install.sh -e ${HONEYPI_ENVIRONMENT} ${@}"
        else
            ./install.sh -e ${HONEYPI_ENVIRONMENT} ${@}
        fi
    fi
fi
