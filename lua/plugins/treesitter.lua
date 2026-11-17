-- nvim-treesitter `main` branch: setup() no longer takes ensure_installed/highlight.
-- Parsers are installed with install(), and highlighting is started per buffer.
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local parsers = { "lua", "c", "python", "nasm", "asm", "markdown", "markdown_inline" }
    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        -- start treesitter only if a parser exists for this filetype
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
