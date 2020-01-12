let g:neomake_python_enabled_makers = ['flake8', 'mypy']
let g:LanguageClient_serverCommands['python'] = ['python', '-m', 'pyls']

function! RunPython()
    let l:file = @%
    call RunWithTerminal('python '.l:file)
endfunction


call Keybinding_lsp('python')
call vmenu#commands([
            \['f', 'Format Document', 'Black'],
            \['p', 'Run Python', 'call RunPython() ']
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'python'
        \})

call vmenu#commands([
            \['g', 'Generate Doc', 'Pydocstring']
        \], {
            \'parent': g:keybindings_documentation,
            \'filetype': 'python'
        \})

