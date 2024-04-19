call RegisterKeybindingsLSP('astro')

" Formatteur Settings
function! lang#astro#format()
    w
    let l:file = @%
    let l:cmd = 'silent !./node_modules/.bin/prettier --write --plugin=prettier-plugin-astro '.l:file
    execute l:cmd
    e
endfunction

call vmenu#commands([
    \['f','Format', 'call lang#astro#format()'],
\], {
    \'parent': g:keybindings_refactor_run,
    \'filetype': 'astro'
\})

