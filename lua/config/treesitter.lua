require('nvim-treesitter.configs').setup {
  auto_install = true,
  indent = { enable = false },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<cr>',
      node_incremental = '<tab>',
      scope_incremental = '<cr>',
      scope_decremental = '<s-cr>',
      node_decremental = '<s-tab>',
    },
  },
  textsubjects = {
    enable = true,
    lookahead = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  },
  endwise = { enable = true },
  matchup = {
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
  },
}
