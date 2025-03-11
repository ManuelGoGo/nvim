local ls = require "luasnip"
local types = require "luasnip.util.types"

local M = {}

function M.setup()
  ls.config.set_config {
    -- Permite recordar y volver a snippets anteriores incluso si el cursor se mueve fuera.
    history = true,

    -- Actualiza los snippets dinámicos en tiempo real mientras se escribe.
    updateevents = "TextChangedI",

    -- Habilita los autosnippets
    enable_autosnippets = true,

    -- Opciones visuales para los nodos de elección
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "↺ Opción", "MoreMsg" } },
        },
      },
    },
  }

  -- Mapeos de teclas optimizados
  vim.keymap.set({ "i", "s" }, "<C-k>", function()
    return ls.expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<C-k>"
  end, { silent = true, expr = true })

  vim.keymap.set({ "i", "s" }, "<C-j>", function()
    return ls.jumpable(-1) and "<Plug>luasnip-jump-prev" or "<C-j>"
  end, { silent = true, expr = true })

  vim.keymap.set("i", "<C-l>", function()
    return ls.choice_active() and "<Plug>luasnip-next-choice" or "<C-l>"
  end, { silent = true, expr = true })
end

return M

