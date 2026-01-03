vim.lsp.inlay_hint.enable(true)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- lua_ls
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- clangd
vim.lsp.config("clangd", {
  capabilities = capabilities,
})

-- require "lsp.lua_ls"
