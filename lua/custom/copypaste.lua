local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- local keys = { "d", "D", "c", "C", "x", "X", "s", "S" }
-- for _, mode in ipairs { "n", "v", "o" } do
--   for _, k in ipairs(keys) do
--     vim.keymap.set(mode, k, '"_' .. k, { noremap = true, silent = true })
--   end
-- end

-- optional: leader+d to cut into system clipboard
map("n", "<Leader>d", '"+d', opts)
map("v", "<Leader>d", '"+d', opts)
