-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.signcolumn = 'yes'

-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, '<leader>h', '^')
vim.keymap.set({'n', 'x', 'o'}, '<leader>l', 'g_')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, 'cp', '"+y')
vim.keymap.set({'n', 'x'}, 'cv', '"+p')

-- Delete text
vim.keymap.set({'n', 'x'}, 'x', '"_x')

-- Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>')
vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>')


-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

vim.api.nvim_create_user_command(
  'ReloadConfig',
  'source $MYVIMRC | PackerCompile',
  {}
)

local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = group,
  callback = function()
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'help', 'man'},
  group = group,
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})


-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('Installing packer...')
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
  print('Done.')

  vim.cmd('packadd packer.nvim')
  install_plugins = true
end

require('packer').startup(function(use)
  -- Plugin manager
  use {'wbthomason/packer.nvim'}

  -- Theming
  use {'EdenEast/nightfox.nvim'}
  use {'folke/tokyonight.nvim'}
  use {'joshdick/onedark.vim'}
  use {'tanvirtin/monokai.nvim'}
  use {'lunarvim/darkplus.nvim'}
  use {'kyazdani42/nvim-web-devicons'}
  use {'nvim-lualine/lualine.nvim'}
  use {'akinsho/bufferline.nvim'}
  use {'lukas-reineke/indent-blankline.nvim'}

  -- File explorer
  use {'kyazdani42/nvim-tree.lua'}

  -- Fuzzy finder
  use {'nvim-telescope/telescope.nvim'}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

  -- Git
  use {'lewis6991/gitsigns.nvim'}
  use {'tpope/vim-fugitive'}

  -- Code manipulation
  use {'nvim-treesitter/nvim-treesitter'}
  use {'nvim-treesitter/nvim-treesitter-textobjects'}
  use {'numToStr/Comment.nvim'}
  use {'tpope/vim-surround'}
  use {'wellle/targets.vim'}
  use {'tpope/vim-repeat'}

  -- Utilities
  use {'moll/vim-bbye'}
  use {'nvim-lua/plenary.nvim'}
  use {'editorconfig/editorconfig-vim'}
  use {'akinsho/toggleterm.nvim'}

  -- LSP support
  use {'neovim/nvim-lspconfig'}

  -- Autocomplete
  use {'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'saadparwaiz1/cmp_luasnip'}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-nvim-lua'}

  -- Snippets
  use {'L3MON4D3/LuaSnip'}
  use {'rafamadriz/friendly-snippets'}

  -- Command Completion
  use 'smolck/command-completion.nvim'
  if install_plugins then
    require('packer').sync()
  end
end)

if install_plugins then
  print '=================================='
  print '    Plugins will be installed.'
  print '    After you press Enter'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end


-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
vim.opt.termguicolors = true
vim.cmd('colorscheme carbonfox')


---
-- vim-bbye
---
vim.keymap.set('n', '<leader>bc', '<cmd>Bdelete<CR>')


---
-- lualine.nvim (statusline)
---
vim.opt.showmode = false

-- See :help lualine.txt
require('lualine').setup({
  options = {
    theme = 'ayu_mirage',
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
  },
})


---
-- bufferline
---
-- See :help bufferline-settings
require('bufferline').setup({
  options = {
    mode = 'buffers',
    offsets = {
      {filetype = 'NvimTree'}
    },
  },
  -- :help bufferline-highlights
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


---
-- Treesitter
---
-- See :help nvim-treesitter-modules
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  -- :help nvim-treesitter-textobjects-modules
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
    },
  },
  ensure_installed = {
    'python',
    'bash',
    'dockerfile',
    'lua',
    'go',
    'json'
  },
})


---
-- Comment.nvim
---
require('Comment').setup({})


---
-- Indent-blankline
---
-- See :help indent-blankline-setup
require('indent_blankline').setup({
  char = '???',
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  use_treesitter = true,
  show_current_context = false
})


---
-- Gitsigns
---
-- See :help gitsigns-usage
require('gitsigns').setup({
  signs = {
    add = {text = '???'},
    change = {text = '???'},
    delete = {text = '???'},
    topdelete = {text = '???'},
    changedelete = {text = '???'},
  }
})


---
-- Telescope
---
-- See :help telescope.builtin
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

require('telescope').load_extension('fzf')


---
-- nvim-tree (File explorer)
---
-- See :help nvim-tree-setup
require('nvim-tree').setup({
  hijack_cursor = false,
  on_attach = function(bufnr)
    local bufmap = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, {buffer = bufnr, desc = desc})
    end

    -- :help nvim-tree.api
    local api = require('nvim-tree.api')

    bufmap('L', api.node.open.edit, 'Expand folder or go to file')
    bufmap('H', api.node.navigate.parent_close, 'Close parent folder')
    bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
  end
})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')


---
-- toggleterm
---
-- See :help toggleterm-roadmap
require('toggleterm').setup({
  open_mapping = '<C-g>',
  direction = 'horizontal',
  shade_terminals = true
})


---
-- Luasnip (snippet engine)
---
-- See :help luasnip-loaders
require('luasnip.loaders.from_vscode').lazy_load()


---
-- nvim-cmp (autocomplete)
---
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

-- See :help cmp-config
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 3},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = '??',
        luasnip = '???',
        buffer = '??',
        path = '????',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  -- See :help cmp-mapping
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-d>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})


---
-- LSP config
---
-- See :help lspconfig-global-defaults
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

---
-- Diagnostic customization
---
local sign = function(opts)
  -- See :help sign_define()
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '???'})
sign({name = 'DiagnosticSignWarn', text = '???'})
sign({name = 'DiagnosticSignHint', text = '???'})
sign({name = 'DiagnosticSignInfo', text = '???'})

-- See :help vim.diagnostic.config()
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

---
-- LSP Keybindings
---
vim.api.nvim_create_autocmd('LspAttach', {
  group = group,
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- You can search each function in the help page.
    -- For example :help vim.lsp.buf.hover()

    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})


---
-- LSP servers
---

-- Prevent multiple instance of lsp servers
-- if file is sourced again
if vim.g.lsp_setup_ready == nil then
  vim.g.lsp_setup_ready = true

  -- See :help lspconfig-setup
  lspconfig.bashls.setup({})
  lspconfig.pylsp.setup({})
  lspconfig.gopls.setup({})
end

---
-- Command completion
---

require('command-completion').setup {
  border = nil, -- What kind of border to use, passed through directly to `nvim_open_win()`,
                -- see `:help nvim_open_win()` for available options (e.g. 'single', 'double', etc.)
  max_col_num = 5, -- Maximum number of columns to display in the completion window
  min_col_width = 20, -- Minimum width of completion window columns
  use_matchfuzzy = true, -- Whether or not to use `matchfuzzy()` (see `:help matchfuzzy()`) 
                         -- to order completion results
  highlight_selection = true, -- Whether or not to highlight the currently
                              -- selected item, not sure why this is an option tbh
  highlight_directories = true, -- Whether or not to higlight directories with
                                -- the Directory highlight group (`:help hl-Directory`)
  tab_completion = true, -- Whether or not tab completion on displayed items is enabled
}