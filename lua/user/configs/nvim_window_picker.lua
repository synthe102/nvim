local ok, window_picker = pcall(require, "window-picker")
if not ok then
	return
end

window_picker.setup({
	filter_rules = {
	  autoselect_one = true,
		-- filter using buffer options
		bo = {
			-- if the file type is one of following, the window will be ignored
			filetype = { "neo-tree", "neo-tree-popup", "notify" },

			-- if the buffer type is one of following, the window will be ignored
			buftype = { "terminal", "quickfix" },
		},
	},
})
