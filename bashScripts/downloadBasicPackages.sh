#!/bin/bash
# this should be executed in the main folder like: sh bashScripts/downloadBasicPackages.sh
# initializes/clones all packages in src/ (git submodules)
# make sure you have access via SSH keys

git submodule update --init --recursive