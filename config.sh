#!/usr/bin/env bash
# @K.Dziuba
# Virtual Box Extension Pack Automatic (Re)Install Script - Config File


# ===========================
#  General settings
# ===========================

# VirutalBox version (i.e. "6.1.30")
VBOX_VERSION="`getVboxVersion`"

# download source
REPOSITORY="https://download.virtualbox.org/virtualbox"
FILE_NAME="Oracle_VM_VirtualBox_Extension_Pack-$VBOX_VERSION.vbox-extpack"

# save location (will be removed automaticaly)
SAVE_LOCATION="/tmp/$FILE_NAME"

# package name (will be use for removing the old Extension Pack version)
INSTALL_NAME="Oracle VM VirtualBox Extension Pack"


# ===================================
#  Auth settings
# ===================================
# enable root authentication types
# -----------------------------------

# enable for sudo authentication (recommended for Terminal)
authWithSudo='yes'

# enable for polkit/pkexec authentication (GUI only)
# authWithPkexec='yes'

# enable for zensu authentication
# authWithZensu='yes'

# enable for gksu authentication
# authWithGksu='yes'
