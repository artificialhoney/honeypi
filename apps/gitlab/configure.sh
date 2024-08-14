#!/bin/bash

cd /home/git
sudo -u git -H git clone https://gitlab.com/gitlab-org/gitlab-pages.git
cd gitlab-pages
sudo -u git -H git checkout v$(</home/git/gitlab/GITLAB_PAGES_VERSION)
sudo -u git -H make