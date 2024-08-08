#!/bin/bash

[ -f $HONEYPI_ENVIRONMENT.env ] && export $(grep -v '^#' $HONEYPI_ENVIRONMENT.env | xargs)

sudo apt update
