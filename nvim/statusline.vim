lua << EOF
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  darkgrey  = '#2a2a37',
  black  = '#141414',
  lightgrey = '#1f1f28',
  white  = '#EBDBB2',
  red    = '#ff5189',
  green = '#68895D',
  grey   = '#2a2a37',
}

local theme = {
  normal = {
    a = { fg = colors.black, bg = colors.green },
    b = { fg = colors.white, bg = colors.lightgrey },
    c = { fg = colors.darkgrey, bg = colors.darkgrey },
  },

  insert = { a = { fg = colors.darkgrey, bg = colors.blue } },
  visual = { a = { fg = colors.darkgrey, bg = colors.cyan } },
  replace = { a = { fg = colors.darkgrey, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.darkgrey },
    b = { fg = colors.white, bg = colors.darkgrey },
    c = { fg = colors.darkgrey, bg = colors.darkgrey },
  },
}

require('lualine').setup {
  options = {
    theme = theme,
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        separator = { right = '', left = '' },
      },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      {
        'location',
        separator = { right = '', left = '' },
      },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_z = {'tabs'}
  },
  extensions = {},
}
EOF
