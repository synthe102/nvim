local lsp = require("lsp-zero")

local lsp_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end
  lsp.buffer_autoformat()
end

lsp.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
})

local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "neorg" },
    { name = "path" },
    { name = "buffer" },
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm(),
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
  },
  formatting = lsp.cmp_format(),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  }
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())


require("mason").setup()
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        on_init = function(client)
          lsp.nvim_lua_settings(client, {})
        end,
      })
    end,
  }
})

-- Required when `automatic_setup` is true

require("mason-nvim-dap").setup({
  ensure_installed = { "delve" },
  handlers = {},
})
