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
  if client.server_capabilities.documentSymbolProvider then require("nvim-navic").attach(client, bufnr) end
  lsp.default_keymaps({ buffer = bufnr })
  lsp.buffer_autoformat()
end)

-- lsp.configure("tailwindcss", {
--   filetypes = { "rust" },
--   init_options = {
--     userLanguages = {
--       rust = "html",
--       svelte = "html",
--     },
--   },
-- })

lsp.configure("yamlls", {
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
})

-- lsp.configure("gopls", {
--   settings = {
--     gopls = {
--       ["build.experimentalWorkspaceModule"] = true,
--     },
--   },
-- })

lsp.setup()

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

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
require("mason-null-ls").setup({
  handlers = {},
})

-- Required when `automatic_setup` is true
-- require("mason-null-ls").setup_handlers() -- Outdated ?

require("mason-nvim-dap").setup({
  automatic_setup = true,
})
-- require("mason-nvim-dap").setup_handlers({})
