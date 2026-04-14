from talon import Context, Module, actions, settings

mod = Module()

mod.apps.tmux = """
tag: terminal
and tag: user.tmux
"""

mod.setting(
    "tmux_prefix_key",
    type=str,
    default="ctrl-b",
    desc="Tmux prefix key option, if change like `set-option -g prefix C-b`",
)

mod.setting(
    "tmux_command_key",
    type=str,
    default=":",
    desc="The key used after the tmux prefix to enter commands (bound to `command-prompt`)",
)

TMUX_DEFAULT_BINDINGS = {
    # Window Management
    "new-window": "c",
    "kill-window": "&",
    "rename-window": ",",
    "previous-window": "p",
    "next-window": "n",
    "last-window": "l",
    "find-window": "f",
    "choose-tree -w": "w",
    # Pane Management
    "split-window -h": "%",
    "split-window -v": '"',
    "kill-pane": "x",
    "break-pane": "!",
    "resize-pane -Z": "z",
    "display-panes": "q",
    "swap-pane -U": "{",
    "swap-pane -D": "}",
    # Session Management
    "choose-tree -s": "s",
    "rename-session": "$",
    "switch-client -p": "(",
    "switch-client -n": ")",
    "detach-client": "d",
    # Copy & Buffers
    "copy-mode": "[",
    "paste-buffer": "]",
    "choose-buffer": "=",
    # Misc
    "clock-mode": "t",
}


@mod.action_class
class TmuxActions:
    def tmux_prefix():
        """press control and the configured tmux prefix key"""
        actions.key(settings.get("user.tmux_prefix_key"))

    def tmux_keybind(key: str):
        """press tmux prefix followed by a key bind"""
        actions.user.tmux_prefix()
        actions.key(key)

    def tmux_enter_command(command: str = ""):
        """Enter tmux command mode and optionally insert a command without executing it."""
        actions.user.tmux_keybind(settings.get("user.tmux_command_key"))
        actions.insert(command)

    def tmux_execute_command(command: str):
        """execute tmux command"""
        actions.user.tmux_enter_command(command)
        actions.key("enter")
        actions.sleep("100ms")

    def tmux_execute_command_with_confirmation(command: str, confirmation_prompt: str):
        """execute tmux command with confirm-before"""
        actions.user.tmux_execute_command(
            f'confirm-before -p "{confirmation_prompt} (y/n)" {command}'
        )
        actions.key("\n")

    def tmux_direction_flag(arrow_key: str) -> str:
        """Map arrow key to tmux direction flag (-U, -D, -L, -R)"""
        return {
            "up": "-U",
            "down": "-D",
            "left": "-L",
            "right": "-R",
        }.get(arrow_key, "")


ctx = Context()
ctx.matches = "app: tmux"


@ctx.action_class("app")
class AppActions:
    def tab_open():
        actions.user.tmux_execute_command("new-window")

    def tab_next():
        actions.user.tmux_execute_command("select-window -n")

    def tab_previous():
        actions.user.tmux_execute_command("select-window -p")


@ctx.action_class("user")
class UserActions:
    def tab_jump(number: int):
        if number < 10:
            actions.user.tmux_keybind(f"{number}")
        else:
            actions.user.tmux_execute_command(f"select-window -t {number}")

    def tab_close_wrapper():
        actions.user.tmux_execute_command_with_confirmation(
            "kill-window", "kill-window #W?"
        )

    def split_window_right():
        actions.user.split_window_horizontally()
        actions.user.tmux_execute_command("swap-pane -U -s #P")

    def split_window_left():
        actions.user.split_window_horizontally()

    def split_window_down():
        actions.user.split_window_vertically()
        actions.user.tmux_execute_command("swap-pane -U -s #P")

    def split_window_up():
        actions.user.split_window_vertically()

    def split_flip():
        actions.user.tmux_execute_command("next-layout")

    def split_window_vertically():
        actions.user.tmux_execute_command("split-pane")

    def split_window_horizontally():
        actions.user.tmux_execute_command("split-pane -h")

    def split_maximize():
        # toggle the maximization because zooming when already zoomed is pointless
        actions.user.tmux_execute_command("resize-pane -Z")

    def split_reset():
        actions.user.tmux_execute_command("resize-pane -Z")

    def split_window():
        actions.user.split_window_horizontally()

    def split_clear():
        actions.user.tmux_execute_command_with_confirmation(
            "kill-pane", "kill-pane #P?"
        )

    def split_next():
        # select-pane doesn't seem to support the prefix-o behavior
        actions.user.tmux_keybind("o")

    def split_last():
        actions.user.tmux_execute_command("select-pane -l")

    def split_number(index: int):
        actions.user.tmux_execute_command(f"select-pane -t {index}")
