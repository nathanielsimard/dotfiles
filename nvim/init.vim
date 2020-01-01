" Imports
source ~/.config/nvim/layer.vim
" Basic Plugins
call g:Editor.add_layer( g:SimpleLayer.new('~/.config/nvim/basic.vim', [
            \g:Plugin.new('scrooloose/nerdtree'),
            \g:Plugin.new('nathanielsimard/vmenu'),
            \g:Plugin.new('vim-airline/vim-airline'),
            \g:Plugin.new('vim-airline/vim-airline-themes'),
            \g:Plugin.new('junegunn/fzf'),
            \g:Plugin.new('editorconfig/editorconfig-vim'),
            \g:Plugin.new('mileszs/ack.vim'),
            \g:Plugin.new('mhinz/vim-startify'),
            \g:Plugin.new('sheerun/vim-polyglot'),
            \g:Plugin.new('chriskempson/base16-vim')
            \]))

" IDE Plugins
call g:Editor.add_layer(g:SimpleLayer.new('~/.config/nvim/essential.vim', [
            \g:Plugin.new('neomake/neomake'),
            \g:Plugin.new('janko/vim-test'),
            \g:Plugin.new('Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }),
            \g:Plugin.new('autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }),
            \g:Plugin.new('majutsushi/tagbar')
            \]))

" Language Plugins
call g:Editor.add_layer(g:FileTypeLayer.new('python', '~/.config/nvim/python.vim', [
            \g:Plugin.new('psf/black'),
            \g:Plugin.new('heavenshell/vim-pydocstring')
            \]))
call g:Editor.add_layer(g:FileTypeLayer.new('tex', '~/.config/nvim/tex.vim', []))
call g:Editor.add_layer(g:FileTypeLayer.new('javascript', '~/.config/nvim/javascript.vim', []))

call g:Editor.configure()

