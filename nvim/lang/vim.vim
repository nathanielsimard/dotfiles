" Language Serveur Settings
register_autocomplete_lsp('vimls')
lua require'lspconfig'.vimls.setup{}
call RegisterKeybindingsLSP('vim')
