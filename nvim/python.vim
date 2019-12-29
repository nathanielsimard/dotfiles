let g:neomake_python_enabled_makers = ['flake8', 'mypy']
let g:LanguageClient_serverCommands['python'] = ['python', '-m', 'pyls']

call Keybinding_lsp('python')
call g:keybindings_refactor.add_filetype('python', g:CommandKeybinding.new('f', 'Format Document', 'Black'))
call g:keybindings_generate.add_filetype('python', g:CommandKeybinding.new('p', 'Pydocstring', 'Pydocstring'))

