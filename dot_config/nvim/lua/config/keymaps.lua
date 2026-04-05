local map = vim.keymap.set

local function copy_file_ref(line_start, line_end)
  local file_path = vim.fn.expand("%:p")
  if file_path == "" then
    return
  end

  local reference = "@" .. file_path
  if line_start and line_end then
    reference = reference .. ":" .. line_start .. "-" .. line_end
  end

  vim.fn.setreg("+", reference)
  vim.notify("Copied: " .. reference, vim.log.levels.INFO)
end

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Diagnostics
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>ff", function()
  require("mini.pick").builtin.files()
end, { desc = "Find files" })
map("n", "<leader>fg", function()
  require("mini.pick").builtin.grep_live()
end, { desc = "Live grep" })
map("n", "<leader>fb", function()
  require("mini.pick").builtin.buffers()
end, { desc = "Find buffers" })
map("n", "<leader>fh", function()
  require("mini.pick").builtin.help()
end, { desc = "Help tags" })

-- Helpers for linking file references in AI tools
map("n", "<leader>ac", function()
  copy_file_ref()
end, { desc = "Copy file reference for AI tool usage" })
map("v", "<leader>ac", function()
  local line_start = vim.fn.line("v")
  local line_end = vim.fn.line(".")
  if line_start > line_end then
    line_start, line_end = line_end, line_start
  end
  copy_file_ref(line_start, line_end)
end, { desc = "Copy selection reference for AI tool usage" })
