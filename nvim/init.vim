" Imports
source ~/.config/nvim/keybinding.vim
source ~/.config/nvim/layer.vim

" Root Keybindings
let g:keybindings_root = g:CategoryKeybinding.new('no important', 'Keybinding Menu')

" File Type Keybindings
let g:keybindings_refactor = g:FileTypeKeybinding.new('r', 'Refactor')
let g:keybindings_goto = g:FileTypeKeybinding.new('g', 'Go To')
let g:keybindings_error = g:FileTypeKeybinding.new('e', 'Error')
let g:keybindings_help = g:FileTypeKeybinding.new('h', 'Help')
let g:keybindings_test = g:FileTypeKeybinding.new('t', 'Testing')
let g:keybindings_generate = g:FileTypeKeybinding.new('c', 'Code Generation')

call g:keybindings_root.add(g:keybindings_refactor)
call g:keybindings_root.add(g:keybindings_goto)
call g:keybindings_root.add(g:keybindings_error)
call g:keybindings_root.add(g:keybindings_help)
call g:keybindings_root.add(g:keybindings_test)
call g:keybindings_root.add(g:keybindings_generate)

" Category Keybindings
let g:keybindings_buffer = g:CategoryKeybinding.new('b', 'Buffer')
let g:keybindings_window = g:CategoryKeybinding.new('w', 'Window')
let g:keybindings_view = g:CategoryKeybinding.new('v', 'View')
let g:keybindings_file = g:CategoryKeybinding.new('f', 'File')

call g:keybindings_root.add(g:keybindings_buffer)
call g:keybindings_root.add(g:keybindings_window)
call g:keybindings_root.add(g:keybindings_view)
call g:keybindings_root.add(g:keybindings_file)

" Basic Plugins
call g:Editor.add_layer( g:SimpleLayer.new('~/.config/nvim/basic.vim', [
            \g:Plugin.new('scrooloose/nerdtree'),
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

nnoremap <silent> <leader> :call g:keybindings_root.execute()<CR>

