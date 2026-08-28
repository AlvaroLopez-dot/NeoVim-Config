return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local status, treesitter_configs = pcall(require, "nvim-treesitter.configs")
      if not status then
        return
      end

      treesitter_configs.setup({
        ensure_installed = { "lua", "vim", "vimdoc" },
        highlight = { enable = true },
      })
    end,
  },
}
