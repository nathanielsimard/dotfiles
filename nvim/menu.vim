source ~/.config/nvim/keybinding.vim
let g:menu#type='floating'
let s:current_window = {}

function! menu#open(title, keybindings)
    let l:default_padding = 20
    let l:tag_length = s:longuest_keybinding(a:keybindings) + l:default_padding
    let l:number_keybindings_per_line = s:number_keybindings_per_line(l:tag_length)
    let l:additional_padding = s:text_padding(l:tag_length, len(a:keybindings), l:number_keybindings_per_line)
    let l:tag_length = l:tag_length + l:additional_padding 

    let l:current_line_number = 1
    let l:current_tag_inline = 0
    let l:current_line_text = ''
    let l:text = []

    for keybinding in a:keybindings
        if l:current_tag_inline == l:number_keybindings_per_line
            call add(l:text, l:current_line_text)

            let l:current_line_number = l:current_line_number + 1
            let l:current_tag_inline = 0
            let l:current_line_text = ''
        endif

        let l:current_text = s:create_keybinding_text(keybinding, l:tag_length)
        let l:current_line_text = l:current_line_text.l:current_text
        let l:current_tag_inline = l:current_tag_inline + 1
    endfor

    if l:current_tag_inline !=# 0 " If last line is not full
        call add(l:text, l:current_line_text)
    endif

    call menu#close()
    if g:menu#type ==# 'floating'
        let s:current_window = s:FloatingWindow.new(l:text)
    else
        let s:current_window = s:BufferWindow.new(l:text)
    endif
    call s:current_window.open()
endfunction

function! menu#close()
    if s:current_window !=# {}
        call s:current_window.close()
    endif
    let s:current_window = {}
endfunction

" Window Class (Abstract)
"
" Can be open and close displaying some text.
let s:Window={}
function s:Window.new(text)
    let l:newWindow = copy(self)
    let l:newWindow.text = a:text
    let l:newWindow.win = -1
    return l:newWindow
endfunction

function s:Window.close()
    if self.win !=# -1
        call nvim_win_close(self.win, 1)
    endif
endfunction

function s:Window.open()
    throw 'Not implemented'
endfunction

" Buffer Window Class
"
" The window is created at the buttum of the screen
"   taking the full width.
let s:BufferWindow={}
function s:BufferWindow.new(text)
    let l:newBufferWindow = s:Window.new(a:text)
    let l:newBufferWindow.name = 'BufferWindow'
    return extend(l:newBufferWindow, copy(self))
endfunction

function s:BufferWindow.open()
    execute 'split '.self.name
    let self.win = win_getid()
    wincmd J
    setlocal filetype=keybindingMenu
    setlocal buftype=nofile
    setlocal norelativenumber
    setlocal nonumber
    call setline(1, self.text)
    let l:number_of_lines = len(self.text)
    execute 'resize '.l:number_of_lines
endfunction

" Floating Window Class
"
" The window is created at the buttum of the screen
"   taking the full width but overring the other windows.
let s:FloatingWindow={}
function s:FloatingWindow.new(text)
    let l:newFloatingWindow = s:Window.new(a:text)
    return extend(l:newFloatingWindow, copy(self))
endfunction

function s:FloatingWindow.open()
    let l:height = len(self.text)
    let l:width = &columns
    let opts = {
                \ 'relative': 'editor',
                \ 'row' : l:width,
                \ 'col' : 0,
                \ 'width': l:width,
                \ 'height': l:height
                \}

    let l:buf = nvim_create_buf(v:false, v:true)
    let self.win = nvim_open_win(l:buf, v:true, opts)
    call setline(1, self.text)

    setlocal filetype=keybindingMenu
    setlocal buftype=nofile
    setlocal norelativenumber
    setlocal nonumber
endfunction

function s:text_padding(tag_length, number_keybindings, number_keybindings_per_line)
    let l:number_keybindings_per_line = a:number_keybindings_per_line
    if a:number_keybindings_per_line > a:number_keybindings
        let l:number_keybindings_per_line = a:number_keybindings
    endif

    return float2nr(floor((&columns - a:tag_length * l:number_keybindings_per_line) / l:number_keybindings_per_line))
endfunction

function s:create_keybinding_text(keybinding, tag_length)
    let l:text = ' ['.a:keybinding.key.'] '.a:keybinding.description
    let l:padding = a:tag_length - len(l:text)

    while l:padding >= 0
        let l:text = l:text.' '
        let l:padding = l:padding - 1
    endwhile

    return l:text
endfunction

function s:number_keybindings_per_line(tag_length)
    let l:width = &columns
    return float2nr(floor(l:width / a:tag_length))
endfunction

function s:longuest_keybinding(keybindings)
    let l:current_length = 0

    for keybinding in a:keybindings
        let l:length = len(keybinding.description)
        if l:length > l:current_length
            let l:current_length = l:length
        endif
    endfor

    return l:current_length
endfunction

