call vmenu#commands([
            \['p', 'Open Preview', 'MarkdownPreview'],
            \['s', 'Stop Preview', 'MarkdownPreviewStop']
        \], {
            \'parent': g:keybindings_help,
            \'filetype': 'markdown'
        \})

