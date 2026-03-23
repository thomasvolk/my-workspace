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

## On the guest system

Install ssh server:

    sudo apt install openssh-server

