#!/usr/bin/env bash
# @K.Dziuba
# Virtual Box Extension Pack Automatic (Re)Install Script - Message/Print functions

# Define colors (ANSI)
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_BLUE='\033[0;34m'
C_YELLOW='\033[1;33m'
C_PURPLE='\033[0;35m'
C_CYAN='\033[0;36m'
C_NC='\033[0m' # no-color

# Print error message
# $1, $2, ... - message text 
printError() {
    row=1
    while (( "$#" )); do
        if [[ row -eq '1' ]]; then
            >&2 echo -e "${C_RED} [ERROR] $1${C_NC}"
        else
            >&2 echo -e "${C_RED}         $1${C_NC}"
        fi
        shift
        ((row++))
    done
}

# Print warning message
# $1, $2, ... - message text 
printWarning() {
    row=1
    while (( "$#" )); do
        if [[ row -eq '1' ]]; then
            >&2 echo -e "${C_YELLOW} [WARNING] $1${C_NC}"
        else
            >&2 echo -e "${C_YELLOW}           $1${C_NC}"
        fi
        shift
        ((row++))
    done
}

# Print success message
# $1, $2, ... - message text 
printSuccess() {
    while (( "$#" )); do
        echo -e " ${C_GREEN}$1${C_NC}"
        shift
    done
}

# Print notice message
# $1, $2, ... - message text 
printNotice() {
    while (( "$#" )); do
        echo -e " ${C_PURPLE}$1${C_NC}"
        shift
    done
}

# Print info message
# $1, $2, ... - message text 
printInfo() {
    while (( "$#" )); do
        echo -e " ${C_CYAN}$1${C_NC}"
        shift
    done
}

# Print plain text message
# $1, $2, ... - message text 
printText() {
    while (( "$#" )); do
        echo -e " $1"
        shift
    done
}
