return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"leoluz/nvim-dap-go",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		require("dap-go").setup()
		require("dapui").setup()
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<leader>dc", dap.continue, {})
		vim.keymap.set("n", "<leader>do", dap.step_over, {})
		vim.keymap.set("n", "<leader>di", dap.step_into, {})
		vim.keymap.set("n", "<leader>du", dap.step_out, {})
		vim.keymap.set("n", "<leader>de", dap.terminate, {})
		-- vim.keymap.set("n", "<leader>dx", dapui.toggle, {})
		-- vim.keymap.set("n", "<leader>dr", function()
		-- 	require("dap").terminate()
		-- 	vim.defer_fn(function()
		-- 		require("dap").run()
		-- 	end, 500)
		-- end, {})
	end,
}
