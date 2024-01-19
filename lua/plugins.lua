local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use 'rcarriga/nvim-notify'

  -- motion
  use 'chaoren/vim-wordmotion'
  use {
    {
      'ggandor/leap.nvim',
      requires = 'tpope/vim-repeat',
    },
    { 'ggandor/flit.nvim', config = [[require'flit'.setup { labeled_modes = 'nv' }]] },
  }

  -- Quickfix
  use { 'Olical/vim-enmasse', cmd = 'EnMasse' }
  use 'kevinhwang91/nvim-bqf'
  use {
    'https://gitlab.com/yorickpeterse/nvim-pqf',
    config = function()
      require('pqf').setup()
    end,
  }

  -- Commenting
  use {
    'numToStr/Comment.nvim',
    event = 'User ActuallyEditing',
    config = function()
      require('Comment').setup {}
    end,
  }

  -- Wrapping/delimiters
  use {
    'andymass/vim-matchup',
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  }

  -- Search
  use 'romainl/vim-cool'
  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'telescope-frecency.nvim',
        'telescope-fzf-native.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
      },
      wants = {
        'popup.nvim',
        'plenary.nvim',
        'telescope-frecency.nvim',
        'telescope-fzf-native.nvim',
      },
      setup = [[require('config.telescope_setup')]],
      config = [[require('config.telescope')]],
      cmd = 'Telescope',
      module = 'telescope',
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      after = 'telescope.nvim',
      requires = 'tami5/sqlite.lua',
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
    'crispgm/telescope-heading.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
  }

  -- Highlights
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    event = 'User ActuallyEditing',
    config = [[require 'config.treesitter']],
  }

  -- Indentation tracking
  --use { 'RRethy/nvim-treesitter-textsubjects', after = 'nvin-treesitter' }
  use { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' }
  use { 'lukas-reineke/indent-blankline.nvim', after = 'nvim-treesitter' }

  use 'arcticicestudio/nord-vim'

  use 'kyazdani42/nvim-web-devicons'
  use {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    config = function()
      require('trouble').setup {}
    end,
  }

  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    config = [[require('config.neotree')]],
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
  }

  -- Git
  use {
    {
      'lewis6991/gitsigns.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = [[require('config.gitsigns')]],
      event = 'User ActuallyEditing',
    },
    {
      'NeogitOrg/neogit',
      requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
        'nvim-telescope/telescope.nvim',
      },
      config = [[require('config.neogit')]], 
    },
    {
      'akinsho/git-conflict.nvim',
      tag = '*',
      config = function()
        require('git-conflict').setup()
      end,
      event = 'BufReadPost',
    },
  }

  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'pedrohdz/vim-yaml-folds' }
  use { 'fatih/vim-go' }

  use {
    'neovim/nvim-lspconfig',
    config = function ()
      require('lspconfig').rust_analyzer.setup {
        settings = {
          ['rust-analyzer'] = {
            check = {
              command = "clippy";
            },
            diagnostics = {
              enable = true;
            }
          }
        }
      }

      require('lspconfig').gopls.setup{}
    end
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    },
    config = function()
      require('cmp').setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        sources =  {
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
      })
    end
  }

  use 'preservim/tagbar'
  use {
    'simrat39/rust-tools.nvim',
    config = function()
      require("rust-tools").setup({
        tools = {
          runnables = {
            use_telescope = true,
          },
          inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
          }
        }
      })
    end
  }

  use {
    'projekt0n/github-nvim-theme',
    config = function()
      require('github-theme').setup({
        options = {
          darken = {
            float = true,
            sidebars = {
              enabled = true,
            },
          },
        },
      })

      vim.cmd('colorscheme github_dark')
    end
  }

  use {
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true

      require('bufferline').setup{}
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
