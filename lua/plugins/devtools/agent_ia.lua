return {
	"Exafunction/windsurf.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("codeium").setup({
			-- Configuración mínima
			enable_cmp_source = true,
			virtual_text = {
				enabled = true,
			},
		})
	end,
}
