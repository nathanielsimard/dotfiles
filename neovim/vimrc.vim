"----------------------------------------------------------------
"  Include Plugins
" ----------------------------------------------------------------

source ~/Documents/Github/Config/neovim/basic/plugins.vim


" ----------------------------------------------------------------
"  Include Basic
" ----------------------------------------------------------------

source ~/Documents/Github/Config/neovim/basic/practical.vim
source ~/Documents/Github/Config/neovim/basic/windows.vim
source ~/Documents/Github/Config/neovim/basic/syntax.vim

" ----------------------------------------------------------------
"  Include Languages
" ----------------------------------------------------------------

source ~/Documents/Github/Config/neovim/languages/python.vim
source ~/Documents/Github/Config/neovim/languages/go.vim
 
" ----------------------------------------------------------------
"  Init
" ----------------------------------------------------------------

autocmd VimEnter * NERDTree
