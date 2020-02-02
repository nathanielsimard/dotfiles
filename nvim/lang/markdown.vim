call vmenu#commands([
            \['p', 'Markdown Preview', 'MarkdownPreview'],
            \['s', 'Stop Markdown Preview', 'MarkdownPreviewStop']
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'markdown'
        \})

