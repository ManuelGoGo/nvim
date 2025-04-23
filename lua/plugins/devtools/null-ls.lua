return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- FORMATTERS
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				--null_ls.builtins.formatting.black,
				--null_ls.builtins.formatting.shfmt,

				-- LINTERS
				null_ls.builtins.diagnostics.eslint,
				--null_ls.builtins.diagnostics.flake8,
				--null_ls.builtins.diagnostics.shellcheck,
			},
			-- Puedes conectar on_attach si quieres que use el mismo keymap que tus LSP
			on_attach = function(client, bufnr)
				vim.keymap.set("n", "<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, { buffer = bufnr, desc = "Formatear con Null-ls" })
			end,
		})
	end,
}
