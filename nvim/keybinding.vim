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
    echo 'Not Implemented'
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
    call menu#close()
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
    let l:newCategoryKeybinding.keys = []
    let l:newCategoryKeybinding.descriptions = []
    return extend(l:newCategoryKeybinding, copy(self))
endfunction

function g:CategoryKeybinding.add(keybinding)
    call add(self.keys, a:keybinding.key)
    call add(self.descriptions, a:keybinding.description)
    let self.keybindings[a:keybinding.key] = a:keybinding
endfunction

function g:CategoryKeybinding.execute()
    if g:keybinding#show == 1
        call menu#open(self.description, values(self.keybindings))
        redraw
    endif

    try
        call self.execute_keybinding()
    catch
        """ Catch User Interuption
    endtry
endfunction

function g:CategoryKeybinding.read_user()
    let l:user_input = getchar()
    if l:user_input == 27 "Escape caracter number
        call menu#close()
        throw 'User Interuption'
    endif

    return nr2char(l:user_input)
endfunction

function g:CategoryKeybinding.execute_keybinding()
    let l:user_input = self.read_user()
    while !has_key(self.keybindings, l:user_input)
        let l:user_input = self.read_user()
    endwhile

    call self.keybindings[l:user_input].execute()
endfunction

" File Type Keybinding Class
" A keybinding aware of current file type
"
" When this keybinding is activated, it will select which of 
"   its keybindings to execute depending of the current buffer
"   filetype.
let g:FileTypeKeybinding={}
function g:FileTypeKeybinding.new(key, description)
    let l:newMajorModeKeybinding = g:Keybinding.new(a:key, a:description)
    let l:newMajorModeKeybinding.keybindings = {}
    return extend(l:newMajorModeKeybinding, copy(self))
endfunction

function g:FileTypeKeybinding.add(filetype, keybinding)
    let self.keybindings[a:filetype] = a:keybinding
endfunction

function g:FileTypeKeybinding.execute()
    if g:keybinding#show == 1
        " Select the buffer type of the previous window
        " because the current one is keybinding menu.
        wincmd p
        let l:current_buffer_type = &filetype
        wincmd p
    else
        let l:current_buffer_type = &filetype
    endif
    if has_key(self.keybindings, l:current_buffer_type)
        call self.keybindings[l:current_buffer_type].execute()
    else
        echo "No major mode for filetype '".l:current_buffer_type."'"
    endif
endfunction

" Basic Keybinding Configuration 
let g:keybinding#show = 0
let g:keybinding#root = g:CategoryKeybinding.new('no important', 'Keybinding Menu')
let g:keybinding#major = g:FileTypeKeybinding.new('l', 'Language Specific')
call g:keybinding#root.add(g:keybinding#major)
