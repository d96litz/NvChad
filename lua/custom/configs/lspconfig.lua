local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd",  "elixirls", "tailwindcss" }

local lsp_options = { on_attach = on_attach, capabilities = capabilities }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup { lsp_options }
end

lspconfig.elixirls.setup(vim.tbl_deep_extend("force", {}, {
  cmd = { "elixir-ls" },
  settings = { elixirLS = { dializerEnabled = false } }
}))
lspconfig.tailwindcss.setup(vim.tbl_deep_extend("force", {}, {
  filetypes = { "html", "elixir", "eelixir", "heex" },
      init_options = {
        userLanguages = {
          elixir = "html-eex",
          eelixir = "html-eex",
          heex = "html-eex",
        },
      },
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              'class[:]\\s*"([^"]*)"',
            },
          },
        },
      },
}))
-- 
-- lspconfig.pyright.setup { blabla}
