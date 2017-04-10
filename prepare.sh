#!/usr/bin/env bash

PIP_CONF_URL="https://raw.githubusercontent.com/makkus/freckles-dev/master/.pip/pip.conf"
CONDA_CONF_URL="https://raw.githubusercontent.com/makkus/freckles-dev/master/.condarc"

PEM_CERT_URL="https://raw.githubusercontent.com/makkus/freckles-dev/master/certs/markus.pem"
CRT_CERT_URL="https://raw.githubusercontent.com/makkus/freckles-dev/master/certs/markus.crt"

function command_exists {
   s type "$1" > /dev/null 2>&1 ;
}

function download {
        if command_exists wget; then
            wget -O $2 $1
        elif command_exists curl; then
            curl -o $2 $1
        else
            echo "Could not find 'wget' nor 'curl' to download files. Exiting..."
            exit 1
        fi
}

mkdir -p ~/.pip
cd ~/.pip

download "$PIP_CONF_URL"

cd ~
download "$CONDA_CONF_URL"

mkdir -p ~/.certs
cd ~/.certs

download "$PEM_CERT_URL"
download "$CRT_CERT_URL"

sudo cp ~/.certs/markus.crt /usr/local/share/ca-certificates/markus.crt
sudo update-ca-certificates
