let b:current_syntax = 'keybindingMenu'

syntax match menuTag '\v([a-z|A-Z|0-9|<|>|\-])*\ze\]'
syntax match menuBracket '\v\[|\]'
syntax match menuText '\v ([a-z,A-Z,0-9, ,\-,+,\n])* '

highlight link menuTag Type
highlight link menuText Function
highlight link menuBracket Number
