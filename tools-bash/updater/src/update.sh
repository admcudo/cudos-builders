#!/bin/bash -i

if [ "$EUID" -ne 0 ]; then
    echo -e "\033[1;31mError:\033[m The script MUST be executed as root";
    exit 1
fi

updaterPath=$(basename $(pwd))
if [ "$updaterPath" != "updater" ]; then
    echo -e "\033[1;31mError:\033[m The script MUST be executed from updater folder";
    exit 1
fi

source "./src/incs/var.sh"

source "$WORKING_SRC_DIR/incs/utils.sh"

# get the current stage of source folders

source "$WORKING_SRC_DIR/incs/validate-upgrade.sh"

# export

# migrate

echo "" # new line

echo -ne "Starting...";
echo -e "${STYLE_GREEN}DONE${STYLE_DEFAULT}";