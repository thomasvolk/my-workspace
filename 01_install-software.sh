#!/bin/bash

set -e

sudo apt update && sudo apt upgrade -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    tmux \
    neovim \
    ripgrep \
    lazygit \
    emacs \
    xclip \
    git \
    curl \
    zsh \
    build-essential \
    aspell aspell-en aspell-de \
    ripgrep \
    jq \
    python3-venv \
    opam \
    guile-3.0 \
    pandoc \
    thunderbird \
    sc-im \
    mc \
    gdu \
    htop \
    mutt

sudo apt autoremove -y

sudo snap install rclone
sudo snap install brave
