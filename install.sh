#!/bin/bash

# Colors
BOLD="$(tput bold 2>/dev/null || echo '')"
GREY="$(tput setaf 0 2>/dev/null || echo '')"
UNDERLINE="$(tput smul 2>/dev/null || echo '')"
RED="$(tput setaf 1 2>/dev/null || echo '')"
GREEN="$(tput setaf 2 2>/dev/null || echo '')"
YELLOW="$(tput setaf 3 2>/dev/null || echo '')"
BLUE="$(tput setaf 4 2>/dev/null || echo '')"
MAGENTA="$(tput setaf 5 2>/dev/null || echo '')"
CYAN="$(tput setaf 6 2>/dev/null || echo '')"
NO_COLOR="$(tput sgr0 2>/dev/null || echo '')"

# Color functions
function greenMessage() {
    echo -e "\\033[32;1m${*}\\033[0m"
}

function magentaMessage() {
    echo -e "\\033[35;1m${*}\\033[0m"
}

function cyanMessage() {
    echo -e "\\033[36;1m${*}\\033[0m"
}

function redMessage() {
    echo -e "\\033[31;1m${*}\\033[0m"
}

function yellowMessage() {
    echo -e "\\033[33;1m${*}\\033[0m"
}

function errorQuit() {
    errorExit 'Leaving!'
}

function errorExit() {
    redMessage "${@}"
    exit 1
}

function errorContinue() {
    redMessage "> Invalid Choose."
    return
}

# Start
redMessage "-------------------------------------------------------"
redMessage "|                                                     |"
redMessage "|              PHP8.1, NodeJS and Composer            |"
redMessage "|                      installer                      |"
redMessage "|                  github.com/xurape                  |"
redMessage "|                                                     |"
redMessage "-------------------------------------------------------"
echo ""
yellowMessage "Checking if sudo and curl are installed in the system..\n"

sleep 1

# Check if sudo is installed
if [ "$(dpkg -l | awk '/sudo/ {print }' | wc -l)" -ge 1 ]; then
    greenMessage "> Sudo: OK"
else
    apt-get install sudo
fi

# Check if curl is installed
if [ "$(dpkg -l | awk '/curl/ {print }' | wc -l)" -ge 1 ]; then
    greenMessage "> Curl: OK"
else
    sudo apt-get install curl
fi

# Get confirmation
magentaMessage "Do you wish to continue? [Y/n]\n"
read answer

# Install
if [ "$answer" != "${answer#[Yy]}" ]; then
    clear

    sudo apt-get install gnupg2
    ## Start downloading necessary packages
    sudo apt install -y lsb-release ca-certificates apt-transport-https software-properties-common

    # Add Surý to source list
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list

    greenMessage "\n> Packages added to the source list sucessfully.\n"

    # Import packages signing GPG key;
    curl -fsSL  https://packages.sury.org/php/apt.gpg| sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/sury-keyring.gpg

    greenMessage "\n> Packages sucessfully imported.\n"

    ## Update with all the packages imported
    sudo apt update

    greenMessage "\n> Packages sucessfully updated.\n"

    yellowMessage "\nInstalling PHP8.1...\n"

    sudo apt install php8.1-fpm php8.1-common php8.1-mysql php8.1-xml php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-dev php8.1-imap php8.1-mbstring php8.1-opcache php8.1-soap php8.1-zip php8.1-intl php8.1-bcmath

    greenMessage "\nPHP 8.1 sucessfully installed!\n"

    yellowMessage "\nInstalling NVM...\n"

    # Download NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

    greenMessage "\nNVM sucessfully downloaded!\n"

    # Source the path list
    source ~/.bashrc

    greenMessage "\nNVM sucessfully added to path list!\n"

    yellowMessage "\nInstalling Node & NPM...\n"

    # Install node 18 & npm 8
    nvm install 18.0.0

    # Check installed versions
    cmd1=$(node --version)
    cmd2=$(npm --version)

    greenMessage "\nNode ($cmd1) and NPM ($cmd2) sucessfully installed!\n"

    yellowMessage "\nInstalling composer...\n"

    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

    greenMessage "\nComposer installer downloaded sucessfully!\n"

    php composer-setup.php

    php -r "unlink('composer-setup.php');"
 
    yellowMessage "\nDeleting composer installer...\n"

    sudo mv composer.phar /usr/local/bin/composer

    # Check composer version
    cmd3=$(composer --version)

    greenMessage "\nComposer ($cmd3) sucessfully installed!\n"

    redMessage "\n\n-- Installation details in 2 seconds.. --"

    sleep 2

    # Check php version
    cmd4=$(php -v)

    echo ""
    echo ""
    redMessage "-------------------------------------------------------"
    redMessage "|                                                     |"
    redMessage "|              PHP8.1, NodeJS and Composer            |"
    redMessage "|                      installer                      |"
    redMessage "|                  github.com/xurape                  |"
    redMessage "|                                                     |"
    redMessage "-------------------------------------------------------"
    echo ""
    echo ""
    greenMessage "> PHP8.1 sucessfully installed."
    cyanMessage "Actual Version: $cmd4"
    echo ""
    echo ""
    greenMessage "> NodeJS & NPM installed sucessfully."
    cyanMessage "Actual Version: $cmd1"
    cyanMessage "Actual Version: (NPM): $cmd2"
    echo ""
    echo ""
    greenMessage "> Composer sucessfully installed."
    cyanMessage "Actual Version: $cmd3"
    echo ""
    echo ""
    greenMessage "               Liked it? Give me star :D"
    redMessage   "  https://github.com/xurape/php-node-composer-installer"
    echo ""
    exit 1
else
    redMessage "Aborted."
    exit 1
fi
