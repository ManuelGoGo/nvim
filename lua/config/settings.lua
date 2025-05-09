vim.g.mapleader = " "
vim.g.snippets = "luasnip"
local opt = vim.o

--opt.mouse = ""
opt.number = true
opt.relativenumber = true
opt.conceallevel = 3
opt.hidden = true
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.errorbells = false
opt.wrap = false
opt.swapfile = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.splitbelow = true
opt.splitright = true
opt.autowrite = true
opt.list = true
opt.listchars = "tab:\\ ,trail:-"
opt.laststatus = 3
opt.cmdheight = 1
opt.updatetime = 50
opt.signcolumn = "yes"
opt.equalalways = false
opt.splitkeep = "screen"
opt.shortmess = "filnxtToOFWIcC"

---plungins general options---
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

vim.opt.signcolumn = "yes"

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
vim.diagnostic.config({
	virtual_text = true, -- muestra texto inline en la línea del error
	signs = true, -- muestra iconos en la signcolumn (a la izquierda)
	underline = true, -- subraya errores
	update_in_insert = false, -- no actualiza mientras escribes
	severity_sort = true, -- ordena los signos por severidad
})

---codeium options---
