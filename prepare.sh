#!/usr/bin/env bash

PIP_CONF_URL="https://raw.githubusercontent.com/makkus/freckles-dev/master/.pip/pip.conf"
CONDA_CONF_URL="https://raw.githubusercontent.com/makkus/freckles-dev/master/.condarc"

PEM_CERT_URL="https://raw.githubusercontent.com/makkus/freckles-dev/master/certs/markus.pem"
CRT_CERT_URL="https://raw.githubusercontent.com/makkus/freckles-dev/master/certs/markus.crt"

function command_exists {
   type "$1" > /dev/null 2>&1 ;
}

function download {
        if command_exists wget; then
            wget --no-check-certificate -O $2 $1
        elif command_exists curl; then
            curl --insecure -o $2 $1
        else
            echo "Could not find 'wget' nor 'curl' to download files. Exiting..."
            exit 1
        fi
}

mkdir -p ~/.pip
cd ~/.pip

download "$PIP_CONF_URL" "pip.conf"

cd ~
download "$CONDA_CONF_URL" ".condarc"

mkdir -p ~/.certs
cd ~/.certs

download "$PEM_CERT_URL" "markus.pem"
download "$CRT_CERT_URL" "markus.crt"

sudo cp ~/.certs/markus.pem /usr/lib/ssl/certs
sudo cp ~/.certs/markus.crt /usr/local/share/ca-certificates/markus.crt
sudo update-ca-certificates
