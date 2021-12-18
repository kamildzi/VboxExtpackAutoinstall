#!/usr/bin/env bash
# @K.Dziuba
# Virtual Box Extension Pack Automatic (Re)Install Script - System/Auth functions

# sets the $authPrefix, if given binary exists
# $1 - binary file
setAuthPrefix() {
    if which "$1" | read; then
        authPrefix="$1"
    else
        printWarning "$1 not found! Skipping..."
    fi
}

# uses setAuthPrefix() to auto-set the $authPrefix defined in the config
autoSetAuthPrefix() {
    authPrefix=''

    # Sudo support
    if [[ $authWithSudo == 'yes' ]]; then
        setAuthPrefix sudo
    fi

    # Zensu support
    if [[ $authWithZensu == 'yes' ]]; then
        setAuthPrefix zensu
    fi

    # Gksu support
    if [[ $authWithGksu == 'yes' ]]; then
        setAuthPrefix gksu
    fi

    # Polkit/pkexec support
    if [[ $authWithPkexec == 'yes' ]]; then
        setAuthPrefix pkexec
    fi
}
