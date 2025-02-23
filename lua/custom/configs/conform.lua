require("conform").setup {
  lsp_format = "fallback",

  formatters_by_ft = {
    lua = { "stylua" },

    javascript = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    ruby = { "prettier" },
    erb = { "prettier" },
    slim = { "prettier" },
    svelte = { "prettier" },

    sh = { "shfmt" },
    elixir = { "mix" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },

  -- adding same formatter for multiple filetypes can look too much work for some
  -- instead of the above code you could just use a loop! the config is just a table after all!

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}
