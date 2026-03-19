#!/bin/bash

set -e

apt update && apt upgrade -y

apt install -y \
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
    python3-venv
    opam \
    guile-3.0 \
    pandoc
