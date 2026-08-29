#!/bin/bash

set -e

mkdir -p $HOME/.bin

mkdir -p $HOME/git

# shell
if [ ! -d $HOME/git/my-shell ]; then
  (cd $HOME/git && git clone https://github.com/thomasvolk/my-shell.git)
fi
(cd $HOME/git/my-shell && ./bootstrap.sh)

# install ocaml and opam
opam init --auto-setup --disable-sandboxing

# define environment
cat << EOF >> $HOME/.env_local
export PATH="\$HOME/.opam/default/bin:\$PATH"

eval \$(opam config env)
EOF

source $HOME/.env

# tmux
if [ ! -d $HOME/git/my-tmux-config ]; then
  (cd $HOME/git && git clone https://github.com/thomasvolk/my-tmux-config.git)
  if [ -f $HOME/.tmux.conf ]; then
    mv $HOME/.tmux.conf $HOME/.tmux.conf_BAK
  fi
  ln -s $HOME/git/my-tmux-config/dot_tmux.conf $HOME/.tmux.conf
fi

# emacs
if [ ! -d $HOME/git/my-emacs-config ]; then
  (cd $HOME/git && git clone https://github.com/thomasvolk/my-emacs-config.git)
  (cd $HOME/git/my-emacs-config && make)
fi

# neovim
if [ ! -d $HOME/git/my-neovim-config ]; then
  (cd $HOME/git && git clone https://github.com/thomasvolk/my-neovim-config.git)
  if [ ! -d $HOME/.config ]; then
    mkdir -p $HOME/.config
  fi
  if [ -d $HOME/.config/nvim ]; then
    mv $HOME/.config/nvim $HOME/.config/nvim_BAK
  fi
  ln -s $HOME/git/my-neovim-config/nvim $HOME/.config/nvim
fi

# software
pip install 'python-lsp-server[all]' pylint
pip install uv
npm install -g @github/copilot-language-server
npm install -g tree-sitter-cli
npm i -g bash-language-server
eval $(opam config env)
opam install -y ocamlformat-rpc ocamlformat ocaml-lsp-server utop
