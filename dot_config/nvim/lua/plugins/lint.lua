return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      local hadolint = vim.deepcopy(lint.linters.hadolint)

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

      local function project_root()
        local buf_dir = vim.fn.expand("%:p:h")
        local root_marker = vim.fs.find({ ".hadolint.yaml", ".hadolint.yml", ".git" }, {
          path = buf_dir,
          upward = true,
        })[1]

        if root_marker then
          return vim.fs.dirname(root_marker)
        end

        return buf_dir
      end

      local function hadolint_config()
        local buf_dir = vim.fn.expand("%:p:h")
        return vim.fs.find({ ".hadolint.yaml", ".hadolint.yml" }, {
          path = buf_dir,
          upward = true,
        })[1]
      end

      lint.linters.hadolint = function()
        local linter = vim.deepcopy(hadolint)
        local config = hadolint_config()

        if config then
          linter.args = { "-f", "json", "--config", config, "-" }
        end

        return linter
      end

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          local cwd = python_cwd() or project_root()
          lint.try_lint(nil, { cwd = cwd })
        end,
      })
    end,
  },
}
