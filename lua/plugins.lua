return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "EdenEast/nightfox.nvim"
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use {'akinsho/toggleterm.nvim', tag = '*'}
  use {'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'kyazdani42/nvim-web-devicons'}
  use "lukas-reineke/indent-blankline.nvim"
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
}

use {
    'nvim-telescope/telescope.nvim',branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
use {'tpope/vim-fugitive'}
use "nvim-lua/plenary.nvim"


end)