vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<cr>")

-- neotree
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "NeoTree toggle" })
vim.keymap.set("n", "<leader>f", "<cmd>Neotree focus<cr>", { desc = "NeoTree focus" })

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- dap
-- local dap = require("dap")
-- local dapui = require("dapui")

--vim.keymap.set("n", "<F5>", dap.continue)
--vim.keymap.set("n", "<F10>", dap.step_over)
--vim.keymap.set("n", "<F11>", dap.step_into)
--vim.keymap.set("n", "<F12>", dap.step_out)

--vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
--vim.keymap.set("n", "<leader>dc", dap.continue)
--vim.keymap.set("n", "<leader>do", dap.step_over)
--vim.keymap.set("n", "<leader>di", dap.step_into)
--vim.keymap.set("n", "<leader>dr", dap.repl.open)
--vim.keymap.set("n", "<leader>du", dapui.toggle)

-- LSP keymaps (native, 0.11+)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	end,
})
