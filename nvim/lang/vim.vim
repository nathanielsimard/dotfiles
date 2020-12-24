" Language Serveur Settings
lua require'lspconfig'.vimls.setup{on_attach=require'completion'.on_attach}
call RegisterKeybindingsLSP('vim')
