require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "-" },
	},
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 50,
	},
})
