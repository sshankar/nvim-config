require("neo-tree").setup({
  filesystem = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,
    },
    group_empty_dirs = true,
  }
})

vim.g.neo_tree_remove_legacy_commands = true
