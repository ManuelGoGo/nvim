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
        "sqls",          --Sqls
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
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "strict", -- Cambiar a "basic" si quieres menos estricta
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },}, -- Python
      clangd = { -- Configuración para C y C++
        cmd = { "clangd", "--background-index", "--clang-tidy" },},
      bashls = { -- Bash
        filetypes = { "sh", "bash", "zsh" },},
      sqls = {  -- Configuración específica para SQL
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
          buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
        end,
        settings = {
          sqls = {
            connections = {
              {
                driver = "postgresql",     -- O "postgresql" si usas PostgreSQL
                dataSourceName = "root:password@tcp(127.0.0.1:3306)/database_name",
              },
            },
          },
        },
      },
    }

    for server, config in pairs(servers) do
      config.on_attach = on_attach
      lspconfig[server].setup(config)
    end
  end,
}

