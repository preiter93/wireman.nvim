local M = {}

-- Default config
M.config = {
	cmd = "wireman", -- command to run Wireman
	float_opts = {
		border = "single", -- single, double, rounded, etc.
		width = 0.9, -- width as fraction of screen
		height = 0.8, -- height as fraction of screen
	},
}

-- Setup function for user config
M.setup = function(user_config)
	M.config = vim.tbl_deep_extend("force", M.config, user_config or {})
end

-- Internal buffer handle
M._buf = nil

-- Toggle floating Wireman terminal
M.toggle = function()
	if M._buf and vim.api.nvim_buf_is_valid(M._buf) then
		local win = vim.fn.bufwinid(M._buf)
		if win ~= -1 then
			-- If floating window is open close buffer
			vim.api.nvim_win_close(win, true)
			vim.api.nvim_buf_delete(M._buf, { force = true })
			M._buf = nil
			return
		end
	end

	-- Otherwise create new buffer
	M._buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * M.config.float_opts.width)
	local height = math.floor(vim.o.lines * M.config.float_opts.height)
	local row = math.floor((vim.o.lines - height) / 2 - 1)
	local col = math.floor((vim.o.columns - width) / 2)

	local win_opts = {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = M.config.float_opts.border,
	}

	vim.api.nvim_open_win(M._buf, true, win_opts)
	vim.fn.termopen(M.config.cmd)
	vim.cmd("startinsert")
end

-- Optional: helper to set keymaps
M.map = function(lhs, rhs, opts)
	opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
	vim.api.nvim_set_keymap("n", lhs, rhs, opts)
end

return M
