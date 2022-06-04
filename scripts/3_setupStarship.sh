#!/bin/bash

DIR="/usr/local/bin"
if [ -d "$DIR" ]; then
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
else
mkdir $DIR
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
fi

ln -s starship.toml ~/.config
