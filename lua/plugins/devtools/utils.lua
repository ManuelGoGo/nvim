return {
  -- Autocierre de paréntesis
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  -- Permite abrir URLs con la tecla gx
  {
    "josa42/nvim-gx",
    keys = { { "gx", "<cmd>lua require('gx').gx()" } },
  },

  -- Trabajar con paréntesis, comillas y otros delimitadores
 --{
   -- "tpope/vim-surround",
    --event = { "VeryLazy" },
  --},
}
