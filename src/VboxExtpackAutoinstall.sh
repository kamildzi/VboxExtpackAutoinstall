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

    testLowerVersion=$(getLowerVersion 7.1.0 $VBOX_VERSION)

    if [[ $testLowerVersion == "7.1.0" ]]; then
        # version is equal or higher then "7.1.0"
        printText "(detected version is is equal or higher then '7.1.0')"
        FILE_NAME="$FILE_NAME_v7_1_x"
    fi

    if [[ ! -d "$SAVE_LOCATION_DIR" ]]; then
        printError "Not a directory: '$SAVE_LOCATION_DIR'!"
        failExit
    fi
    SAVE_LOCATION="$SAVE_LOCATION_DIR/$FILE_NAME"

    # download new version
    printNotice "" "Downloading the extpack ..."
    wget "$REPOSITORY/$VBOX_VERSION/$FILE_NAME" -O "$SAVE_LOCATION" \
        && confirmSuccess || failExit

    # remove old version
    printNotice "" "Trying to remove old extpack version ..."
    $authPrefix vboxmanage extpack cleanup
    $authPrefix vboxmanage extpack uninstall "$INSTALL_NAME" && confirmSuccess
    $authPrefix vboxmanage extpack uninstall "$INSTALL_NAME_v7_1_x" && confirmSuccess
    $authPrefix vboxmanage extpack cleanup

    # install new version
    printNotice "" "Installing new extpack version ..."
    $authPrefix vboxmanage extpack install "$SAVE_LOCATION" \
        && confirmSuccess || failExit

    # all done
    printSuccess "" "Installation is done!"
    terminate
}

# Version comparator. Prints the lower version (e.g. 7.0.0).
# $1 - version text (e.g. 7.0.0)
# $1 - version text (e.g. 7.1.0)
getLowerVersion(){ 
    echo -e "$1\n$2" | sort -V | head -n1
}

# Version comparator. Prints the higher version (e.g. 7.1.0).
# $1 - version text (e.g. 7.0.0)
# $1 - version text (e.g. 7.1.0)
getHigherVersion(){ 
    echo -e "$1\n$2" | sort -rV | head -n1
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
