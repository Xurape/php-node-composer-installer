# PHP8.1, NodeJS and Composer installer
Tired of manually throwing commands into your terminal to download these 3 fundamental packages for web development? Just use this script and save your precious time! :D

## How does it work?
This script runs a serie of commands that you'd probably run by yourself but just a lot more faster.

## Table of contents

- [Installation](#installation)
- [Found any bugs?](#bugs)
- [Licensing](#licensing)
- [Note](#note)

## Installation

To install the script, simply run the following command (considering you have wget installed on your system. If not, just run **sudo apt install wget**):
```sh
wget -qO- https://raw.githubusercontent.com/Xurape/php-node-composer-installer/main/install.sh | bash
```

If the code above doesn't work, try using the one below:

```sh
# Download the file and make it an executable
root@xuap:~# wget https://raw.githubusercontent.com/Xurape/php-node-composer-installer/main/install.sh | chmod +x ./install.sh

# Start the installer
root@xuap:~# ./install.sh
```

## Licensing
Check the license for this script [here](./LICENSE)

## Bugs
If you've found any considerable bugs, please contact me through some of these ways:
- Email: joaoferreira@reduxpanel.com
- Discord: Xuap#3581

## Note
I know my code in shell isn't the best but hey, better something that works than nothing :D (I accept any tip on how to improve my code!)
