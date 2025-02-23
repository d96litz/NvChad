-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
vim.g.mapleader = " "
vim.g.copilot_assume_mapped = true
vim.keymap.set("i", "<C-x>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.keymap.set("v", "<M-j>", ":m +1")
vim.keymap.set({ "n", "v" }, "0", "^")
vim.keymap.set("v", "<leader>cj", '"+y')
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format { bufnr = args.buf }
  end,
})
-- Function to run Rspec for the current file or current line
local function run_rspec(test_line)
  local file_path = vim.fn.expand "%" -- Get the current file path

  -- Check if the current file path contains "/system/"
  if string.find(file_path, "/system/") then
    -- Check if the noVNC tab is already open
    vim.fn.systemlist "chrome-cli list tabs | grep noVNC"
    if vim.v.shell_error ~= 0 then
      -- The tab is not open, so run the chrome-cli command
      vim.cmd "!chrome-cli open http://localhost:7900/"
    end
  end

  local test_command = (string.find(file_path, "/spec/") and "rspec " .. file_path) or "rake test TEST=" .. file_path
  -- Build the Rspec command
  -- local test_command = "rspec " .. file_path
  if test_line then
    -- Append the line number if provided
    test_command = test_command .. ":" .. vim.fn.line "."
  end

  -- Run the Rspec command
  vim.cmd("!" .. test_command)
end

-- Map <leader>tt to run Rspec for the current file
vim.api.nvim_set_keymap("n", "<leader>tt", "", {
  noremap = true,
  silent = true,
  callback = function()
    run_rspec(false)
  end,
  desc = "Run Rspec for the current file",
})

-- Map <leader>tl to run Rspec for the current line
vim.api.nvim_set_keymap("n", "<leader>tl", "", {
  noremap = true,
  silent = true,
  callback = function()
    run_rspec(true)
  end,
  desc = "Run Rspec for the current line",
})
vim.opt.signcolumn = "yes"
vim.filetype.add {
  filename = {
    ["Capfile"] = "ruby",
    ["Gemfile"] = "ruby",
    ["Rakefile"] = "ruby",
  },
  pattern = {
    ["*.rb"] = "ruby",
    ["*.ru"] = "ruby",
    ["*.rake"] = "ruby",
    ["*.gemspec"] = "ruby",
  },
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.lsp.start {
      name = "rubocop",
      cmd = { "bundle", "exec", "rubocop", "--format", "json", "--force-exclusion", "--stdin", "%:p" },
    }
  end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rb",
  callback = function()
    vim.lsp.buf.format()
  end,
})
-- require("leap").create_default_mappings()
-- -- Map <leader>tt to run the current file with Rspec
-- vim.api.nvim_set_keymap("n", "<leader>tt", ":!rspec %<CR>", { noremap = true, silent = true })
-- -- Map <leader>tl to run Rspec for the current line
-- vim.api.nvim_set_keymap("n", "<leader>tl", [[:!rspec %:<C-r>=line('.')<CR><CR>]], { noremap = true, silent = true })
vim.g.copilot_no_tab_map = true
