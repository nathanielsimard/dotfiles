let b:current_syntax = 'keybindingMenu'

syntax match menuTag '\v([a-z|A-Z|0-9|<|>|\-])*\ze\]'
syntax match menuBracket '\v\[|\]'
syntax match menuText '\v ([a-z,A-Z,0-9, ,\-,+,\n])* '
syntax match menuTitle '\v ([a-z,A-Z,0-9, ,\-,+])*\ze\>'
syntax match menuLBar '\v(\-)*\<'
syntax match menuRBar '\v\>(\-)*'

highlight link menuTag Tag
highlight link menuText Function
highlight link menuLBar Comment
highlight link menuRBar Comment
highlight link menuBracket Delimiter
