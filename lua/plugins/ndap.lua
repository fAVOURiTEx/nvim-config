return {
	{ "williamboman/mason.nvim", config = true },

	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "mason.nvim" },
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb" },
				automatic_installation = true,
				handlers = {}, -- важно: не даём mason ломать адаптеры
			})
		end,
	},

	{
		"mfussenegger/nvim-dap",
		dependencies = { "mason-nvim-dap.nvim", "mason.nvim" },

		config = function()
			local dap = require("dap")

			-- Регистрируем адаптер только при первом запуске
			dap.adapters.codelldb = function(callback, config)
				local mason_registry = require("mason-registry")
				local pkg = mason_registry.get_package("codelldb")

				if not pkg then
					vim.notify(
						"❌ codelldb не установлен. Установи через :Mason",
						vim.log.levels.ERROR
					)
					return
				end

				local path = pkg.install_path
				if not path then
					vim.notify(
						"⏳ codelldb ещё не готов, перезапусти nvim после установки",
						vim.log.levels.WARN
					)
					return
				end

				callback({
					type = "server",
					host = "127.0.0.1",
					port = config.port,
					executable = {
						command = path .. "/extension/adapter/codelldb",
						args = { "--port", config.port },
					},
				})
			end

			dap.configurations.cpp = {
				{
					name = "Launch C++ (CodeLLDB)",
					type = "codelldb",
					request = "launch",
					program = function()
						local bin = vim.fn.glob(vim.fn.getcwd() .. "/build/*", false, true)[1]
						return bin or vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
			vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dapui = require("dapui")
			local dap = require("dap")

			dapui.setup({
				layouts = {
					{ elements = { "scopes", "breakpoints", "stacks", "watches" }, size = 40, position = "left" },
					{ elements = { "repl", "console" }, size = 0.25, position = "bottom" },
				},
				floating = { border = "rounded" },
			})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
