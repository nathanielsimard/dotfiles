let b:current_syntax = 'keybindingMenu'

syntax match ibracketOperator '\['
syntax match obracketOperator '\]'
syntax match menuTag '\v.\ze\]'
syntax match menuText '\v ([a-z,A-Z,0-9, ,\-,+,\n])* '

highlight link menuTag Type
highlight link menuText Function

highlight link ibracketOperator Number
highlight link obracketOperator Number
