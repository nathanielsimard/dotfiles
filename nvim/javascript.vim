let g:neomake_javascript_enabled_makers = ['eslint']
let g:LanguageClient_serverCommands['javascript'] = ['javascript-typescript-stdio']
call Keybinding_lsp('javascript')

