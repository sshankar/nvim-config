require("neo-tree").setup({
  enable_git_status = true,
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

local neo_tree_auto_open_group = vim.api.nvim_create_augroup("NeoTreeAutoOpenOnFile", { clear = true })

local function is_real_file_buffer(bufnr)
  if vim.bo[bufnr].buftype ~= "" then
    return false
  end

  local file_path = vim.api.nvim_buf_get_name(bufnr)
  if file_path == "" then
    return false
  end

  local stat = (vim.uv or vim.loop).fs_stat(file_path)
  return stat ~= nil and stat.type == "file"
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = neo_tree_auto_open_group,
  callback = function(args)
    if vim.bo[args.buf].filetype == "neo-tree" then
      return
    end

    if not is_real_file_buffer(args.buf) then
      return
    end

    vim.schedule(function()
      vim.cmd("Neotree reveal")
    end)
  end,
})
