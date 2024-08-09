#!/bin/bash

sudo apt-get install git

git config --global user.name "$STACKS_GIT_USERNAME"
git config --global user.email "$STACKS_GIT_EMAIL"