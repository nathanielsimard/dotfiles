" Terminal Settings 
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber
tnoremap <Esc> <C-\><C-n>

" Terminal Class
let g:Terminal = {}
function g:Terminal.new(...)
    let l:options = {
                \'autojump': 0,
                \'autoinsert': 0,
                \'autoscroll': 0,
                \'shell': 'bash',
                \}
    if a:0 > 0
        let l:options = extend(l:options, a:1)
    end

    let l:newTerminal = copy(self)

    let l:newTerminal.bufnr = -1
    let l:newTerminal.winid = -1

    let l:newTerminal.autojump = l:options['autojump']
    let l:newTerminal.autoinsert = l:options['autoinsert']
    let l:newTerminal.autoscroll = l:options['autoscroll']
    let l:newTerminal.shell = l:options['shell']

    return l:newTerminal
endfunction

function g:Terminal.toggle()
    if !bufexists(self.bufnr)
        call self._create()
    else
        call self._toggle()
    endif

    call self._apply_options()
endfunction

function g:Terminal.run(command)
    if !bufexists(self.bufnr)
        call self._create()
    else
        call self._open()
    endif

    let l:channel = &channel
    call chansend(l:channel, a:command."\n")

    call self._apply_options()
endfunction

function g:Terminal._open()
    if bufnr() !=# self.bufnr
        call win_gotoid(self.winid)

        if win_getid() !=# self.winid || bufnr() !=# self.bufnr
            call self._open_existing()
        endif
    endif
endfunction

function g:Terminal._close()
    wincmd p
    call nvim_win_close(self.winid, 0)
endfunction

function g:Terminal._toggle()
    if bufnr() ==# self.bufnr
        call self._close()
        return
    endif

    call win_gotoid(self.winid)

    if win_getid() ==# self.winid && bufnr() ==# self.bufnr
        call self._close()
        return
    end

    call self._open_existing()
endfunction

function g:Terminal._open_existing()
    call self._create_window()
    execute 'b'.self.bufnr

    let self.winid = win_getid()
endfunction

function g:Terminal._create()
    call self._create_window()
    execute 'terminal '.self.shell

    let self.bufnr = bufnr()
    let self.winid = win_getid()

    call self._on_open()
endfunction

function g:Terminal._apply_options()
    let l:focused = self.bufnr ==# bufnr()

    if self.autoinsert ==# 1 && l:focused ==# 1
        startinsert
    end

    if self.autoscroll ==# 1 && l:focused ==# 1
        normal! G
    end

    if self.autojump !=# 1 && l:focused ==# 1
        wincmd p
    end
endfunction

" Can be overrited to initialize other type of 
" terminal like REPL.
function g:Terminal._on_open()
endfunction

function g:Terminal._create_window()
    bot split
    let l:height = &lines / 3
    execute 'resize '.l:height
endfunction

" Repl Terminal Class
let g:ReplTerminal = {}
function g:ReplTerminal.new(relp_command)
    let l:newTerminal = g:Terminal.new({
                \'autojump': 0,
                \'autoinsert': 0,
                \'autoscroll': 1,
                \'shell': 'sh',
            \})
    let l:newTerminal.relp_command = a:relp_command
    return extend(l:newTerminal, copy(self))
endfunction

function g:ReplTerminal.send_file()
    let l:content = join(getline(1,'$'), "\n")
    call self.run(l:content)
endfunction

function g:ReplTerminal.send_line()
    let l:content = getline('.')
    call self.run(l:content)
endfunction

function g:ReplTerminal._on_open()
    call self.run(self.relp_command)
endfunction

function g:ReplTerminal._create_window()
    vertical split
    wincmd l
    let l:width = &columns / 3
    execute 'vertical resize '.l:width
endfunction

let g:main_terminal = g:Terminal.new({
                \'autojump': 1,
                \'autoinsert': 1,
            \})
let g:jobs_terminal = g:Terminal.new({
                \'autojump': 0,
                \'autoinsert': 0,
                \'autoscroll': 1,
                \'shell': 'sh',
            \})

" Run command with the neovim terminal.
"
" The command will run with sh shell and the terminal will
" be close after the end of the command.
function! terminal#run_command(command)
    call g:jobs_terminal.run(a:command)
endfunction

" Setup the basic keybindings for the repl for a specific filetype.
"
" The repl_terminal_name must be an instance of g:ReplTerminal.
function! terminal#repl_setup(filetype, repl_terminal_name)
    call vmenu#commands([
                \['f', 'REPL Send File', 'call '.a:repl_terminal_name.'.send_file()'],
                \['l', 'REPL Send Line', 'call '.a:repl_terminal_name.'.send_line()'],
                \['t', 'REPL Toggle', 'call '.a:repl_terminal_name.'.toggle()'],
            \], {
                \'parent': g:keybindings_interactive,
                \'filetype':a:filetype,
            \})
endfunction

call vmenu#commands([
            \[' ', 'Toggle Terminal', 'call g:main_terminal.toggle()'],
        \])

call vmenu#commands([
                \['j', 'JOBS Toggle', 'call g:jobs_terminal.toggle()'],
            \], {
                \'parent': g:keybindings_jumps_jobs
            \})

