" Imports
source ~/.config/nvim/layer.vim

" Basic Plugins
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/basic.vim', [
            \g:Plugin.new('scrooloose/nerdtree'),
            \g:Plugin.new('nathanielsimard/vmenu'),
            \g:Plugin.new('vim-airline/vim-airline'),
            \g:Plugin.new('vim-airline/vim-airline-themes'),
            \g:Plugin.new('junegunn/fzf'),
            \g:Plugin.new('voldikss/vim-floaterm'),
            \g:Plugin.new('editorconfig/editorconfig-vim'),
            \g:Plugin.new('mileszs/ack.vim', { 'on': 'Ack' }),
            \g:Plugin.new('mhinz/vim-startify'),
            \g:Plugin.new('sheerun/vim-polyglot'),
            \g:Plugin.new('chriskempson/base16-vim')
            \]))

" IDE Plugins
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/essential.vim', [
            \g:Plugin.new('janko/vim-test'),
            \g:Plugin.new('rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }),
            \g:Plugin.new('neomake/neomake'),
            \g:Plugin.new('Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }),
            \g:Plugin.new('Shougo/echodoc.vim'),
            \g:Plugin.new('autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' })
            \]))

" Language Plugins
call g:Editor.add_layer(g:FileTypeLayer.new('python', '~/.config/nvim/python.vim', [
            \g:Plugin.new('heavenshell/vim-pydocstring')
            \]))
call g:Editor.add_layer(g:FileTypeLayer.new('tex', '~/.config/nvim/tex.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('javascript', '~/.config/nvim/javascript.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('vim', '~/.config/nvim/vim.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('clojure', '~/.config/nvim/clojure.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('markdown', '~/.config/nvim/markdown.vim', [
            \g:Plugin.new('iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()' })
            \]))
call g:Editor.configure()

