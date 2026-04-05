return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "mypy" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        dockerfile = { "hadolint" },
      }

      lint.linters.mypy.cmd = function()
        local buf_dir = vim.fn.expand("%:p:h")
        local venv = vim.fs.find(".venv", { path = buf_dir, upward = true, type = "directory" })[1]
        if venv then
          return venv .. "/bin/mypy"
        end
        return "mypy"
      end

      local function python_cwd()
        local buf_dir = vim.fn.expand("%:p:h")
        local venv = vim.fs.find(".venv", { path = buf_dir, upward = true, type = "directory" })[1]
        if venv then
          return vim.fn.fnamemodify(venv, ":h")
        end
      end

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          local cwd = python_cwd()
          lint.try_lint(nil, { cwd = cwd })
        end,
      })
    end,
  },
}
