local silent = { silent = true, noremap = true }

-- Open close current fold.
vim.keymap.set('n', '<Space>', 'za', silent)
vim.keymap.set('v', '<Space>', 'za', silent)

-- Find the enclosing function/method node at (or above) the current cursor position.
local function enclosing_named_node()
  local buf = vim.api.nvim_get_current_buf()
  local ok_parser, parser = pcall(vim.treesitter.get_parser, buf)
  if not ok_parser or parser == nil then
    vim.notify('No treesitter parser available for this buffer', vim.log.levels.WARN)
    return nil
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  local tree = parser:parse()[1]
  local root = tree:root()

  -- Try the cursor point, then the end of the current line. The end of a
  -- signature line always lies inside the function node, while col 0 sits on
  -- leading indent -- a sibling of the signature, not an ancestor.
  local probes = {
    { row, col },
    { row, math.max(0, #vim.api.nvim_get_current_line() - 1) },
  }

  for _, probe in ipairs(probes) do
    local node = root:descendant_for_range(probe[1], probe[2], probe[1], probe[2])
    while node do
      if node:field('name')[1] then
        return node
      end
      node = node:parent()
    end
  end
  return nil
end

-- Jump to the name of the function enclosing (or starting on) the current line.
local function goto_function_name()
  local node = enclosing_named_node()
  if not node then
    vim.notify('No enclosing function found', vim.log.levels.WARN)
    return
  end

  local r, c = node:field('name')[1]:start()
  vim.api.nvim_win_set_cursor(0, { r + 1, c })
end

-- Jump to the argument list of the function enclosing the current line.
local function goto_arguments()
  local node = enclosing_named_node()
  if not node then
    vim.notify('No enclosing function found', vim.log.levels.WARN)
    return
  end

  local params = node:field('parameters')[1]
  if not params then
    vim.notify('No parameters found', vim.log.levels.WARN)
    return
  end

  local r, c = params:start()
  vim.api.nvim_win_set_cursor(0, { r + 1, c })
end

-- Jump to the declared return type of the function enclosing the current line.
local function goto_return_type()
  local node = enclosing_named_node()
  if not node then
    vim.notify('No enclosing function found', vim.log.levels.WARN)
    return
  end

  local ret = node:field('return_type')[1] or node:field('result')[1]
  if not ret then
    vim.notify('No return type found', vim.log.levels.WARN)
    return
  end

  local r, c = ret:start()
  vim.api.nvim_win_set_cursor(0, { r + 1, c })
end

vim.keymap.set('n', 'gm', goto_function_name, { desc = 'Jump to function name' })
vim.keymap.set('n', 'gA', goto_arguments, { desc = 'Jump to function arguments' })
vim.keymap.set('n', 'gR', goto_return_type, { desc = 'Jump to return type' })

-- ── LSP ──────────────────────────────────────────────────────────

-- Navigation
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'go', vim.lsp.buf.document_symbol, { desc = 'Document symbols' })
vim.keymap.set('n', 'gW', vim.lsp.buf.workspace_symbol, { desc = 'Workspace symbols' })

-- Info
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Diagnostic at cursor' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- Refactor
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format buffer' })

-- Call hierarchy
vim.keymap.set('n', 'gci', vim.lsp.buf.incoming_calls, { desc = 'Incoming calls' })
vim.keymap.set('n', 'gco', vim.lsp.buf.outgoing_calls, { desc = 'Outgoing calls' })
