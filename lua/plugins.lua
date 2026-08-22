return {
  -- Notifications (lazy, loaded by noice)
  {
    'rcarriga/nvim-notify',
    lazy = true,
  },

  -- Noice (UI for messages, cmdline, popupmenu)
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
          },
        },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
    },
  },

  -- Motion
  {
    'chaoren/vim-wordmotion',
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    dependencies = { 'tpope/vim-repeat' },
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap forward' },
      { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap backward' },
      { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from windows' },
    },
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  {
    'ggandor/flit.nvim',
    dependencies = { { url = 'https://codeberg.org/andyg/leap.nvim' } },
    keys = {
      { 'f', mode = { 'n', 'x', 'o' } },
      { 'F', mode = { 'n', 'x', 'o' } },
      { 't', mode = { 'n', 'x', 'o' } },
      { 'T', mode = { 'n', 'x', 'o' } },
    },
    opts = { labeled_modes = 'nv' },
  },

  -- Quickfix
  { 'Olical/vim-enmasse', cmd = 'EnMasse' },
  {
    'yorickpeterse/nvim-pqf',
    ft = 'qf',
    opts = {},
  },

  -- Commenting
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle linewise' },
      { 'gb', mode = { 'n', 'v' }, desc = 'Comment toggle blockwise' },
    },
    opts = {},
  },

  -- Wrapping/delimiters
  {
    'andymass/vim-matchup',
    event = { 'BufReadPost', 'BufNewFile' },
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },

  -- Search
  {
    'romainl/vim-cool',
    event = 'CmdlineEnter',
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
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
      { 'gr', function() require('telescope.builtin').lsp_references() end, desc = 'LSP references' },
      { 'gI', function() require('telescope.builtin').lsp_implementations() end, desc = 'LSP implementations' },
    },
    config = function()
      require('config.telescope')
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('config.treesitter')
    end,
  },

  -- Indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },

  -- Icons (shared dependency)
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- Trouble (diagnostics)
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
  },

  -- File explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'Neotree',
    keys = {
      { 'tt', ':Neotree toggle<CR>', desc = 'Toggle file tree' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('config.neotree')
    end,
  },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('config.gitsigns')
    end,
  },
  {
    'NeogitOrg/neogit',
    cmd = 'Neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('config.neogit')
    end,
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    event = 'BufReadPost',
    opts = {},
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },

  -- Diffview
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- YAML
  {
    'pedrohdz/vim-yaml-folds',
    ft = { 'yaml', 'yml' },
  },

  -- Go debugging
  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    dependencies = {
      'mfussenegger/nvim-dap',
      { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },
    },
    opts = {
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
    },
  },

  -- LSP (native vim.lsp.config, Neovim 0.11+ — no nvim-lspconfig needed)
  {
    'hrsh7th/cmp-nvim-lsp',
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Shared capabilities for all LSP servers
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- Lua
      vim.lsp.config('lua_ls', {
        filetypes = { 'lua' },
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = { checkThirdParty = false },
          },
        },
      })
      vim.lsp.enable('lua_ls')

      -- Go (install: go install golang.org/x/tools/gopls@latest)
      vim.lsp.config('gopls', {
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
      })
      vim.lsp.enable('gopls')

      -- Python (install: pip install pyright)
      vim.lsp.config('pyright', {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
      })
      vim.lsp.enable('pyright')

      -- Rust is handled by rustaceanvim (see below) — don't double-configure
    end,
  },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
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
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },

  -- Tags
  {
    'preservim/tagbar',
    cmd = 'TagbarToggle',
  },

  -- Rust
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    ft = 'rust',
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

  -- Theme (load first with high priority)
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup({
        options = {
          darken = {
            float = true,
            sidebars = { enable = true },
          },
        },
      })
      vim.cmd.colorscheme('github_dark_default')
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },

  -- Which-key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    dependencies = { 'echasnovski/mini.icons' },
    opts = {},
  },

  -- GitHub (Octo)
  {
    'pwntester/octo.nvim',
    cmd = 'Octo',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
  },

  -- dashboard
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('config.alpha')
    end,
  },
}
