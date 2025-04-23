---@diagnostic disable: missing-fields
local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

require("luasnip.loaders.from_vscode").lazy_load()

local M = {}

formatting = {}
function M.setup()
	cmp.setup({
		window = {
			completion = { border = "rounded" },
			documentation = { border = "rounded" },
		},
		formatting = {
			format = function(entry, vim_item)
				local KIND_ICONS = {
					Color = " ",
					Snippet = " ",
					Codeium = "",
				}
				local SOURCE_NAMES = {
					nvim_lsp = "[LSP]",
					luasnip = "[Snip]",
					buffer = "[Buf]",
					path = "[Path]",
					codeium = "[AI]",
				}
				vim_item.kind = KIND_ICONS[vim_item.kind] or vim_item.kind
				vim_item.menu = SOURCE_NAMES[entry.source.name] or entry.source.name
				return vim_item
			end,
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = {
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-e>"] = cmp.mapping.abort(),
			["<C-n>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.choice_active() then
					luasnip.change_choice(1)
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
			["<c-space>"] = cmp.mapping.complete(),
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" }, -- LSP (incluye clangd)
			{ name = "luasnip" }, -- Snippets
			{ name = "path" }, -- Rutas de archivos
			{ name = "buffer" }, -- Texto en el buffer
			{ name = "codeium" }, --Ia para codigo
		}),
	})

	-- Integración con nvim-autopairs
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

	-- Configuración específica para gitcommit
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "git" },
		}, {
			{ name = "buffer" },
		}),
	})

	-- Autocompletado en la línea de comandos
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

return M
