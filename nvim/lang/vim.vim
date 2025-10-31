" Language Serveur Settings
register_autocomplete_lsp('vimls')
lua vim.lsp.config('vimls', {})
lua vim.lsp.enable('vimls')
call RegisterKeybindingsLSP('vim')
