return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.config")
    configs.setup({
      ensure_installed = { "lua", "c", "python" },
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
