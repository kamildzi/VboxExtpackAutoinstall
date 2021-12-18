#!/usr/bin/env bash
# @K.Dziuba
# Virtual Box Extension Pack Automatic (Re)Install Script - The Runner

# ==============
# Paths config
# ==============
SCRIPT_ROOT=$( readlink -f $( dirname "${BASH_SOURCE[0]}" ) )

# ==============
# Sources
# ==============
source src/VboxExtpackAutoinstall.sh
source config.sh

# ==================
# Invoke the script
# ==================
autoSetAuthPrefix
set -eu
main
