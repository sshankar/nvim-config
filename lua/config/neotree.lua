require("neo-tree").setup({
  filesystem = {
    follow_current_file = true,
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,
    }
  }
})
