os: windows
app: Microsoft Visual Studio 2019
app: devenv.exe
-
tag(): tabs
tag(): line_commands
tag(): find_and_replace
tag(): snippets
tag(): multiple_cursors

#talon app actions
action(app.tab_close): key(ctrl-f4)
action(app.tab_next): key(ctrl-tab)
action(app.tab_previous): key(ctrl-shift-tab)
action(app.tab_reopen): key(ctrl-1 ctrl-r enter)

#talon code actions
action(code.toggle_comment): key(ctrl-k ctrl-/)

#talon edit actions
action(edit.indent_more): key(tab)
action(edit.indent_less): key(shift-tab)
action(edit.save_all): key(ctrl-shift-s)

#multiple_cursor.py support begin
#note: visual studio has no explicit mode for multiple cursors; requires https://marketplace.visualstudio.com/items?itemName=VaclavNadrasky.MultiCaretBooster
action(user.multi_cursor_add_above): key(shift-alt-up)
action(user.multi_cursor_add_below): key(shift-alt-down)
#action(user.multi_cursor_add_to_line_ends): does not exist :(
action(user.multi_cursor_disable): key(escape)
action(user.multi_cursor_enable): skip()
action(user.multi_cursor_select_all_occurrences): key(shift-alt-;)
action(user.multi_cursor_select_fewer_occurrences): key(shift-alt-k)
action(user.multi_cursor_select_more_occurrences): key(shift-alt->)
#multiple_cursor.py support end

# Panels
panel solution: key(ctrl-alt-l)
panel properties: key(f4)
panel output: key(ctrl-alt-o)
panel class: key(ctrl-shift-c)
panel errors: key(ctrl-\ ctrl-e)
panel design: key(shift-f7)
panel marks: key(ctrl-k ctrl-w)
panel breakpoints: key(ctrl-alt-b)

# Settings
show settings: key(alt-t o)
#show shortcuts: 
#show snippets: 

# Display
fullscreen switch: key(shift-alt-enter)
wrap switch: key(ctrl-e ctrl-w)

# File Commands
file hunt [<user.text>]: 
    key(ctrl-shift-t)
    insert(text or "")
file create: key(ctrl-n)
#file open folder: 
file rename: key(ctrl-[ s f2)
file reveal: key(ctrl-[ s)

# Language Features
hint show: key(ctrl-shift-space)
definition show: key(f12)
definition peek: key(alt-f12)
references find: key(shift-f12)
format that: key(ctrl-k ctrl-d)
format selection: key(ctrl-k ctrl-f)
imports fix: key(ctrl-r ctrl-g)

# problem next: 
# problem last: 
# problem fix: 
refactor field: key(ctrl-r ctrl-e)
refactor interface: key(ctrl-r ctrl-i)
refactor method: key(ctrl-r ctrl-m)
refactor reorder parameters: key(ctrl-r ctrl-o)
refactor remove parameters: key(ctrl-r ctrl-v)
refactor that: key(ctrl-r ctrl-r)

#code navigation
(go declaration | follow): key(ctrl-f12)
go back: key(ctrl--)
go forward: key(ctrl-shift--)
go implementation: key(f12)
go recent [<user.text>]: 
    key(ctrl-1 ctrl-r)
    sleep(100ms)
    insert(text or "")
go type [<user.text>]: 
    key(ctrl-1 ctrl-t)
    sleep(100ms)
    insert(text or "")
go member [<user.text>]: 
    key(alt-\)
    sleep(100ms)
    insert(text or "")
go usage: key(shift-f12)

# Bookmarks.
go marks: key(ctrl-k ctrl-w)
toggle mark: key(ctrl-k ctrl-k)
go next mark: key(ctrl-k ctrl-n)
go last mark: key(ctrl-k ctrl-p)

# Folding
fold toggle: key(ctrl-m ctrl-m)
fold toggle all: key(ctrl-m ctrl-l)
fold definitions: key(ctrl-m ctrl-o)

#Debugging
break point: key(f9)
step over: key(f10)
debug step into: key(f11)
debug step out [of]: key(f10)
debug start: key(f5)
debug stopper: key(shift-f5)
debug continue: key(f5)
#debug restart: 