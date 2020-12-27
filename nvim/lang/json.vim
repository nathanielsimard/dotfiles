" Language Serveur Settings
lua require'lspconfig'.jsonls.setup{on_attach=require'completion'.on_attach}
call RegisterKeybindingsLSP('json')
