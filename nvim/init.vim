source ~/.config/nvim/layer.vim

function! Log(message)
    let s:date = strftime('%Y/%m/%d %T')
    let s:message = "[INFO - ".s:date."] ".a:message

    exe "silent !echo ".s:message." >> ~/.nvim.log"
endfunction

" Basic Layer
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/basic.vim', [
                \g:Plugin.new('kyazdani42/nvim-web-devicons'),
                \g:Plugin.new('kyazdani42/nvim-tree.lua'),
                \g:Plugin.new('mileszs/ack.vim', { 'on': 'Ack' }),
                \g:Plugin.new('nathanielsimard/vmenu'),
                \g:Plugin.new('editorconfig/editorconfig-vim'),
                \g:Plugin.new('sheerun/vim-polyglot'),
                \g:Plugin.new('morhetz/gruvbox'),
                \g:Plugin.new('mhinz/vim-startify'),
                \g:Plugin.new('nvim-lua/plenary.nvim'),
                \g:Plugin.new('nvim-telescope/telescope.nvim'),
                \g:Plugin.new('nvim-telescope/telescope-fzf-native.nvim'),
                \g:Plugin.new('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}),
            \]))

" StatusLine
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/statusline.vim', [
                \g:Plugin.new('nvim-lualine/lualine.nvim'),
            \]))

" IDE Layer
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/ide.vim', [
                \g:Plugin.new('lukas-reineke/indent-blankline.nvim'),
                \g:Plugin.new('neovim/nvim-lspconfig'),
                \g:Plugin.new('rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }),
                \g:Plugin.new('nvim-lua/popup.nvim'),
                \g:Plugin.new('L3MON4D3/LuaSnip'),
                \g:Plugin.new('hrsh7th/nvim-cmp'),
                \g:Plugin.new('hrsh7th/cmp-path'),
                \g:Plugin.new('hrsh7th/cmp-buffer'),
                \g:Plugin.new('hrsh7th/cmp-nvim-lsp'),
                \g:Plugin.new('hrsh7th/cmp-cmdline'),
            \]))

" Utils Layers
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/utils/terminal.vim', []))
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/utils/test.vim', []))

" Language Layers
call g:Editor.add_layer(g:FileTypeLayer.new('markdown', '~/.config/nvim/lang/markdown.vim', [
                \g:Plugin.new('iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()' })
            \]))
call g:Editor.add_layer(g:FileTypeLayer.new('julia', '~/.config/nvim/lang/julia.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('python', '~/.config/nvim/lang/python.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('rust', '~/.config/nvim/lang/rust.vim', [
                \g:Plugin.new('simrat39/rust-tools.nvim'),
            \]))
call g:Editor.add_layer(g:FileTypeLayer.new('java', '~/.config/nvim/lang/java.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('tex', '~/.config/nvim/lang/tex.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('json', '~/.config/nvim/lang/json.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('javascript,typescript', '~/.config/nvim/lang/typescript.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('vim', '~/.config/nvim/lang/vim.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('clojure', '~/.config/nvim/lang/clojure.vim', []))

" Configure Editor
call g:Editor.configure()

" Source project based config
if filereadable(".project.vim")
    source .project.vim
endif
