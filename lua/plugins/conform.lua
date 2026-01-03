return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				cpp = { "clang-format" },
				c = { "clang-format" },
				lua = { "stylua" },
			},
			format_on_save = true, -- автоматически форматировать при сохранении
		})
	end,
}
