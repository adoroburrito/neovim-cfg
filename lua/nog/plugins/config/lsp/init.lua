local M = {}

local servers = {
  html = {},
  jsonls = {},
  pyright = {},
  rust_analyzer = {},
  lua_ls = {},
  tsserver = {},
  vimls = {},
  omnisharp = {},
  yamlls = {},
  gopls = {},
  jdtls = {},
}

local lsp_signature = require "lsp_signature"
lsp_signature.setup {
  bind = true,
  handler_opts = {
    border = "rounded",
  },
}

local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  require("nog.plugins.config.lsp.keymaps").setup(client, bufnr)

  -- Aerial
  -- require("aerial").on_attach(client, bufnr)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local opts = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

function M.setup()
  require("nog.plugins.config.lsp.installer").setup(servers, opts)
end

return M
