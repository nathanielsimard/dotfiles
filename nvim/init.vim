source ~/.config/nvim/layer.vim

function! Log(message)
    let s:date = strftime('%Y/%m/%d %T')
    let s:message = "[INFO - ".s:date."] ".a:message

    exe "silent !echo ".s:message." >> ~/.nvim.log"
endfunction

" Basic Layer
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/basic.vim', [
                \g:Plugin.new('rcarriga/nvim-notify'),
                \g:Plugin.new('kyazdani42/nvim-web-devicons'),
                \g:Plugin.new('kyazdani42/nvim-tree.lua'),
                \g:Plugin.new('mileszs/ack.vim', { 'on': 'Ack' }),
                \g:Plugin.new('nathanielsimard/vmenu'),
                \g:Plugin.new('editorconfig/editorconfig-vim'),
                \g:Plugin.new('morhetz/gruvbox'),
                \g:Plugin.new('mhinz/vim-startify'),
                \g:Plugin.new('nvim-lua/plenary.nvim'),
                \g:Plugin.new('nvim-telescope/telescope.nvim'),
                \g:Plugin.new('nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }),
                \g:Plugin.new('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}),
            \]))

" StatusLine
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/statusline.vim', [
                \g:Plugin.new('nvim-lualine/lualine.nvim'),
            \]))

" IDE Layer
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/ide.vim', [
                \g:Plugin.new('folke/trouble.nvim'),
                \g:Plugin.new('lukas-reineke/indent-blankline.nvim'),
                \g:Plugin.new('neovim/nvim-lspconfig'),
                \g:Plugin.new('nvim-lua/popup.nvim'),
                \g:Plugin.new('ray-x/lsp_signature.nvim'),
                \g:Plugin.new('L3MON4D3/LuaSnip'),
                \g:Plugin.new('saadparwaiz1/cmp_luasnip'),
                \g:Plugin.new('hrsh7th/cmp-nvim-lsp'),
                \g:Plugin.new('hrsh7th/cmp-buffer'),
                \g:Plugin.new('hrsh7th/cmp-cmdline'),
                \g:Plugin.new('hrsh7th/cmp-path'),
                \g:Plugin.new('hrsh7th/nvim-cmp'),
            \]))

" Neovide Layer
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/neovide.vim', []))

" Utils Layers
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/utils/terminal.vim', []))
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/utils/test.vim', []))

" Language Layers
call g:Editor.add_layer(g:FileTypeLayer.new('markdown', '~/.config/nvim/lang/markdown.vim', [
                \g:Plugin.new('iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' })
            \]))
call g:Editor.add_layer(g:FileTypeLayer.new('java', '~/.config/nvim/lang/java.vim', [])) 
call g:Editor.add_layer(g:FileTypeLayer.new('julia', '~/.config/nvim/lang/julia.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('sh', '~/.config/nvim/lang/sh.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('wgsl', '~/.config/nvim/lang/wgsl.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('python', '~/.config/nvim/lang/python.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('rust', '~/.config/nvim/lang/rust.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('tex', '~/.config/nvim/lang/tex.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('json', '~/.config/nvim/lang/json.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('javascript,typescript,typescriptreact,typescript.tsx,vue',
            \'~/.config/nvim/lang/typescript.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('vim', '~/.config/nvim/lang/vim.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('clojure', '~/.config/nvim/lang/clojure.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('svelte', '~/.config/nvim/lang/svelte.vim', [
                \g:Plugin.new('leafOfTree/vim-svelte-plugin'),
            \]))

au BufRead,BufNewFile *.wgsl set filetype=wgsl
au BufRead,BufNewFile *.wgsl TSEnable highlight

" Configure Editor
call g:Editor.configure()

" Source project based config
if filereadable(".project.vim")
    source .project.vim
endif
