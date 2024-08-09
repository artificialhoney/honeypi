#!/bin/bash

POSITIONAL_ARGS=()

HONEYPI_SCOPE=stacks
HOST_MODULES=$(ls host | xargs -n 1 basename -s .sh)
APP_MODULES=$(ls apps | xargs -n 1 basename)
STACK_MODULES=$(ls stacks | xargs -n 1 basename)

while [[ $# -gt 0 ]]; do
  case $1 in
    -e|--environment)
      HONEYPI_ENVIRONMENT="$2"
      shift # past argument
      shift # past value
      ;;
    -s|--scope)
      HONEYPI_SCOPE="$2"
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

export HONEYPI_ENVIRONMENT=${HONEYPI_ENVIRONMENT:-"local"}
echo "Loading environment from '${HONEYPI_ENVIRONMENT}.env'"
[ -f $HONEYPI_ENVIRONMENT.env ] && eval export $(cat $HONEYPI_ENVIRONMENT.env)

if [[ $1 -eq "sync" ]]; then
  rsync . -chavzP --stats pi@$HONEYPI_HOST:/home/pi/honeypi
elif [[ -n $1 ]]; then
    echo "Creating home in '${HONEYPI_HOME}'"
    echo "Running in '${HONEYPI_SCOPE}' with '${@}'"
    if [[ $1 -eq 'host' ]]; then
      for arg in "${@:-$HOST_MODULES}"
      do
        . "./host/$arg.sh"
      done
    elif [[ $1 -eq 'apps' ]]; then
      for arg in "${@:-$APP_MODULES}"
      do
        docker-compose --env-file "${HONEYPI_ENVIRONMENT}.env" -f "./apps/$arg/docker-compose.yml" up -d
      done
    elif [[ $1 -eq 'stacks' ]]; then
      for arg in "${@:-$STACK_MODULES}"
      do
        docker-compose --env-file "${HONEYPI_ENVIRONMENT}.env" -f "./stacks/$arg/docker-compose.yml" up -d
      done
    fi
    exit 0
fi

echo "No scope provided"
exit 0