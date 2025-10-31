" Register mason
lua require('mason').setup()

" Register hover
lua << EOF
require('hover').config({
  providers = {
    'hover.providers.lsp',
    'hover.providers.diagnostic',
    'hover.providers.dap',
    'hover.providers.man',
    'hover.providers.dictionary',
  },
  preview_opts = {
    border = 'single'
  },
  -- Whether the contents of a currently open hover window should be moved
  -- to a :h preview-window when pressing the hover keymap.
  preview_window = false,
  title = true,
  mouse_providers = {
    'hover.providers.lsp',
  },
  mouse_delay = 1000
})
EOF

" Utilities
let g:autoformat_on_save = {}
function! FormatFiletype()
    if !has_key(g:autoformat_on_save, &filetype)
        return
    endif

    if get(g:autoformat_on_save, &filetype) ==# 1
        lua vim.lsp.buf.formatting()
    end
endfunction

augroup Autoformat
    autocmd BufWritePre * call FormatFiletype()
augroup END

lua << EOF
function register_autocomplete_lsp(lsp_server_name)
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    vim.lsp.config(lsp_server_name, {
        capabilities = capabilities
    })
end
EOF

function! RegisterKeybindingsLSP(filetype)
    imap <C-Space> <C-O>:lua vim.lsp.buf.completion()<CR>
    call vmenu#commands([
                \['t', 'Toggle', 'Trouble diagnostics toggle'],
                \['s', 'Show', 'lua vim.diagnostic.open_float()'],
                \['j', 'Next', 'lua vim.diagnostic.goto_next()'],
                \['k', 'Prev', 'lua vim.diagnostic.goto_prev()'],
        \], {
            \'parent': g:keybindings_error,
            \'filetype': a:filetype
        \})

    call vmenu#commands([
                \['d', 'Show Hover', "lua require('hover').open()"],
                \['e', 'Enter Hover', "lua require('hover').enter()"],
        \], {
            \'parent': g:keybindings_documentation,
            \'filetype': a:filetype
        \})

    call vmenu#commands([
                \['a', 'Code Action', 'lua vim.lsp.buf.code_action()'],
                \['d', 'Diagnostics Document', 'Telescope lsp_document_diagnostics'],
                \['D', 'Diagnostics Workspace', 'Telescope lsp_workspace_diagnostics'],
                \['s', 'Signature', 'lua vim.lsp.buf.signature_help()'],
                \['c', 'Completion', 'lua vim.lsp.buf.completion()'],
                \['r', 'Highlight References', 'lua vim.lsp.buf.document_highlight()']
        \], {
            \'parent': g:keybindings_help,
            \'filetype': a:filetype
        \})

    call vmenu#commands([
                \['d', 'Definition', 'Telescope lsp_definitions'],
                \['i', 'Implementation', 'Telescope lsp_implementations'],
                \['r', 'References', 'Telescope lsp_references'],
                \['s', 'Symbols Document', 'Telescope lsp_document_symbols'],
                \['S', 'Symbols Workspace', 'Telescope lsp_workspace_symbols']
        \], {
            \'parent': g:keybindings_jumps_jobs,
            \'filetype': a:filetype
        \})

    call vmenu#commands([
                \['a', 'Code Action', 'lua vim.lsp.buf.code_action()'],
                \['r', 'Rename', 'lua vim.lsp.buf.rename()'],
                \['f', 'Format', 'lua vim.lsp.buf.format()'],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': a:filetype
        \})
endfunction

" Spelling Settings
function! ToggleSpelling()
    if &spell ==# 1
        setlocal nospell
    else
        setlocal spell
    endif
endfunction

call vmenu#commands([
            \['g', 'Check Grammar', 'GrammarousCheck  --preview'],
            \['r', 'Reset Grammar', 'GrammarousReset'],
            \['s', 'Toggle Spelling', 'call ToggleSpelling()'],
            \['c', 'Correct Spelling', 'normal! z='],
            \['n', 'Next Spelling Error', 'normal! [s'],
            \['n', 'Previous Spelling Error', 'normal! ]s'],
    \], {
        \'parent': g:keybindings_spelling
    \})

" Completion Settings
set completeopt=menu,menuone,noselect

lua << EOF
local cmp = require'cmp'
cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sorting =  {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.sort_text,
      cmp.config.compare.order,
    }
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
})
require "lsp_signature".setup({})
EOF

" Diagnostics Settings
lua << EOF
require("trouble").setup {}
EOF
