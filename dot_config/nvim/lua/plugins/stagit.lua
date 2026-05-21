return {
  {
    "jondysinger/stagit.nvim",
    cmd = { "StagitToggle", "StagitRefresh", "StagitCommit" },
    keys = {
      { "<leader>gg", "<cmd>StagitToggle<CR>", desc = "Stagit" },
    },
    opts = {
      mappings = {
        panel_toggle = nil,
      },
    },
  },
}
