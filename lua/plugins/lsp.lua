return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp", -- Allows LSP to send autocompletion capabilities
    },
    config = function()
      -- Get default completion capabilities from cmp_nvim_lsp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup({
        -- Automatically install these language servers
        ensure_installed = { 
          "lua_ls", 
          "pyright", 
          "clangd" 
        },
        handlers = {
          -- Default handler runs for every installed server
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- Example: Custom server override (optional)
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" }, -- Recognizes global 'vim' in Neovim configs
                  },
                },
              },
            })
          end,
        },
      })

      -- Keymaps for LSP actions
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      -- Press 'gl' in normal mode to open line diagnostics
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
    end,
  },
}
