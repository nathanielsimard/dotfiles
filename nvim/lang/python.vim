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

function! PythonRun()
    let l:file = @%
    call RunWithTerminal('python '.l:file)
endfunction

function! PythonTestFile()
    let l:file = @%

    if !s:is_test_file(l:file)
        let l:file =  s:to_test_file(l:file)
    end

    call RunWithTerminal('pytest '.l:file)
endfunction

function! PythonGotoTestFile()
    let l:file = @%

    if s:is_test_file(l:file)
        let l:file = s:to_src_file(l:file)
    else
        let l:file = s:to_test_file(l:file)
    end

    execute 'e '.l:file
endfunction

function! PythonTestSuite()
    call RunWithTerminal('pytest .')
endfunction

call vmenu#commands([
            \['e', 'Execute file', 'call PythonRun() '],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'python'
        \})

" Pydocstring Settings
"let g:pydocstring_templates_dir = '~/.config/nvim/pydocstring-templates'
call vmenu#commands([
            \['g', 'Generate Doc', 'Pydocstring']
        \], {
            \'parent': g:keybindings_documentation,
            \'filetype': 'python'
        \})

" Test Settings
call vmenu#commands([
            \['f','Test File', 'call PythonTestFile()'],
            \['s','Test Suite', 'call PythonTestSuite()'],
            \['g', 'Goto Test File', 'call PythonGotoTestFile()'],
        \], {
            \'parent': keybindings_test_tab,
            \'filetype': 'python'
        \})

let g:repl_terminal_python = g:ReplTerminal.new('ipython --no-autoindent --matplotlib')
call SetupRepl('python', 'g:repl_terminal_python')

function! PythonReplImport()
    let l:file = @%
    let l:import = substitute(l:file, '/', '.', '')
    let l:command = 'import '.l:import[0:-4]
    call g:repl_terminal_python.run(l:command)
endfunction

call vmenu#commands([
            \['i', 'REPL Import File', 'call PythonReplImport() '],
        \], {
            \'parent': g:keybindings_interactive,
            \'filetype': 'python'
        \})


