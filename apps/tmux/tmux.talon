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

# Several of these are redundant with existing user actions, but these might be
# differently reliable because they rely on keybindings rather than commands.
# The names are probably more intuitive to experienced tmux users, because they use the tmux terms rather than closest-match community analogues. E.g. windows instead of tabs.

#session management
mux new session: insert("tmux new ")
mux sessions: user.tmux_keybind('s')
mux name session: user.tmux_keybind('$')
mux kill session: user.tmux_execute_command("kill-session -t")
mux session previous: user.tmux_keybind('(')
mux session next: user.tmux_keybind(')')

#window management
# tab_open
mux new window: user.tmux_keybind('c')
# tab_jump
mux window <number>: user.tmux_keybind(number)
# tab_previous
mux window previous: user.tmux_keybind('p')
# tab_next
mux window next: user.tmux_keybind('n')
mux window rename: user.tmux_keybind(',')
# tab_close
mux window close: user.tmux_keybind('&')

#pane management
mux split horizontal: user.tmux_keybind('%')
mux split vertical: user.tmux_keybind('"')
split move left: user.tmux_keybind('{')
split move right: user.tmux_keybind('}')
mux swap pane: user.tmux_keybind('{')
mux swap pane reverse: user.tmux_keybind('}')
mux move <user.arrow_key>: user.tmux_keybind(arrow_key)
mux close pane: user.tmux_keybind('x')
# split_jump
#Say a number right after this command, to switch to pane
mux pane numbers: user.tmux_keybind('q')

# Focus split directionally
go pane <user.arrow_key>: user.tmux_keybind(arrow_key)


mux zoom: user.tmux_keybind('z')
mux copy mode: user.tmux_keybind('[')
mux paste that: user.tmux_keybind(']')
mux last window: user.tmux_keybind('l')
mux break pane: user.tmux_keybind('!')
mux clock: user.tmux_keybind('t')
mux suspend: user.tmux_keybind('d')
mux reload config: user.tmux_execute_command("source-file ~/.tmux.conf")
