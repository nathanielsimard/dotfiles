let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'
lua require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
call RegisterKeybindingsLSP('javascript')

" Test Utilities
if !exists('g:javascript_project_root')
    let g:javascript_project_root=''
end

if !exists('g:javascript_project_tests_root')
    let g:javascript_project_tests_root=''
end

let s:test_utils =  g:Test.new({
            \'root_src' : g:javascript_project_root,
            \'root_test' : g:javascript_project_tests_root,
            \'suffix_src' : '.js',
            \'suffix_test' : '.spec.js',
            \'runner_test' : './node_modules/.bin/jest --coverage=False',
            \})

function! lang#javascript#test_toggle()
    call s:test_utils.toggle()
endfunction

function! lang#javascript#test_file()
    call s:test_utils.test_file()
endfunction

call vmenu#commands([
            \['t', 'Test - Impl', 'call lang#javascript#test_toggle()'],
        \], {
            \'parent': g:keybindings_jumps_jobs,
            \'filetype': 'javascript'
        \})

" Formatteur Settings
function! lang#javascript#format()
    lua vim.lsp.buf.formatting()
    w
    let l:file = @%
    let l:cmd = 'silent !./node_modules/.bin/eslint --fix '.l:file
    execute l:cmd
    e
endfunction

" Run Settings
call vmenu#commands([
            \['t','Test File', 'call lang#javascript#test_file()'],
            \['f','Format', 'call lang#javascript#format()'],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'javascript'
        \})

let g:repl_terminal_javascript = g:ReplTerminal.new('')
call terminal#repl_setup('javascript', 'g:repl_terminal_javascript')

function! lang#javascript#test_watch()
    let l:file = @%
    let l:command = './node_modules/.bin/jest --watch --coverage=false '.l:file
    call g:repl_terminal_javascript.run(l:command)
endfunction

call vmenu#commands([
            \['w', 'REPL Watch Test', 'call lang#javascript#test_watch()'],
        \], {
            \'parent': g:keybindings_interactive,
            \'filetype': 'javascript'
        \})

