require("catppuccin").setup({
  term_colors = true,
  integrations = {
    dap = {
      enabled = true,
      enable_ui = true, -- enable nvim-dap-ui
    },
  },
})
