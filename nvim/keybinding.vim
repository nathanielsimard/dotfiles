source ~/.config/nvim/menu.vim
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
let g:CategoryKeybinding={}
function g:CategoryKeybinding.new(key, description)
    let l:newCategoryKeybinding = g:Keybinding.new(a:key, '+'.a:description)
    let l:newCategoryKeybinding.keybindings = {}
    return extend(l:newCategoryKeybinding, copy(self))
endfunction

function g:CategoryKeybinding.add(keybinding)
    let self.keybindings[a:keybinding.key] = a:keybinding
endfunction

function g:CategoryKeybinding.title()
    return self.description[1:]
endfunction

function g:CategoryKeybinding.execute()
    call s:MENU.show(self.title(), self.keybindings)
endfunction

" File Type Keybinding Class
" A keybinding aware of current file type
"
" When this keybinding is activated, it will select which of 
"   its keybindings to execute depending of the current buffer
"   filetype.
let g:FileTypeKeybinding={}
function g:FileTypeKeybinding.new(key, description)
    let l:newMajorModeKeybinding = g:CategoryKeybinding.new(a:key, a:description)
    let l:newMajorModeKeybinding.filetype_keybindings = {}
    return extend(l:newMajorModeKeybinding, copy(self))
endfunction

function g:FileTypeKeybinding.add_filetype(filetype, keybinding)
    if !has_key(self.filetype_keybindings, a:filetype)
        let self.filetype_keybindings[a:filetype] = {}
    endif

    let self.filetype_keybindings[a:filetype][a:keybinding.key] = a:keybinding
endfunction

function g:FileTypeKeybinding.execute()
    let l:current_filetype = self.current_filetype()
    let l:keybindings = copy(self.keybindings)

    if has_key(self.filetype_keybindings, l:current_filetype)
        let l:keybindings = extend(l:keybindings, self.filetype_keybindings[l:current_filetype])
    endif

    if l:keybindings ==# {}
        call s:MENU.close()
        echo '['.self.description."] No keybindings for filetype '".l:current_filetype."'"
    endif

    call s:MENU.show(self.title(), l:keybindings)
endfunction

function g:FileTypeKeybinding.current_filetype()
    if s:MENU.state == g:menu#STATE_SHOWING
        " Select the buffer type of the previous window
        " because the current one is the keybinding menu.
        wincmd p
        let l:tmp = &filetype
        wincmd p
        return l:tmp
    else
        return &filetype
    endif
endfunction

