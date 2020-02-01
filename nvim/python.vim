let g:neomake_python_enabled_makers = ['flake8', 'mypy', 'pydocstyle']
let g:LanguageClient_serverCommands['python'] = ['python', '-m', 'pyls']
let g:autoformat_on_save['python'] = 1
call RegisterKeybindingsLSP('python')

function! PythonRun()
    let l:file = @%
    call RunWithTerminal('python '.l:file)
endfunction

function! PythonTestFile()
    let l:file = @%
    call RunWithTerminal('pytest '.l:file)
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
            \['s', 'Test Suite', 'call PythonTestSuite()'],
        \], {
            \'parent': keybindings_test_tab,
            \'filetype': 'python'
        \})
