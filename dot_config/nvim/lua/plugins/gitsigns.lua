return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
      linehl = true,
      word_diff = true,
    },
    keys = {
      {
        "]h",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "]h", bang = true })
          else
            require("gitsigns").nav_hunk("next")
          end
        end,
        desc = "Next git hunk",
      },
      {
        "[h",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "[h", bang = true })
          else
            require("gitsigns").nav_hunk("prev")
          end
        end,
        desc = "Previous git hunk",
      },
      {
        "<leader>gg",
        function()
          require("gitsigns").preview_hunk_inline()
        end,
        desc = "Preview git hunk inline",
      },
      {
        "<leader>gb",
        function()
          require("gitsigns").blame_line({ full = true })
        end,
        desc = "Git blame line",
      },
      {
        "<leader>gs",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage git hunk",
      },
      {
        "<leader>gs",
        function()
          require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        mode = "v",
        desc = "Stage selected git hunk lines",
      },
      {
        "<leader>gr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset git hunk",
      },
      {
        "<leader>gr",
        function()
          require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        mode = "v",
        desc = "Reset selected git hunk lines",
      },
      {
        "<leader>gu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "Undo staged hunk",
      },
      {
        "<leader>gd",
        function()
          require("gitsigns").diffthis()
        end,
        desc = "Diff this buffer",
      },
      {
        "<leader>gB",
        function()
          require("gitsigns").toggle_current_line_blame()
        end,
        desc = "Toggle line blame",
      },
    },
  },
}
