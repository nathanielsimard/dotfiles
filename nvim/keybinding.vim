" Keybinding Menu State
"
" INACTIVE: The user is not navigating the keybindings.
" SHOWING: The user is navigating the keybindings with a visible menu.
" HIDING: The user is navigating the keybindings with an invisible menu.
let s:INACTIVE='inactive'
let s:SHOWING='showing'
let s:HIDING='hiding'

" Menu Class
let g:Menu={}
function g:Menu.new()
    let l:newMenu = copy(self)
    let l:newMenu.timer_id = -1
    let l:newMenu.keybinding_state = s:INACTIVE
    let l:newMenu.description = ''
    let l:newMenu.keybindings = {}

    return l:newMenu
endfunction

function g:Menu.show(description, keybindings)
    let self.description = a:description
    let self.keybindings = a:keybindings

    if self.keybinding_state == s:SHOWING
        call self.show_directly()
    else
        let self.keybinding_state = s:HIDING
        let self.timer_id = timer_start(g:keybinding#wait_time, self.show_after_timer)
    endif

    try
        call self.execute_keybinding()
    catch 
        if match(v:exception, s:USER_INTERUPTION) < 0 " Not USER_INTERUPTION exception
            throw v:exception
        endif

        call self.close()
    endtry
endfunction

function g:Menu.close()
    let self.keybinding_state = s:INACTIVE
    call menu#close()
endfunction

function g:Menu.show_directly()
    if g:keybinding#show == 1
        call menu#open(self.description, values(self.keybindings))
        redraw
    endif
endfunction

function g:Menu.show_after_timer(timer_id)
    if self.timer_id == a:timer_id && self.keybinding_state == s:HIDING
        let self.keybinding_state = s:SHOWING
        call self.show_directly()
    endif
endfunction

function g:Menu.execute_keybinding()
    let l:user_input = self.read_user()
    while !has_key(self.keybindings, l:user_input)
        let l:user_input = self.read_user()
    endwhile

    call self.keybindings[l:user_input].execute()
endfunction

function g:Menu.read_user()
    let l:user_input = getchar()
    if l:user_input == 27 "Escape caracter number
        throw s:USER_INTERUPTION
    endif

    return nr2char(l:user_input)
endfunction

let s:MENU = g:Menu.new()

" Basic Keybinding Class (Abstract)
" Each keybinding has a key and a description.
"
" Each keybinding class can be executed with the help of the 'execute' function.
let g:Keybinding={}
function g:Keybinding.new(key, description)
    let l:newKeybinding = copy(self)
    let l:newKeybinding.key = a:key
    let l:newKeybinding.description = a:description
    return l:newKeybinding
endfunction

function g:Keybinding.execute()
    throw 'Not Implemented'
endfunction

" Command Keybinding Class
" Basic keybinding which execute a vim command.
"
" When the command is executed, the help window will be close.
let g:CommandKeybinding={}
function g:CommandKeybinding.new(key, description, command)
    let l:newCommandKeybinding = g:Keybinding.new(a:key, a:description)
    let l:newCommandKeybinding.command = a:command
    return extend(l:newCommandKeybinding, copy(self))
endfunction

function g:CommandKeybinding.execute()
    call s:MENU.close()
    execute self.command
endfunction

" Category Keybinding Class
" A keybinding which will give access to other keybindings.
"
" If the 'g:keybinding#show' is enabled, the 'execute' function
"   will also show the menu with all the category's keybindings.
let g:CategoryKeybinding={}
function g:CategoryKeybinding.new(key, description)
    let l:newCategoryKeybinding = g:Keybinding.new(a:key, a:description)
    let l:newCategoryKeybinding.keybindings = {}
    return extend(l:newCategoryKeybinding, copy(self))
endfunction

function g:CategoryKeybinding.add(keybinding)
    let self.keybindings[a:keybinding.key] = a:keybinding
endfunction

function g:CategoryKeybinding.execute()
    call s:MENU.show(self.description, self.keybindings)
endfunction

" File Type Keybinding Class
" A keybinding aware of current file type
"
" When this keybinding is activated, it will select which of 
"   its keybindings to execute depending of the current buffer
"   filetype.
let s:USER_INTERUPTION='User Interuption'
let g:FileTypeKeybinding={}
function g:FileTypeKeybinding.new(key, description)
    let l:newMajorModeKeybinding = g:Keybinding.new(a:key, a:description)
    let l:newMajorModeKeybinding.keybindings_group = {}
    let l:newMajorModeKeybinding.defaults = {}
    return extend(l:newMajorModeKeybinding, copy(self))
endfunction

function g:FileTypeKeybinding.default(keybinding)
    let self.defaults[a:keybinding.key] = a:keybinding
endfunction

function g:FileTypeKeybinding.add(filetype, keybinding)
    if !has_key(self.keybindings_group, a:filetype)
        let self.keybindings_group[a:filetype] = {}
    endif

    let self.keybindings_group[a:filetype][a:keybinding.key] = a:keybinding
endfunction

function g:FileTypeKeybinding.execute()
    if g:keybinding#show == 1 && s:MENU.keybinding_state == s:SHOWING
        " Select the buffer type of the previous window
        " because the current one is the keybinding menu.
        wincmd p
        let l:current_buffer_type = &filetype
        wincmd p
    else
        let l:current_buffer_type = &filetype
    endif

    let l:keybindings = copy(self.defaults)
    if has_key(self.keybindings_group, l:current_buffer_type)
        let l:keybindings = extend(l:keybindings, self.keybindings_group[l:current_buffer_type])
        call s:MENU.show(self.description, l:keybindings)
    elseif l:keybindings !=# {}
        call s:MENU.show(self.description, l:keybindings)
    else
        call s:MENU.close()
        echo '['.self.description."] No keybindings for filetype '".l:current_buffer_type."'"
    endif
endfunction

" Basic Keybinding Configuration 
let g:keybinding#show = 0
let g:keybinding#wait_time = 300
let g:keybinding#root = g:CategoryKeybinding.new('no important', 'Keybinding Menu')
let g:keybinding#major = g:FileTypeKeybinding.new('l', 'Language Specific')
call g:keybinding#root.add(g:keybinding#major)

