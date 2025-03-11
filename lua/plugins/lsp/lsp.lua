return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim", -- Gestor de servidores LSP
    "williamboman/mason-lspconfig.nvim", -- Integración entre Mason y LSPConfig
    "folke/neodev.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",        -- Lua
        "pyright",       -- Python
        "clangd",        -- c y c++
        "bashls",        -- Bash
      },
    })

    -- Función de configuración para cada LSP
    local on_attach = function(_, bufnr)
      local opts = { buffer = bufnr }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
    end

    -- Configurar cada servidor LSP
    local servers = {
      lua_ls = { settings = { Lua = { telemetry = { enable = false } } } },
      pyright = {}, -- Python
      clangd = { -- Configuración para C y C++
        cmd = { "clangd", "--background-index", "--clang-tidy" },},
      bashls = { -- Bash
        filetypes = { "sh", "bash", "zsh" },},
    }

    for server, config in pairs(servers) do
      config.on_attach = on_attach
      lspconfig[server].setup(config)
    end
  end,
}

