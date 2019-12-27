let g:Keybinding={}
function g:Keybinding.new(key, description)
    let l:newKeybinding = copy(self)
    let l:newKeybinding.key = a:key
    let l:newKeybinding.description = a:description
    return l:newKeybinding
endfunction

function g:Keybinding.execute()
    echo "Not Implemented"
endfunction

let g:BasicKeybinding={}
function g:BasicKeybinding.new(key, description, command)
    let l:newBasicKeybinding = g:Keybinding.new(a:key, a:description)
    let l:newBasicKeybinding.command = a:command
    return extend(l:newBasicKeybinding, copy(self))
endfunction

function g:BasicKeybinding.execute()
    call ExitKeybindings()
    execute self.command
endfunction

let g:CategoryKeybinding={}
function g:CategoryKeybinding.new(path, key, description)
    let l:newCategoryKeybinding = g:Keybinding.new(a:key, a:description)
    let l:newCategoryKeybinding.path = a:path
    let l:newCategoryKeybinding.keybindings = []
    return extend(l:newCategoryKeybinding, copy(self))
endfunction

function g:CategoryKeybinding.add(keybinding)
    call add(self.keybindings, a:keybinding)
endfunction

function g:CategoryKeybinding.execute()
    let l:keys = []
    let l:descriptions = []
    let l:index = 0

    for keybinding in self.keybindings
        call add(l:keys, keybinding.key)
        call add(l:descriptions, keybinding.description)

        execute "nnoremap <silent>".keybinding.key." :call "self.path.".keybindings[".l:index."].execute()<CR>"
        let l:index = l:index + 1
    endfor
    if g:show_help == 1
        call s:show_help_windows(self.description, l:keys, l:descriptions)
    endif
endfunction

let g:FileTypeKeybinding={}
function g:FileTypeKeybinding.new(key, description)
    let l:newMajorModeKeybinding = g:Keybinding.new(a:key, a:description)
    let l:newMajorModeKeybinding.keybindings = []
    let l:newMajorModeKeybinding.keybindings_map = {}
    return extend(l:newMajorModeKeybinding, copy(self))
endfunction

function g:FileTypeKeybinding.add(filetype, keybinding)
    let l:index = len(self.keybindings)
    call extend(self.keybindings_map, {a:filetype: l:index})
    call add(self.keybindings, a:keybinding)
endfunction

function g:FileTypeKeybinding.execute()
    if has_key(self.keybindings_map, g:current_buffer_type)
        let l:index = get(self.keybindings_map, g:current_buffer_type)
        let l:keybinding = self.keybindings[l:index]
        call l:keybinding.execute()
    endif
endfunction

function! s:get_max_length_command(keys, comments, spacebetween, max_length_keys)
    let max_length_command = 0
    let comments_index = 0
    let max_length_commend_key = 0
    for key in a:keys
        if len(key) + a:spacebetween + len(a:comments[comments_index]) > max_length_command
            let max_length_command = len(key) + a:spacebetween + len(a:comments[comments_index])
            let max_length_commend_key = key
        endif
        let comments_index = comments_index + 1
    endfor
    return max_length_command + (a:max_length_keys - len(max_length_commend_key)) +1
endfunction

function! s:get_max_length_keys(keys)
    let max_length_command = 0
    for key in a:keys
        if len(key) > max_length_command
            let max_length_command = len(key)
        endif
    endfor
    return max_length_command
endfunction


function! s:get_comments_from_tag(tag)
    let tag_index = index(g:help_tags, a:tag)
    let comments = g:help_comments[tag_index]
    return comments
endfunction

function! s:get_keys_from_tag(tag)
    let tag_index = index(g:help_tags, a:tag)
    let keys = g:help_keybindings[tag_index]
    return keys
endfunction

function! SUCHVim_show_help_tag(tag)
    let open = s:verify_tag_buffer(a:tag)
    if open != -1
        let comments = s:get_comments_from_tag(a:tag)
        let keys = s:get_keys_from_tag(a:tag)
        call s:show_help_windows(a:tag, keys, comments)
    endif
