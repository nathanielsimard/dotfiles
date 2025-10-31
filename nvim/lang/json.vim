" Language Serveur Settings
lua << EOF
vim.lsp.config('jsonls', {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
})
vim.lsp.enable('jsonls')
EOF
call RegisterKeybindingsLSP('json')
