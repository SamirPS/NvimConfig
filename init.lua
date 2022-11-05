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