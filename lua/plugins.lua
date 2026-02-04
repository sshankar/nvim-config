return {
  -- Notifications
  { 'rcarriga/nvim-notify' },

  -- Fuzzy finder
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  -- Noice (UI for messages, cmdline, popupmenu)
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup()
    end,
  },

  -- Motion
  { 'chaoren/vim-wordmotion' },
  {
    'https://codeberg.org/andyg/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  {
    'ggandor/flit.nvim',
    config = function()
      require('flit').setup { labeled_modes = 'nv' }
    end,
  },

  -- Quickfix
  { 'Olical/vim-enmasse', cmd = 'EnMasse' },
  { 'kevinhwang91/nvim-bqf' },
  {
    'https://gitlab.com/yorickpeterse/nvim-pqf',
    config = function()
      require('pqf').setup()
    end,
  },

  -- Commenting
  {
    'numToStr/Comment.nvim',
    event = 'User ActuallyEditing',
    config = function()
      require('Comment').setup {}
    end,
  },

  -- Wrapping/delimiters
  {
    'andymass/vim-matchup',
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },

  -- Search
  { 'romainl/vim-cool' },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'crispgm/telescope-heading.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      {
        'nvim-telescope/telescope-frecency.nvim',
        dependencies = { 'kkharji/sqlite.lua' },
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
    keys = {
      { '<c-p>', function() require('telescope.builtin').buffers() end, desc = 'Buffers' },
      { '<c-o>', function() require('telescope.builtin').oldfiles() end, desc = 'Old files' },
      { '<c-e>', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
      { '<c-s>', function() require('telescope.builtin').git_files() end, desc = 'Git files' },
      { '<c-d>', function() require('telescope.builtin').grep_string() end, desc = 'Grep string' },
      { '<c-g>', function() require('telescope.builtin').live_grep() end, desc = 'Live grep' },
    },
    config = [[require('config.telescope')]],
  },

  -- Highlights
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = [[require 'config.treesitter']],
  },

  -- Indentation tracking
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- Colorscheme
  { 'arcticicestudio/nord-vim' },

  -- Icons
  { 'kyazdani42/nvim-web-devicons' },

  -- Trouble (diagnostics)
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    config = function()
      require('trouble').setup {}
    end,
  },

  -- File explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = [[require('config.neotree')]],
  },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'User ActuallyEditing',
    config = [[require('config.gitsigns')]],
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = [[require('config.neogit')]],
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    event = 'BufReadPost',
    config = function()
      require('git-conflict').setup()
    end,
  },

  -- Statusline
  { 'vim-airline/vim-airline' },
  { 'vim-airline/vim-airline-themes' },

  -- Diffview
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- YAML
  { 'pedrohdz/vim-yaml-folds' },

  -- Go
  { 'fatih/vim-go' },
  {
    'leoluz/nvim-dap-go',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('dap-go').setup({
        dap_configurations = {
          {
            type = 'go',
            name = 'Attach Remote',
            mode = 'remote',
            request = 'attach',
          },
        },
        delve = {
          build_flags = '-tags=integration',
        },
      })
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- LSP configuration can be added here
    end,
  },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
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
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
      })
    end,
  },

  -- Tags
  { 'preservim/tagbar' },

  -- Rust
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
    ft = { 'rust' },
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          inlay_hints = {
            auto = true,
            show_parameter_hints = false,
          },
        },
      }
    end,
  },

  -- Theme
  {
    'projekt0n/github-nvim-theme',
    priority = 1000,
    config = function()
      require('github-theme').setup({
        options = {
          darken = {
            float = true,
            sidebars = {
              enable = true,
            },
          },
        },
      })
      vim.cmd('colorscheme github_dark')
    end,
  },

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      vim.opt.termguicolors = true
      require('bufferline').setup {}
    end,
  },

  -- Which-key
  {
    'folke/which-key.nvim',
    dependencies = { 'echasnovski/mini.icons' },
  },

  -- GitHub (Octo)
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup()
    end,
  },
}
