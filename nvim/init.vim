source ~/.config/nvim/layer.vim

" Basic Layer
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/basic.vim', [
                \g:Plugin.new('kyazdani42/nvim-web-devicons'),
                \g:Plugin.new('kyazdani42/nvim-tree.lua'),
                \g:Plugin.new('mileszs/ack.vim', { 'on': 'Ack' }),
                \g:Plugin.new('nathanielsimard/vmenu'),
                \g:Plugin.new('editorconfig/editorconfig-vim'),
                \g:Plugin.new('sheerun/vim-polyglot'),
                \g:Plugin.new('morhetz/gruvbox'),
                \g:Plugin.new('nvim-lualine/lualine.nvim'),
                \g:Plugin.new('mhinz/vim-startify'),
                \g:Plugin.new('lukas-reineke/indent-blankline.nvim'),
                \g:Plugin.new('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}),
                \g:Plugin.new('nvim-telescope/telescope.nvim'),
                \g:Plugin.new('nvim-telescope/telescope-fzf-native.nvim'),
            \]))

" StatusLine
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/statusline.vim', [
                \g:Plugin.new('nvim-lualine/lualine.nvim'),
            \]))

" IDE Layer
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/ide.vim', [
                \g:Plugin.new('rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }),
                \g:Plugin.new('steelsojka/completion-buffers'),
                \g:Plugin.new('nvim-lua/popup.nvim'),
                \g:Plugin.new('nvim-lua/plenary.nvim'),
                \g:Plugin.new('nvim-lua/completion-nvim'),
                \g:Plugin.new('neovim/nvim-lspconfig'),
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
