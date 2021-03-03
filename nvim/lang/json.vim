" Language Serveur Settings
lua << EOF
require'lspconfig'.jsonls.setup {
    on_attach=require'completion'.on_attach,
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}
EOF
call RegisterKeybindingsLSP('json')
