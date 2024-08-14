#!/bin/bash

echo $HONEYPI_GIT_HOME_URL

cd $HOME
git init .
git remote add origin "$HONEYPI_GIT_HOME_URL"
git fetch --all
git reset --hard origin/main
cd - 