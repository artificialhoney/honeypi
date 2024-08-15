#!/bin/bash

sudo apt-get install git

git config --global user.name "$HONEYPI_GIT_USERNAME"
git config --global user.email "$HONEYPI_GIT_EMAIL"