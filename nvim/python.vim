let g:neomake_python_enabled_makers = ['flake8', 'mypy', 'pydocstyle']
let g:LanguageClient_serverCommands['python'] = ['python', '-m', 'pyls']
let g:autoformat_on_save['python'] = 1
call RegisterKeybindingsLSP('python')

function! RunPython()
    let l:file = @%
    call RunWithTerminal('python '.l:file)
endfunction

call vmenu#commands([
            \['e', 'Execute file', 'call RunPython() '],
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
