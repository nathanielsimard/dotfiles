" Language Serveur Settings

lua << EOF
require'lspconfig'.pyright.setup{
    settings = {
        python = {
            analysis = {
                useLibraryCodeForTypes = true,
                typeCheckingMode = "off",
            }
        }
    }
}
require'lspconfig'.diagnosticls.setup{
    filetypes = { "python" },
    init_options = {
        filetypes = {
            python = {
                "flake8",
                "mypy"
            }
        },
        linters = {
            flake8 = {
                command = "flake8",
                rootPatterns = {
                    "environment.yml",
                    "requirements.txt"
                },
                debounce = 100,
                args = {
                    "--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s",
                    "-",
                },
                offsetLine = 0,
                offsetColumn = 0,
                sourceName = "flake8",
                formatLines = 1,
                formatPattern = {
                    "(\\d+),(\\d+),([A-Z]),(.*)(\\r|\\n)*$",
                    {
                        line = 1,
                        column = 2,
                        security = 3,
                        message = 4
                    }
                },
                securities = {
                    W = "warning",
                    E = "error",
                    F = "error",
                    C = "error",
                    N = "error"
                }
            },

            mypy = {
                sourceName = "mypy",
                command = "mypy",
                rootPatterns = {
                    "environment.yml",
                    "requirements.txt"
                },
                args = {
                    "--no-color-output",
                    "--no-error-summary",
                    "--show-column-numbers",
                    "--follow-imports=silent",
                    "%file"
                },
                formatPattern = {
                    "^.*:(\\d+?):(\\d+?): ([a-z]+?): (.*)$",
                    {
                        line = 1,
                        column = 2,
                        security = 3,
                        message = 4
                    }
                },
                securities = {
                    error ="error",
                }
            }
        }
    }
}
EOF

let g:autoformat_on_save['python'] = 0
call RegisterKeybindingsLSP('python')

function! lang#python#run()
    let l:file = @%
    call terminal#run_command('python '.l:file)
endfunction

" Test Utilities
if !exists('g:python_project_root')
    let g:python_project_root='src'
end

if !exists('g:python_project_tests_root')
    let g:python_project_tests_root='tests'
end

let s:test_utils =  g:Test.new({
            \'root_src' : g:python_project_root,
            \'root_test' : g:python_project_tests_root,
            \'suffix_src' : '.py',
            \'suffix_test' : '_test.py',
            \'runner_test' : 'pytest',
            \})

function! lang#python#test_toggle()
    call s:test_utils.toggle()
endfunction

function! lang#python#test_file()
    call s:test_utils.test_file()
endfunction

function! lang#python#test_suite()
    call terminal#run_command('pytest . --ignore it')
endfunction

" Formatteur Settings
function! lang#python#format()
    w
    let l:file = @%
    let l:cmd = 'silent !black '.l:file
    execute l:cmd
    e
endfunction


" Run Settings
call vmenu#commands([
            \['e', 'Execute file', 'call lang#python#run() '],
            \['t','Test File', 'call lang#python#test_file()'],
            \['s','Test Suite', 'call lang#python#test_suite()'],
            \['f','Format', 'call lang#python#format()'],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'python'
        \})

call vmenu#commands([
            \['t', 'Test - Impl', 'call lang#python#test_toggle()'],
        \], {
            \'parent': g:keybindings_jumps_jobs,
            \'filetype': 'python'
        \})

let g:repl_terminal_python = g:ReplTerminal.new('ipython --no-autoindent --matplotlib')
call terminal#repl_setup('python', 'g:repl_terminal_python')

function! lang#python#repl_import()
    let l:file = @%
    let l:import = substitute(l:file, '/', '.', 'g')
    let l:command = 'import '.l:import[0:-4]
    call g:repl_terminal_python.run(l:command)
endfunction

call vmenu#commands([
            \['i', 'REPL Import File', 'call lang#python#repl_import() '],
        \], {
            \'parent': g:keybindings_interactive,
            \'filetype': 'python'
        \})

