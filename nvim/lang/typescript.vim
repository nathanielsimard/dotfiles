lua << EOF
require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.diagnosticls.setup{
  filetypes = { "javascript", "typescript", "vue" },
  init_options = {
    filetypes = {
      javascript = "eslint",
      typescript = "eslint",
      vue = "eslint",
    },
    linters = {
      eslint = {
        sourceName = "eslint",
        command = "./node_modules/.bin/eslint",
        rootPatterns = { "package.json" },
        debounce = 100,
        args = {
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json",
        },
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity",
        };
        securities = {
          [2] = "error",
          [1] = "warning"
        }
      }
    }
  }
}
EOF

call RegisterKeybindingsLSP('typescript')
call RegisterKeybindingsLSP('javascript')
call RegisterKeybindingsLSP('vue')

" Test Utilities
if !exists('g:typescript_project_root')
    let g:typescript_project_root=''
end

if !exists('g:typescript_project_tests_root')
    let g:typescript_project_tests_root=''
end

let s:test_utils_ts =  g:Test.new({
            \'root_src' : g:typescript_project_root,
            \'root_test' : g:typescript_project_tests_root,
            \'suffix_src' : '.ts',
            \'suffix_test' : '.spec.ts',
            \'runner_test' : './node_modules/.bin/jest --coverage=False',
            \})

let s:test_utils_js =  g:Test.new({
            \'root_src' : g:typescript_project_root,
            \'root_test' : g:typescript_project_tests_root,
            \'suffix_src' : '.js',
            \'suffix_test' : '.spec.js',
            \'runner_test' : './node_modules/.bin/jest --coverage=False',
            \})

function! lang#typescript#test_toggle()
    if &filetype ==# 'javascript'
        call s:test_utils_js.toggle()
    else
        call s:test_utils_ts.toggle()
    endif
endfunction

function! lang#typescript#test_file()
    if &filetype ==# 'javascript'
        call s:test_utils_js.test_file()
    else
        call s:test_utils_ts.test_file()
    endif
endfunction

" Formatteur Settings
function! lang#typescript#format()
    lua vim.lsp.buf.formatting()
    w
    let l:file = @%
    let l:cmd = 'silent !./node_modules/.bin/eslint --fix --cache '.l:file
    execute l:cmd
    e
endfunction

" Run Settings
let g:repl_terminal_typescript = g:ReplTerminal.new('')
call terminal#repl_setup('typescript', 'g:repl_terminal_typescript')

function! lang#typescript#test_watch()
    let l:file = @%
    let l:command = './node_modules/.bin/jest --watch --coverage=false '.l:file
    call g:repl_terminal_typescript.run(l:command)
endfunction

function! RegisterKeybindingsTypescript(filetype)
    call vmenu#commands([
            \['t', 'Test - Impl', 'call lang#typescript#test_toggle()'],
        \], {
            \'parent': g:keybindings_jumps_jobs,
            \'filetype': a:filetype
        \})
    call vmenu#commands([
            \['t','Test File', 'call lang#typescript#test_file()'],
            \['f','Format', 'call lang#typescript#format()'],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': a:filetype
        \})
    call vmenu#commands([
            \['w', 'REPL Watch Test', 'call lang#typescript#test_watch()'],
        \], {
            \'parent': g:keybindings_interactive,
            \'filetype': a:filetype
        \})
endfunction

call RegisterKeybindingsTypescript('typescript')
call RegisterKeybindingsTypescript('javascript')
call RegisterKeybindingsTypescript('vue')
