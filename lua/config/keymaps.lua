local silent = { silent = true, noremap = true }

-- Open close current fold.
vim.keymap.set('n', '<Space>', 'za', silent)
vim.keymap.set('v', '<Space>', 'za', silent)
