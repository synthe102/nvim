vim.opt.laststatus = 3

-- local foo = require("foo")

-- local spotify_status = ""
-- local function update_spotify_status()
-- 	local Job = require("plenary.job")
-- 	Job:new({
-- 		command = "spotify",
-- 		args = { "status" },
-- 		on_exit = function(a, _, _)
-- 			local result = a._stderr_results
-- 			if string.find(result[1], "Error") then
-- 				return
-- 			end
-- 			for i, string in ipairs(result) do
-- 				result[i] = string:gsub("^%s*(.-)%s*$", "%1")
-- 			end
-- 			spotify_status = "| " .. result[1] .. " - " .. result[2] .. " - " .. result[3]
-- 		end,
-- 	}):start()
-- end
--
-- if _G.Gstatus_timer == nil then
-- 	_G.Gstatus_timer = vim.loop.new_timer()
-- else
-- 	_G.Gstatus_timer:stop()
-- end
-- _G.Gstatus_timer:start(0, 10000, vim.schedule_wrap(update_spotify_status))

require("lualine").setup({
	options = {
		theme = "catppuccin",
		section_separators = "",
		component_separators = "",
	},
	-- sections = {
	-- 	lualine_c = {
	-- 		"filename",
	-- 		function()
	-- 			return spotify_status
	-- 		end,
	-- 	},
	-- },
})
