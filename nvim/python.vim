let g:neomake_python_enabled_makers = ['flake8', 'mypy']
let g:LanguageClient_serverCommands['python'] = ['python', '-m', 'pyls']

call Keybinding_lsp('python')
call vmenu#commands([
            \['f', 'Format Document', 'Black'],
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

