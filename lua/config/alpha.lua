local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  [=[           |    |              _.-7                  ]=],
  [=[           |\.-.|             ( ,(_                  ]=],
  [=[           | a a|              \  \,                 ]=],
  [=[           ) ["||          _.--' \  \                ]=],
  [=[        .-'  '-''-..____.-'    ___)  )\              ]=],
  [=[       F   _/-``-.__;-.-.--`--' . .' \_L_            ]=],
  [=[      |   l  {~~} ,_\  '.'.      ` __.' )\           ]=],
  [=[      (    -.;___,;  | '- _       :__.'( /           ]=],
  [=[      | -.__ _/_.'.-'      '-._ .'      \            ]=],
  [=[      |     .'   |  -- _                 '\,         ]=],
  [=[      |  \ /--,--{ .    '---.__.       .'  .'        ]=],
  [=[      J  ;/ __;__]. '.-.            .-' )_/          ]=],
  [=[      J  (-.     '\'. '. '-._.-.-'--._ /             ]=],
  [=[      |  |  '. .' | \'. '.    ._       \             ]=],
  [=[      |   \   T   |  \  '. '._  '-._    '.           ]=],
  [=[      F   J   |   |  '.    .  '._   '-,_.--`         ]=],
  [=[      F   \   \   F .  \    '.   '.  /               ]=],
  [=[     J     \  |  J   \  '.   '.    '/                ]=],
  [=[     J      '.L__|    .   \    '    |                ]=],
  [=[     |   .    \  |     \   '.   '. /                 ]=],
  [=[     |    '    '.|      |    ,-.  (                  ]=],
  [=[     F   | ' ___  ',._   .  /   '. \                 ]=],
  [=[     F   (.'`|| (-._\ '.  \-      '-\                ]=],
  [=[     \ .-'  ( L `._ '\ '._ (                         ]=],
  [=[     /'  |  /  '-._\      ''\                        ]=],
  [=[         `-'                                          ]=],
}

dashboard.section.buttons.val = {
  dashboard.button("b", "> Browse", ":lua require('telescope.builtin').find_files({previewer = false})"),
  dashboard.button("f", "> Search", ":lua require('telescope.builtin').live_grep({})"),
  dashboard.button("g", "> Git", ":Neogit"), 
}

alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
