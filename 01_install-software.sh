#!/bin/bash

set -e

sudo apt update && sudo apt upgrade -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    tmux \
    neovim \
    emacs \
    git \
    curl \
    zsh \
    build-essential \
    aspell aspell-en aspell-de \
    nodejs \
    ripgrep \
    jq \
    python3-venv \
    opam \
    guile-3.0 \
    pandoc
