" Language Serveur Settings
lua << EOF
register_autocomplete_lsp('java_language_server')
require'lspconfig'.java_language_server.setup {
    filetypes = { "java" },
    cmd = { "java-language-server" },
}
EOF
call RegisterKeybindingsLSP('java')
