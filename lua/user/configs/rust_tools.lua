local path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/") or ""
local codelldb_path = path .. "adapter/codelldb"
local liblldb_path = path .. "lldb/lib/liblldb.so"
local opts = {}

local lsp = require("lsp-zero").preset({
  name = "recommended",
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
})

local rust_lsp = lsp.build_options("rust_analyzer", {})

if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
  opts.dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  }
else
  local msg = "Either codelldb or liblldb is not readable."
      .. "\n codelldb: "
      .. codelldb_path
      .. "\n liblldb: "
      .. liblldb_path
  vim.notify(msg, vim.log.levels.ERROR)
end

opts.server = rust_lsp
opts.tools = {
  executor = require("rust-tools.executors").toggleterm,
  hover_actions = { auto_focus = true }
}

require("rust-tools").setup(opts)
