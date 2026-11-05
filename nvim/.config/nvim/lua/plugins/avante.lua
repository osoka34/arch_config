-- Cursor CLI via ACP (https://cursor.com/docs/cli/acp)
return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,
	build = "make",
	opts = {
		provider = "cursor",
		mode = "agentic",
		acp_providers = {
			cursor = {
				command = vim.fn.expand("~/.local/bin/agent"),
				args = { "acp" },
				auth_method = "cursor_login",
				env = {
					HOME = vim.env.HOME,
					PATH = vim.env.PATH,
				},
			},
		},
		behaviour = {
			auto_suggestions = false,
			-- Never silent-apply code; show conflict/diff and wait
			auto_apply_diff_after_generation = false,
			auto_focus_on_diff_view = true,
			-- Cursor-like: ask before write/shell/edit (Allow once / Always / Reject)
			auto_approve_tool_permissions = false,
			confirmation_ui_style = "inline_buttons",
			-- Follow agent to the file/line being changed
			acp_follow_agent_locations = true,
		},
		-- After you accept a diff, focus the "ours"/incoming side clearly
		windows = {
			ask = {
				focus_on_apply = "ours",
			},
		},
	},

	config = function(_, opts)
		require("avante").setup(opts)

		-- Tool/diff blocks: always show full content (not truncated)
		local Sidebar = require("avante.sidebar")
		local orig = Sidebar._get_message_lines
		function Sidebar:_get_message_lines(ctx, message, messages, ignore_record_prefix)
			if message.uuid then
				self.expanded_message_uuids[message.uuid] = true
			end
			return orig(self, ctx, message, messages, ignore_record_prefix)
		end

		-- Thought headers use treesitter folds (ftplugin/Avante.lua).
		-- Default foldlevel=0 hides streaming text; keep open, fold manually with za/zc.
		vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
			pattern = { "Avante", "markdown", "markdown.Avante" },
			callback = function(ev)
				if not tostring(vim.bo[ev.buf].filetype):find("Avante", 1, true) then
					return
				end
				vim.wo.foldlevel = 99
				pcall(vim.cmd, "normal! zR")
			end,
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		-- required since avante v0.4 for :Avante commands
		{ "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
		"nvim-tree/nvim-web-devicons",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				-- Avante result buffer uses compound filetype "markdown.Avante"
				file_types = { "markdown", "Avante", "markdown.Avante" },
			},
			ft = { "markdown", "Avante", "markdown.Avante" },
		},

	},
}
