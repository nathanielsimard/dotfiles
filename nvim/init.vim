source ~/.config/nvim/layer.vim

" Basic Layer
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/basic.vim', [
                \g:Plugin.new('scrooloose/nerdtree'),
                \g:Plugin.new('nathanielsimard/vmenu'),
                \g:Plugin.new('junegunn/fzf'),
                \g:Plugin.new('junegunn/fzf.vim'),
                \g:Plugin.new('tpope/vim-fugitive'),
                \g:Plugin.new('tpope/vim-rhubarb'),
                \g:Plugin.new('editorconfig/editorconfig-vim'),
                \g:Plugin.new('mileszs/ack.vim', { 'on': 'Ack' }),
                \g:Plugin.new('sheerun/vim-polyglot'),
                \g:Plugin.new('chriskempson/base16-vim'),
                \g:Plugin.new('vim-airline/vim-airline'),
                \g:Plugin.new('vim-airline/vim-airline-themes'),
            \]))

" IDE Layer
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/ide.vim', [
                \g:Plugin.new('rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }),
                \g:Plugin.new('neomake/neomake'),
                \g:Plugin.new('Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }),
                \g:Plugin.new('Shougo/echodoc.vim'),
                \g:Plugin.new('Shougo/deoplete-lsp'),
                \g:Plugin.new('neovim/nvim-lsp')
            \]))

" Terminal Layer
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/terminal.vim', []))

" Language Layers
call g:Editor.add_layer(g:FileTypeLayer.new('markdown', '~/.config/nvim/lang/markdown.vim', [
                \g:Plugin.new('iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()' })
            \]))
call g:Editor.add_layer(g:FileTypeLayer.new('python', '~/.config/nvim/lang/python.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('julia', '~/.config/nvim/lang/julia.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('tex', '~/.config/nvim/lang/tex.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('javascript', '~/.config/nvim/lang/javascript.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('vim', '~/.config/nvim/lang/vim.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('clojure', '~/.config/nvim/lang/clojure.vim', []))

" Configure Editor
call g:Editor.configure()

" Source project based config
if filereadable(".project.vim")
    source .project.vim
endif
