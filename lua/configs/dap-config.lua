local dap = require("dap")
local dapui = require("dapui")
local mason_registry = require("mason-registry")

-- Path к codelldb
local pkg = mason_registry.get_package("codelldb")
local path = pkg:get_install_path()

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = path .. "/extension/adapter/codelldb",
		args = { "--port", "${port}" },
	},
}

dap.configurations.cpp = {
	{
		name = "Launch C++",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

-- Кеймапы
vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>du", function()
	dapui.toggle()
end, { desc = "DAP UI Toggle" })

-- Авто-открытие и закрытие dap-ui
dap.listeners.after.event_initialized["dapui_autostart"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_autostart"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_autostart"] = function()
	dapui.close()
end
