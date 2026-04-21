return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fc",
      function()
        require("conform").format({ async = true })
      end,
      desc = "Format buffer",
    },
  },
  opts = {
    formatters = {
      csharpier = {
        command = function()
          local exepath = vim.fn.exepath("csharpier")
          return exepath ~= "" and exepath or "csharpier"
        end,
        args = { "format", "--stdin-path", "$FILENAME" },
        stdin = true,
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "jq" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      cs = { "csharpier" },
      nix = { "nixfmt" },
      rust = { "rustfmt" },
    },
    format_on_save = {
      timeout_ms = 5000,
    },
  },
}
