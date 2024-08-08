#!/bin/bash

POSITIONAL_ARGS=()

HONEYPI_HOME=${HONEYPI_HOME:-"$HOME/.honeypi"}
HONEYPI_MODULES_GIT=${HONEYPI_MODULES_GIT:-'https://github.com/artificialhoney/stacks'}
HONEYPI_SUITE=${HONEYPI_SUITE:-"./suite"}

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      echo "honeypi.sh (-e <ENVIRONMENT>) (-s <SSH_URL>) (init|install|run) (<ARGUMENTS>)"
      exit 0
      ;;
    -e|--environment)
      HONEYPI_ENVIRONMENT="$2"
      shift # past argument
      shift # past value
      ;;
    -s|--ssh)
      HONEYPI_SSH_URL="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

. dotenv.sh

if [[ $1 -eq 'init' ]]; then
    echo "Creating suite in '$HONEYPI_HOME'"
    if [[ -n $HONEYPI_SSH_URL ]]; then
      ssh $HONEYPI_SSH_URL "./init.sh"
    else
      ./init.sh
    fi
    exit 0
fi

if [[ $1 -eq 'install' ]]; then
    ./install.sh
    exit 0
fi

if [[ $1 -eq 'run' ]]; then
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
    exit 0
fi

echo "No task provided! Aborting"
exit 0

