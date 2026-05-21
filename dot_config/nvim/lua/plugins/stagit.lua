return {
  {
    "jondysinger/stagit.nvim",
    cmd = { "StagitToggle", "StagitRefresh", "StagitCommit" },
    keys = {
      { "<leader>g", "<cmd>StagitToggle<CR>", desc = "Stagit" },
    },
    opts = {
      mappings = {
        panel_toggle = nil,
      },
    },
  },
}
