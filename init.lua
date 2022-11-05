-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
vim.opt.showmode = false

require('plugins')



vim.cmd("colorscheme carbonfox")
require("nvim-tree").setup()

require("toggleterm").setup{
   direction ='horizontal',
   shell = 'bash',
  }

require('lualine').setup({
    options = {
      theme = 'nightfly',
      icons_enabled = true,
      component_separators = '|',
      section_separators = '',
    },
  })

require('bufferline').setup({
    options = {
        mode = 'buffers',
        offsets = {
        {filetype = 'NvimTree'}
        },
    },
    highlights = {
      buffer_selected = {
        italic = false
      },
      indicator_selected = {
        fg = {attribute = 'fg', highlight = 'Function'},
        italic = false
      }
    }
  })

  require('indent_blankline').setup({
    char = '▏',
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    use_treesitter = true,
    show_current_context = false
  })