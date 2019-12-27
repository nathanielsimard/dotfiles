source ~/.config/nvim/keybinding.vim

let s:MENU_NAME = 'keybinding-menu'

function! menu#open(title, keybindings)
    call s:create_window()

    let l:default_padding = 20
    let l:tag_length = s:longuest_keybinding(a:keybindings) + l:default_padding
    let l:number_keybindings_per_line = s:number_keybindings_per_line(l:tag_length)
    let l:additional_padding = s:text_padding(l:tag_length, len(a:keybindings), l:number_keybindings_per_line)
    let l:tag_length = l:tag_length + l:additional_padding 

    let l:current_line_number = 1
    let l:current_tag_inline = 0
    let l:current_line_text = ''

    for keybinding in a:keybindings
        if l:current_tag_inline == l:number_keybindings_per_line
            call setline(l:current_line_number, l:current_line_text)

            let l:current_line_number = l:current_line_number + 1
            let l:current_tag_inline = 0
            let l:current_line_text = ''
        endif

        let l:current_text = s:create_keybinding_text(keybinding, l:tag_length)
        let l:current_line_text = l:current_line_text.l:current_text
        let l:current_tag_inline = l:current_tag_inline + 1
    endfor

    if l:current_tag_inline !=# 0 " If last line is not full
        call setline(l:current_line_number, l:current_line_text)
    endif

    execute 'resize '.l:current_line_number
endfunction

function! menu#close()
    if bufwinnr(s:MENU_NAME) > 0
        wincmd p
        execute 'bdelete '.s:MENU_NAME
    endif
endfunction

    function s:create_window()
    call menu#close()
    execute 'split '.s:MENU_NAME
    wincmd J
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

    return float2nr(floor((winwidth(0) - a:tag_length * l:number_keybindings_per_line) / l:number_keybindings_per_line))
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
    let l:width = winwidth(0)
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

