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
   open_mapping = '<C-t>',
   direction ='horizontal',
   shell = 'bash',
   shade_terminals = true
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

  require('nvim-treesitter.configs').setup({
    highlight = {
      enable = true,
    },
    ensure_installed = {
      'dockerfile',
      'python',
      'go',
    },
  })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('telescope').setup {
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      }
    }
  }
  -- To get fzf loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  require('telescope').load_extension('fzf')