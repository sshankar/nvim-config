local map = vim.keymap.set
local builtin = require('telescope.builtin')
local silent = { silent = true, noremap = true }
-- Navigate buffers and repos
map('n', '<c-p>', builtin.buffers, silent)
map('n', '<c-o>', builtin.oldfiles, silent)
map('n', '<c-e>', builtin.find_files, silent)
map('n', '<c-s>', builtin.git_files,  silent)
map('n', '<c-d>', builtin.grep_string,  silent)
map('n', '<c-g>', builtin.live_grep, silent)
