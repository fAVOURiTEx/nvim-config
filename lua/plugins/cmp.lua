return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- LSP completion
		"hrsh7th/cmp-buffer", -- слова из буфера
		"hrsh7th/cmp-path", -- пути файлов
	},
	config = function()
		local cmp = require("cmp")
		-- local lspkind = require("lspkind")

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
			}),

			sources = {
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
			},

			experimental = {
				ghost_text = true,
			},

			window = {
				completion = cmp.config.window.bordered(), -- окно с вариантами
				documentation = cmp.config.window.bordered({ -- окно документации
					border = "rounded",
					winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder",
					maxheight = 20, -- максимум строк
					maxwidth = 80, -- максимум столбцов
				}),
			},
		})
	end,
}
