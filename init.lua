require('config.options')
require('config.keybinds')
require('config.lazy')
vim.opt.rtp:append("/home/alva/.local/share/nvim/site")
vim.opt.clipboard = "unnamedplus"

-- Resize vertical splits using Alt (Meta) + h/l keys
vim.keymap.set('n', '<M-h>', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<M-l>', ':vertical resize +2<CR>', { silent = true })

-- (The old LuaSnip InsertLeave autocmd is no longer needed: the Tab fix now
-- lives in lua/plugins/cmp.lua.)
