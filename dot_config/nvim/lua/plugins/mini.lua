return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    event = { "BufReadPre", "BufNewFile", "VimEnter" },
    config = function()
      local clue = require("mini.clue")
      local statusline = require("mini.statusline")

      clue.setup({
        triggers = {
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },
          { mode = "i", keys = "<C-x>" },
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },
          { mode = "n", keys = "<C-w>" },
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },
        clues = {
          { mode = "n", keys = "<Leader>a", desc = "+ai/diff" },
          { mode = "n", keys = "<Leader>c", desc = "+claude/code" },
          { mode = "n", keys = "<Leader>f", desc = "+find/format" },
          { mode = "n", keys = "<Leader>g", desc = "+git" },
          { mode = "n", keys = "<Leader>r", desc = "+refactor" },
          clue.gen_clues.builtin_completion(),
          clue.gen_clues.g(),
          clue.gen_clues.marks(),
          clue.gen_clues.registers(),
          clue.gen_clues.windows(),
          clue.gen_clues.z(),
        },
        window = {
          delay = 300,
        },
      })
      require("mini.comment").setup()
      require("mini.completion").setup()
      require("mini.diff").setup()
      require("mini.git").setup()
      require("mini.hipatterns").setup({
        highlighters = {
          hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
          fixme = {
            pattern = { "%f[%w]FIX%f[%W]", "%f[%w]FIXME%f[%W]", "%f[%w]BUG%f[%W]" },
            group = "MiniHipatternsFixme",
          },
          hack = {
            pattern = { "%f[%w]HACK%f[%W]", "%f[%w]WARN%f[%W]", "%f[%w]WARNING%f[%W]" },
            group = "MiniHipatternsHack",
          },
          todo = {
            pattern = { "%f[%w]TODO%f[%W]", "%f[%w]FEAT%f[%W]" },
            group = "MiniHipatternsTodo",
          },
          note = {
            pattern = { "%f[%w]NOTE%f[%W]", "%f[%w]INFO%f[%W]" },
            group = "MiniHipatternsNote",
          },
        },
      })
      require("mini.indentscope").setup({
        draw = {
          animation = require("mini.indentscope").gen_animation.none(),
        },
      })
      require("mini.extra").setup()
      require("mini.pick").setup()
      local starter = require("mini.starter")
      starter.setup({
        items = {
          starter.sections.recent_files(10, true, true),
          starter.sections.builtin_actions(),
        },
      })
      require("mini.snippets").setup()
      require("mini.trailspace").setup()
      vim.api.nvim_set_hl(0, "MiniStatuslineDiagnostics", { fg = "#eb7f92" })
      statusline.setup({
        use_icons = true,
        content = {
          active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local git = statusline.section_git({ trunc_width = 40 })
            local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
            local filename = statusline.section_filename({ trunc_width = 140 })
            local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
            local location = statusline.section_location({ trunc_width = 75 })
            local search = statusline.section_searchcount({ trunc_width = 75 })

            return statusline.combine_groups({
              { hl = mode_hl, strings = { mode } },
              { hl = "MiniStatuslineDevinfo", strings = { git } },
              { hl = "MiniStatuslineDiagnostics", strings = { diagnostics } },
              "%<",
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=",
              { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              { hl = mode_hl, strings = { search, location } },
            })
          end,
        },
      })
    end,
  },
}
