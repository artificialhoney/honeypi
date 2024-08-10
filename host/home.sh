#!/bin/bash

cd $HOME
git init .
git remote add origin $HONEYPI_HOME_GIT_URL
git fetch --all
git reset --hard origin/main
cd - 