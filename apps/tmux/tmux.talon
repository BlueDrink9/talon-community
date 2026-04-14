app: tmux
-

tag(): user.splits
tag(): user.tabs

# Note that you will need to add something to match the tmux app in your configuration
# This is not active by default
# Adding a file with a matcher for detecting tmux active in your terminal and activating
# the tmux tag is required
# Something like:
#
# title: /^tmux/
# -
# tag(): user.tmux
#
# Alternatively, just force the tag in your terminal (will be permanently active and may break terminal tab commands):
#
# tag: terminal
# -
# tag(): user.tmux

mux: "tmux "
mux please: user.tmux_enter_command('')

# Several of these are redundant with existing user actions (also implemented), but names are probably more intuitive to experienced tmux users, because they use the tmux terms rather than closest-match community analogues. E.g. windows instead of tabs.

#session management
mux new session: insert("tmux new ")
mux sessions: user.tmux_execute_command("choose-tree -s")
mux name session: user.tmux_execute_command("command-prompt -I '#S' 'rename-session %%'")
mux kill session: user.tmux_execute_command("kill-session -t")
mux session previous: user.tmux_execute_command("switch-client -p")
mux session next: user.tmux_execute_command("switch-client -n")

#window management
# tab_open
mux new window: user.tmux_execute_command("new-window")
# tab_jump
mux window <number>: user.tmux_execute_command("select-window -t {number}")
# tab_previous
mux window previous: user.tmux_execute_command("previous-window")
# tab_next
mux window next: user.tmux_execute_command("next-window")
mux window rename: user.tmux_execute_command("command-prompt -I '#W' 'rename-window %%'")
# tab_close
mux window close: user.tmux_execute_command("confirm-before -p 'kill-window #W? (y/n)' kill-window")

#pane management
mux split horizontal: user.tmux_execute_command("split-window -h")
mux split vertical: user.tmux_execute_command("split-window -v")
split swap next: user.tmux_execute_command("swap-pane -U")
split swap previous: user.tmux_execute_command("swap-pane -D")
mux swap pane: user.tmux_execute_command("swap-pane -U")
mux swap pane reverse: user.tmux_execute_command("swap-pane -D")

mux close pane: user.tmux_execute_command("confirm-before -p 'kill-pane #P? (y/n)' kill-pane")


# split_jump
#Say a number right after this command, to switch to pane
mux pane numbers: user.tmux_execute_command("display-panes")

# Focus split directionally
go pane <user.arrow_key> | go split <user.arrow_key>:
    flag = user.tmux_direction_flag(arrow_key)
    user.tmux_execute_command("select-pane {flag}")

mux zoom: user.tmux_execute_command("resize-pane -Z")
mux copy mode: user.tmux_execute_command("copy-mode")
mux paste that: user.tmux_execute_command("paste-buffer")
mux last window: user.tmux_execute_command("last-window")
mux break pane: user.tmux_execute_command("break-pane")
# Pull the previously active pane from another window into the current window
mux join pane: user.tmux_execute_command("join-pane")
# Pull a pane from a specific window number into the current window (e.g., "join pane 2")
mux join pane <number>: user.tmux_execute_command("join-pane -s :{number}")
mux clock: user.tmux_execute_command("clock-mode")
mux suspend: user.tmux_execute_command("detach-client")
mux reload config: user.tmux_execute_command("source-file ~/.tmux.conf")

# Resize panes (e.g., "pane resize up 5")
mux pane resize <user.arrow_key> <number_small>:
    flag = user.tmux_direction_flag(arrow_key)
    user.tmux_execute_command("resize-pane {flag} {number_small}")

# --- Navigation & Search ---
mux window hunt: user.tmux_execute_command("find-window")
mux clip history: user.tmux_execute_command("choose-buffer")

# --- Window Management ---
window move left: user.tmux_execute_command("swap-window -d -t -1")
window move right: user.tmux_execute_command("swap-window -d -t +1")
