#!/bin/bash

shift
echo "Running suite in '${HONEYPI_SUITE}' with '${@}'"
for arg in "${@}"
do
    if [[ -n $HONEYPI_SSH_URL ]]; then
    ssh $HONEYPI_SSH_URL "./install.sh -e ${HONEYPI_ENVIRONMENT} ${@}"
    else
    . "${HONEYPI_SUITE}/*-${arg}.sh"
    fi
done