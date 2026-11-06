return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
		})

		vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", {
			noremap = true,
			silent = true,
			desc = "Toggle terminal",
		})

		local Terminal = require("toggleterm.terminal").Terminal

		local function make_term(cmd, opts)
			opts = opts or {}
			return Terminal:new({
				cmd = cmd,
				hidden = true,
				direction = opts.direction or "float",
				size = opts.size,
				float_opts = (opts.direction or "float") == "float" and { border = "rounded" } or nil,
				on_open = function(term)
					vim.cmd("startinsert!")
					if opts.bind_escape_hatches then
						-- Only for Cursor Agent. Esc stays with the agent TUI.
						--   Ctrl-Space → terminal-normal (does NOT close / leave the tab)
						--   Ctrl-q     → hide agent tab (job stays via hidden=true)
						-- Also map <C-@>: many terminals send NUL for Ctrl-Space.
						local map = { buffer = term.bufnr, silent = true, desc = "Agent: terminal normal" }
						local to_normal = [[<C-\><C-n>]]
						vim.keymap.set("t", "<C-Space>", to_normal, map)
						vim.keymap.set("t", "<C-@>", to_normal, map)
						vim.keymap.set("t", "<C-q>", function()
							term:close()
						end, { buffer = term.bufnr, silent = true, desc = "Agent: hide tab" })
					end
				end,
			})
		end

		local lazygit = make_term("lazygit", { direction = "tab" })
		local herdr = make_term("herdr", { direction = "tab" })
		-- Plain shell tab: run `agent`, `agent ls`, `agent resume`, etc. yourself
		local agent_shell = make_term(nil, {
			direction = "tab",
			bind_escape_hatches = true,
		})

		vim.keymap.set("n", "<leader>gg", function()
			lazygit:toggle()
		end, { desc = "Lazygit" })

		vim.keymap.set("n", "<leader>ah", function()
			if vim.fn.executable("herdr") == 0 then
				vim.notify(
					"herdr not found — install: curl -fsSL https://herdr.dev/install.sh | sh",
					vim.log.levels.WARN,
					{ title = "Herdr" }
				)
				return
			end
			herdr:toggle()
		end, { desc = "Herdr" })

		vim.keymap.set("n", "<leader>aa", function()
			-- open / focus / back to code — tab stays; Ctrl-q hides
			if agent_shell:is_open() then
				if vim.api.nvim_get_current_buf() == agent_shell.bufnr then
					local origin = require("toggleterm.ui").get_origin_window()
					if origin and vim.api.nvim_win_is_valid(origin) then
						vim.api.nvim_set_current_win(origin)
					elseif vim.fn.tabpagenr("$") > 1 then
						vim.cmd("tabprevious")
					else
						agent_shell:close()
					end
				else
					agent_shell:focus()
				end
			else
				agent_shell:open()
			end
		end, { desc = "Agent shell" })
	end,
}
