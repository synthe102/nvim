vim.opt.termguicolors = true

require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    offsets = { { filetype = "neo-tree", text = "Neo Tree 🌳", text_align = "left" } },
  },
})