endfunction

function! s:show_help_windows(title, keys, comments)
    let line_number_width = 4
    let winwidth = winwidth(0) - line_number_width
    let spacebetween = " "
    let spacebetween_caracter_number = 1
    let separator = " "
    let max_length_keys = s:get_max_length_keys(a:keys)
    let max_length_command = s:get_max_length_command(a:keys, a:comments, len(spacebetween) + spacebetween_caracter_number , max_length_keys)
    let number_of_commands_per_line = winwidth / max_length_command
    let number_of_lines = (len(a:keys) / number_of_commands_per_line) + 1

    let number_of_lines_for_title = 3
    call s:create_suchhelp_split(number_of_lines + number_of_lines_for_title)
    let current_commands_insert = 0
    let current_index = 0
    let delimiter = ""
    while current_index != (winwidth/2 - len(a:title)/2 - 1)
        let delimiter = delimiter." "
        let current_index += 1
    endwhile
    call setline(1, delimiter.toupper(a:title))
    let delimiter = ""
    let current_index = 0
    while current_index != winwidth
        let delimiter = delimiter."_"
        let current_index += 1
    endwhile
    call setline(2, delimiter)
    call setline(3, "")

    let current_line_number = number_of_lines_for_title
    let current_line_messate = ""
    let comments_index = 0
    for key in a:keys
        if current_commands_insert == number_of_commands_per_line
            let current_line_number = current_line_number + 1
            let current_commands_insert = 0
            call setline(current_line_number, current_line_messate)
            let current_line_messate = ""
        endif

        let number_of_keys_padding = max_length_keys - len(key)
        let key_padding = ""
        while len(key_padding) != number_of_keys_padding
            let key_padding = key_padding." "
        endwhile
        let number_of_padding = max_length_command - len(key) - len(a:comments[comments_index]) - spacebetween_caracter_number - number_of_keys_padding - len(spacebetween)
        let padding = ""
        while len(padding) != number_of_padding
            let padding = padding." "
        endwhile
        let current_line_messate = current_line_messate.key_padding.key.separator.a:comments[comments_index].padding.spacebetween
        let current_commands_insert = current_commands_insert + 1
        let comments_index = comments_index + 1
    endfor
    call setline(current_line_number+1, current_line_messate)
endfunction

function s:create_suchhelp_split(number_of_lines)
    call SUCHVim_toggle_help_filetype()
    split __SUCH_HELP__
    wincmd J
    normal! ggdG
    setlocal filetype=suchhelp
    setlocal buftype=nofile
    setlocal norelativenumber
    setlocal nonumber
endfunction

function! SUCHVim_toggle_help_filetype()
    if bufwinnr("__SUCH_HELP__") > 0
        wincmd p
        bdelete __SUCH_HELP__
    endif
endfunction

function! s:verify_tag_buffer(tag)
    if index(g:help_tags, a:tag) == -1
        echo "This filetype has no documentation." 
        return -1
    endif
    return 0
endfunction

let g:keybinding#root = g:CategoryKeybinding.new("g:keybinding#root", "no important", "SUCH Menu")
let g:keybinding#major = g:FileTypeKeybinding.new("l", "Language Specific")
call g:keybinding#root.add(g:keybinding#major)

function! ShowKeybindings()
    nnoremap <Esc> :call ExitKeybindings()<CR>
    call g:keybinding#root.execute()
endfunction

function! ExitKeybindings()
    let l:current_buffer_number = bufnr('%')
    call ResetKeybindings()
    call SUCHVim_toggle_help_filetype()
endfunction

let g:current_buffer_type = ""
let g:show_help = 0
function! UpdateBufferType() 
    let l:current_buffer_type = &ft
    if l:current_buffer_type != "suchhelp"
        let g:current_buffer_type = l:current_buffer_type
    endif
endfunction

autocmd WinEnter * call UpdateBufferType()
function! ResetKeybindings()
    nmapclear
    nnoremap <leader> :call ShowKeybindings()<CR>
endfunction
