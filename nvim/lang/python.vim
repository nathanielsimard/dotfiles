let g:neomake_python_enabled_makers = ['flake8', 'mypy', 'pydocstyle']
let g:LanguageClient_serverCommands['python'] = ['python', '-m', 'pyls']
let g:autoformat_on_save['python'] = 1
call RegisterKeybindingsLSP('python')

function s:is_test_file(file)
    return a:file[-7:] ==# 'test.py'
endfunction

function s:to_test_file(file)
    let l:test_file = a:file
    let l:test_file = substitute(l:test_file, '.py', '_test.py', '')
    let l:test_file = substitute(l:test_file, 'src', 'tests', '')

    return l:test_file
endfunction

function s:to_src_file(test_file)
    let l:file = a:test_file
    let l:file = substitute(l:file, '_test.py', '.py', '')
    let l:file = substitute(l:file, 'tests', 'src', '')

    return l:file

endfunction

function! lang#python#run()
    let l:file = @%
    call terminal#run_command('python '.l:file)
endfunction

function! lang#python#test_file()
    let l:file = @%

    if !s:is_test_file(l:file)
        let l:file =  s:to_test_file(l:file)
    end

    call terminal#run_command('pytest '.l:file)
endfunction

function! lang#python#test_toggle()
    let l:file = @%

    if s:is_test_file(l:file)
        let l:file = s:to_src_file(l:file)
    else
        let l:file = s:to_test_file(l:file)
    end

    execute 'e '.l:file
endfunction

function! lang#python#test_suite()
    call terminal#run_command('pytest .')
endfunction

" Run Settings
call vmenu#commands([
            \['e', 'Execute file', 'call lang#python#run() '],
            \['t','Test File', 'call lang#python#test_file()'],
            \['s','Test Suite', 'call lang#python#test_suite()'],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'python'
        \})

call vmenu#commands([
            \['t', 'Test - Impl', 'call lang#python#test_toggle()'],
        \], {
            \'parent': g:keybindings_jumps_jobs,
            \'filetype': 'python'
        \})

let g:repl_terminal_python = g:ReplTerminal.new('ipython --no-autoindent --matplotlib')
call terminal#repl_setup('python', 'g:repl_terminal_python')

function! lang#python#repl_import()
    let l:file = @%
    let l:import = substitute(l:file, '/', '.', 'g')
    let l:command = 'import '.l:import[0:-4]
    call g:repl_terminal_python.run(l:command)
endfunction

call vmenu#commands([
            \['i', 'REPL Import File', 'call lang#python#repl_import() '],
        \], {
            \'parent': g:keybindings_interactive,
            \'filetype': 'python'
        \})


