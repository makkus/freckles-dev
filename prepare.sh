#!/usr/bin/env bash

PIP_CONF_URL=
CONDA_CONF_URL=

function download {
    {
        if command_exists wget; then
            wget -O $2 $1
        elif command_exists curl; then
            curl -o $2 $1
        else
            echo "Could not find 'wget' nor 'curl' to download files. Exiting..."
            exit 1
        fi
    } >> "$SCRIPT_LOG_FILE"
}

mkdir ~/.pip
cd ~/.pip

download "$PIP_CONF_URL"

cd ~
download "$CONDA_CONF_URL"
