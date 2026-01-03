return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			-- Кастомная тема для прозрачного lualine
			local transparent_theme = {
				normal = {
					a = { fg = "#1a1b26", bg = "#7aa2f7", gui = "bold" },
					b = { fg = "#c0caf5", bg = "none" },
					c = { fg = "#787c99", bg = "none" },
				},
				insert = {
					a = { fg = "#1a1b26", bg = "#9ece6a", gui = "bold" },
					b = { fg = "#c0caf5", bg = "none" },
					c = { fg = "#787c99", bg = "none" },
				},
				visual = {
					a = { fg = "#1a1b26", bg = "#bb9af7", gui = "bold" },
					b = { fg = "#c0caf5", bg = "none" },
					c = { fg = "#787c99", bg = "none" },
				},
				replace = {
					a = { fg = "#1a1b26", bg = "#f7768e", gui = "bold" },
					b = { fg = "#c0caf5", bg = "none" },
					c = { fg = "#787c99", bg = "none" },
				},
				command = {
					a = { fg = "#1a1b26", bg = "#e0af68", gui = "bold" },
					b = { fg = "#c0caf5", bg = "none" },
					c = { fg = "#787c99", bg = "none" },
				},
				inactive = {
					a = { fg = "#545c7e", bg = "none", gui = "bold" },
					b = { fg = "#545c7e", bg = "none" },
					c = { fg = "#545c7e", bg = "none" },
				},
			}

			return {
				options = {
					-- Используем кастомную тему для прозрачности
					theme = transparent_theme,

					-- Или можно использовать встроенную тему с модификациями
					-- theme = "tokyonight",

					-- Минималистичные разделители для прозрачности
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },

					disabled_filetypes = {
						statusline = {
							"NvimTree",
							"alpha",
							"dashboard",
							"starter",
							"Outline",
							"Trouble",
							"toggleterm",
							"qf",
							"help",
						},
					},

					-- Единая строка статуса (лучше с прозрачностью)
					globalstatus = true,

					-- Не обновлять слишком часто для производительности
					refresh = {
						statusline = 200,
						tabline = 200,
						winbar = 200,
					},
				},

				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								local mode_map = {
									["n"] = "NORMAL",
									["i"] = "INSERT",
									["v"] = "VISUAL",
									["V"] = "V-LINE",
									[""] = "V-BLOCK",
									["s"] = "SELECT",
									["S"] = "S-LINE",
									[""] = "S-BLOCK",
									["R"] = "REPLACE",
									["c"] = "COMMAND",
									["t"] = "TERMINAL",
									["!"] = "SHELL",
								}
								return mode_map[str] or str:upper()
							end,
							separator = { left = "", right = "" },
						},
					},
					lualine_b = {
						{
							"branch",
							icon = "",
							color = { fg = "#ff9e64" },
						},
						{
							"diff",
							symbols = {
								added = " ",
								modified = " ",
								removed = " ",
							},
							diff_color = {
								added = { fg = "#9ece6a" },
								modified = { fg = "#e0af68" },
								removed = { fg = "#f7768e" },
							},
						},
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = {
								error = " ",
								warn = " ",
								info = " ",
								hint = "󰌵 ",
							},
							diagnostics_color = {
								error = { fg = "#f7768e" },
								warn = { fg = "#e0af68" },
								info = { fg = "#0db9d7" },
								hint = { fg = "#4fd6be" },
							},
						},
					},
					lualine_c = {
						{
							"filename",
							path = 1,
							symbols = {
								modified = " 󰏫",
								readonly = " 󰏫",
								unnamed = "[No Name]",
								newfile = "[New]",
							},
							color = { fg = "#c0caf5", gui = "bold" },
						},
						{
							function()
								local navic = require("nvim-navic")
								if navic.is_available() then
									return navic.get_location()
								end
								return ""
							end,
							cond = function()
								return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
							end,
							color = { fg = "#737aa2" },
						},
					},
					lualine_x = {
						{
							function()
								local msg = "No Active LSP"
								local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
								local clients = vim.lsp.get_clients()

								if next(clients) == nil then
									return msg
								end

								-- Иконки для LSP
								local lsp_icons = {
									lua_ls = "",
									clangd = "",
									html = "",
									cssls = "",
									jsonls = "",
									bashls = "",
								}

								for _, client in ipairs(clients) do
									local filetypes = client.config.filetypes
									if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
										local icon = lsp_icons[client.name] or ""
										return icon .. " " .. client.name
									end
								end

								return msg
							end,
							icon = "LSP:",
							color = { fg = "#ffffff", gui = "bold" },
						},

						{
							"encoding",
							fmt = function(str)
								return str:upper()
							end,
							color = { fg = "#737aa2" },
						},
						{
							"fileformat",
							symbols = {
								unix = "󰉊",
								dos = "",
								mac = "",
							},
							color = { fg = "#737aa2" },
						},
						{
							"filetype",
							icon_only = true,
							padding = { left = 1, right = 0 },
						},
						{
							"filetype",
							icon = { align = "right" },
							padding = { left = 0, right = 1 },
						},
					},
					lualine_y = {
						{
							"progress",
							color = { fg = "#c0caf5" },
						},
					},
					lualine_z = {
						{
							"location",
							color = { fg = "#1a1b26", bg = "#7aa2f7", gui = "bold" },
							separator = { left = "", right = "" },
						},
					},
				},

				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},

				extensions = {
					"nvim-tree",
					"toggleterm",
					"fzf",
					"quickfix",
					"lazy",
					"mason",
				},
			}
		end,

		config = function(_, opts)
			require("lualine").setup(opts)

			-- Автообновление при смене цветовой схемы
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					require("lualine").setup(opts)
				end,
			})

			-- Делаем lualine прозрачным
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					vim.api.nvim_set_hl(0, "lualine_a_normal", { bg = "none" })
					vim.api.nvim_set_hl(0, "lualine_b_normal", { bg = "none" })
					vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "none" })
				end,
			})
		end,
	},
}
