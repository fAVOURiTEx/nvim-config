return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	}, -- installs LSP servers
	{ "neovim/nvim-lspconfig" }, -- configures LSPs
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
				},
				automatic_enable = true, -- ВАЖНО
			})
		end,
	},
}
