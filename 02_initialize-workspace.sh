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

#nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
source $HOME/.nvm/nvm.sh
nvm install node



# install ocaml and opam
opam init --auto-setup --disable-sandboxing

# define environment
cat << EOF > $HOME/.env
export PATH="\$HOME/.bin:\$HOME/.config/emacs/bin:\$HOME/.opam/default/bin:\$PATH"
export EDITOR_AI=copilot

source \$HOME/python3/bin/activate
source \$HOME/.nvm/nvm.sh

alias e='emacs -nw'
alias ec='emacsclient'
alias ed='emacs --daemon'

alias v=nvim

eval \$(opam config env)
EOF

source $HOME/.env

if grep -qF "source $HOME/.env" $HOME/.zshrc; then
  echo ".env already added to .zshrc"
else
  echo "add .env to .zshrc"
  echo "source $HOME/.env" >> $HOME/.zshrc
fi

mkdir -p $HOME/.bin

mkdir -p $HOME/git

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
