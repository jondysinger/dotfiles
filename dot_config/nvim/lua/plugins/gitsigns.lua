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
        "]c",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            require("gitsigns").nav_hunk("next")
          end
        end,
        desc = "Next git hunk",
      },
      {
        "[c",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            require("gitsigns").nav_hunk("prev")
          end
        end,
        desc = "Previous git hunk",
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
        "<leader>gr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset git hunk",
      },
      {
        "<leader>gu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "Undo stage hunk",
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
