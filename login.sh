#!/usr/bin/env bash
# SSH into the workspace VM.
# Installs the kitty terminfo on the VM if missing, so backspace and tmux work.
# Also resyncs the VM clock via chrony (needs passwordless sudo for chronyc).
set -euo pipefail

USER_NAME="${VM_USER:-thomas}"
PORT="${VM_PORT:-2222}"
SSH_OPTS=(-p "$PORT")
TARGET="$USER_NAME@localhost"

if [[ "${TERM:-}" == "xterm-kitty" ]]; then
    if ! ssh "${SSH_OPTS[@]}" "$TARGET" 'infocmp xterm-kitty >/dev/null 2>&1'; then
        infocmp -x xterm-kitty | ssh "${SSH_OPTS[@]}" "$TARGET" \
            'mkdir -p ~/.terminfo && tic -x -o ~/.terminfo /dev/stdin'
    fi
fi

# The guest clock stops while the host sleeps; step it back in sync.
ssh "${SSH_OPTS[@]}" "$TARGET" 'sudo -n chronyc -a makestep >/dev/null 2>&1' || true

exec ssh "${SSH_OPTS[@]}" "$TARGET" "$@"
