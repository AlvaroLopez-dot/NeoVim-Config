-- Treat .asm / .nasm files as NASM (Intel syntax). .s / .S stay as GAS ("asm").
vim.filetype.add({
  extension = {
    asm = "nasm",
    nasm = "nasm",
  },
})

return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- mason-lspconfig v2 removed `handlers`; servers are configured with
      -- vim.lsp.config() and enabled automatically once installed.
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })

      -- asm-lsp only attaches to "asm"/"vmasm" by default; add "nasm".
      vim.lsp.config("asm_lsp", {
        filetypes = { "asm", "vmasm", "nasm" },
        root_markers = { ".asm-lsp.toml", ".git" },
      })

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "clangd", "asm_lsp" },
      })

      -- Keymaps for LSP actions
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
      vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous Diagnostic" })
      vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next Diagnostic" })
    end,
  },
}
