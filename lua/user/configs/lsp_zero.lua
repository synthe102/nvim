local lsp = require("lsp-zero").preset({
  name = "recommended",
  set_lsp_keymaps = true,
  manage_nvim_cmp = {
    set_sources = "recommended",
  },
  suggest_lsp_servers = true,
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

require("nvim-navic").setup({ highlight = true })

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  if client.server_capabilities.documentSymbolProvider then require("nvim-navic").attach(client, bufnr) end
  lsp.buffer_autoformat()
end)

require("lspconfig").gopls.setup({
  on_init = function(client) client.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true end,
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,
})

local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "neorg" },
    { name = "path" },
    { name = "buffer" },
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm(),
  },
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

null_ls.setup({
  on_attach = function(client, bufnr) null_opts.on_attach(client, bufnr) end,
})

-- See mason-null-ls.nvim's documentation for more details:
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
require("mason").setup()
require("mason-null-ls").setup({
  handlers = {},
})

-- Required when `automatic_setup` is true
-- require("mason-null-ls").setup_handlers() -- Outdated ?

require("mason-nvim-dap").setup({
  ensure_installed = { "delve" },
  handlers = {},
})
-- require("mason-nvim-dap").setup_handlers({})
