# workspace

This is a ubuntu25 workspace.

Preparation:

    brew install qemu

## On the host system

Build the VM:

	make build
	
Run the VM:

	./workspace

SSH into the VM:

    ssh <username>@localhost -p 2222

Or use the login script:

    ./login.sh

It reads `VM_USER` (default `thomas`) and `VM_PORT` (default `2222`) from the environment.

### Terminal problems (kitty)

If backspace does not work and tmux fails with `missing or unsuitable terminal: xterm-kitty`,
the VM has no terminfo entry for kitty. `login.sh` installs it automatically.
To do it by hand, run this once from kitty on the host:

    infocmp -x xterm-kitty | ssh -p 2222 <username>@localhost 'mkdir -p ~/.terminfo && tic -x -o ~/.terminfo /dev/stdin'

Alternatively, connect with a common terminal type:

    TERM=xterm-256color ssh <username>@localhost -p 2222

## On the guest system

Install ssh server:

    sudo apt install openssh-server

## Hot Keys

* uncapture mouse cursor: `ctrl + alt + g`
* exit full screen: `cmd + f`
