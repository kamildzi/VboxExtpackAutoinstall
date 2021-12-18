#!/usr/bin/env bash
# @K.Dziuba
# Virtual Box Extension Pack Automatic (Re)Install Script

source src/IO/Print.sh
source src/System/Auth.sh

# main function
main() {
    init

    # version notice
    if [[ $VBOX_VERSION == '' ]]; then
        printError "Could not detect VirtualBox version!" \
            "(VERSION = '$VBOX_VERSION')"
        failExit
    else
        printText "Detected VirtualBox version: $VBOX_VERSION"
    fi

    # download new version
    printNotice "" "Downloading the extpack ..."
    wget "$REPOSITORY/$VBOX_VERSION/$FILE_NAME" -O "$SAVE_LOCATION" \
        && confirmSuccess || failExit

    # remove old version
    printNotice "" "Removing old extpack version ..."
    $authPrefix vboxmanage extpack uninstall "$INSTALL_NAME" \
        && confirmSuccess || failExit

    # install new version
    printNotice "" "Installing new extpack version ..."
    $authPrefix vboxmanage extpack install "$SAVE_LOCATION" \
        && confirmSuccess || failExit

    # all done
    printSuccess "" "Installation is done!"
    terminate
}

# print standard success message
confirmSuccess() {
    printSuccess "... OK!"
}

# fail and exit the script
failExit() {
    FLAG_FAILED=1
    printError "... Failed!"
    terminate
}

# returns the Virtual Box version 
getVboxVersion() {
    vboxmanage -v | cut -d'r' -f1
}

# pre-run function
init() {
    printInfo "[$0] Starting up ..."

    # traps
    trap terminate SIGINT SIGTERM ERR

    # init flags
    FLAG_FAILED=0
}

# post-run / terminate function
terminate() {
    printInfo "[$0] Terminating ..."

    # cleanup
    if [[ -f "$SAVE_LOCATION" ]]; then
        rm "$SAVE_LOCATION"
    fi

    if [[ FLAG_FAILED ]]; then
        exit 1
    else
        exit 0
    fi
}
