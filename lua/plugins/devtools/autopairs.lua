-- Auto-completion of brackets, parentheses, and quotes
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = {
		-- Integración con nvim-cmp para insertar paréntesis automáticamente después de confirmar funciones
		"hrsh7th/nvim-cmp",
	},
	opts = {
		check_ts = true, -- habilita Treesitter para decisiones contextuales
		ts_config = {
			lua = { "string" }, -- evita emparejar en strings de Lua
			javascript = { "template_string" }, -- evita emparejar en template strings de JS
		},
		disable_filetype = { "TelescopePrompt", "vim" }, -- desactiva en estos tipos de archivo
		fast_wrap = {
			map = "<M-e>", -- wrap rápido usando Alt + e
			chars = { "{", "[", "(", '"', "'" },
			pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
			offset = 0,
			end_key = "$",
			keys = "qwertyuiopzxcvbnmasdfghjkl",
			check_comma = true,
			highlight = "Search",
			highlight_grey = "Comment",
		},
	},
	config = function(_, opts)
		local npairs = require("nvim-autopairs")
		npairs.setup(opts)

		-- Integración con nvim-cmp
		local cmp_ok, cmp = pcall(require, "cmp")
		if cmp_ok then
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end
	end,
}
