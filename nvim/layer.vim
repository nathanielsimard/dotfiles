let g:Plugin={}
function g:Plugin.new(name, ...)
    let l:newPlugin = copy(self)
    let l:newPlugin.name = a:name
    if a:0 ==# 1
        let l:newPlugin.opts = a:1
    else
        let l:newPlugin.opts = {}
    endif
    return l:newPlugin
endfunction

function g:Plugin.register(opts)
    Plug self.name, extend(self.opts, a:opts)
endfunction

let g:Layer={}
function g:Layer.new(config, plugins, opts)
    let l:newLayer = copy(self)
    let l:newLayer.config = a:config
    let l:newLayer.plugins = a:plugins
    let l:newLayer.opts = a:opts
    return l:newLayer
endfunction

function g:Layer.register()
    for plugin in self.plugins
        call plugin.register(self.opts)
    endfor
endfunction

function g:Layer.configure(layer_id)
    execute 'source '.self.config
endfunction

let g:SimpleLayer={}
function g:SimpleLayer.new(config, plugins)
    let l:newSimpleLayer = g:Layer.new(a:config, a:plugins, {})
    return extend(l:newSimpleLayer, copy(self))
endfunction

let g:FileTypeLayer={}
function g:FileTypeLayer.new(filetype, config, plugins)
    let l:newFileTypeLayer = g:Layer.new(a:config, a:plugins, {'for': a:filetype})
    let l:newFileTypeLayer.filetype = a:filetype
    let l:newFileTypeLayer.configured = 0
    return extend(l:newFileTypeLayer, copy(self))
endfunction

function g:FileTypeLayer.configure(layer_id)
    execute 'autocmd FileType '.self.filetype.' :call  g:Editor.layers['.a:layer_id.'].load_config()'
endfunction

function g:FileTypeLayer.load_config()
    if self.configured ==# 0
        execute 'source '.self.config
        let self.configured = 1
        e " Reload the file, needed by LSP :(
    endif
endfunction

let g:Editor = {}
let g:Editor.layers = []

function! g:Editor.add_layer(layer)
    call add(g:Editor.layers, a:layer)
endfunction

function! g:Editor.configure()
    " Register Plugins
    call plug#begin()
    for layer in g:Editor.layers
        call layer.register()
    endfor
    call plug#end()

    " Configure Layers
    let l:index = 0
    for layer in g:Editor.layers
        call layer.configure(l:index)
        let l:index = l:index + 1
    endfor
endfunction

