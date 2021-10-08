#!/bin/bash

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Installing dotfiles for the first time"
    git clone --depth=1 https://github.com/archervanderwaal/dotfiles.git "$HOME/.dotfiles"
    cd "$HOME/.dotfiles"
    rake install
else 
    echo "dotfiles is already installed"
fi



