#!/bin/bash

set -e

# install ohmyzsh
if [ ! -d $HOME/.oh-my-zsh ]; then
  if [ -f $HOME/.zshrc ]; then
      mv $HOME/.zshrc $HOME/.zshrc_bak
  fi
  sh -c "RUNZSH=no $(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --skip-chsh"
fi

# install python3
python3 -m venv $HOME/python3
source $HOME/python3/bin/activate
pip install --upgrade pip

# install ocaml and opam
opam init --auto-setup --disable-sandboxing

# define environment
cat << EOF > $HOME/.env
export PATH="$HOME/.bin:$HOME/.config/emacs/bin:$PATH"
export EDITOR_AI=copilot

alias e='emacs -nw'
alias ec='emacsclient'
alias ed='emacs --daemon'

alias v=nvim
EOF

echo "source $HOME/.env" >> $HOME/.zshrc
