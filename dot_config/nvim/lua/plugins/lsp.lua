return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- Diagnostic display settings
    vim.diagnostic.config({
      float = {
        source = true,
        header = "",
        prefix = "",
      },
      virtual_text = {
        prefix = "●",
      },
      severity_sort = true,
      signs = true,
      underline = true,
    })

    -- LSP keymaps (set when LSP attaches)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end,
    })

    -- Lua
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- Nix
    vim.lsp.config("nil_ls", {
      capabilities = capabilities,
      settings = {
        ["nil"] = {
          formatting = {
            command = { "nixfmt" },
          },
        },
      },
    })

    -- Rust
    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
        },
      },
    })

    -- C#
    vim.lsp.config("csharp_ls", {
      capabilities = capabilities,
    })

    -- JavaScript / TypeScript
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
    })

    vim.lsp.config("eslint", {
      capabilities = capabilities,
      settings = {
        workingDirectory = { mode = "auto" },
      },
    })

    -- Python
    vim.lsp.config("pyright", {
      capabilities = capabilities,
    })

    -- Enable all configured servers
    vim.lsp.enable({
      "lua_ls",
      "nil_ls",
      "rust_analyzer",
      "csharp_ls",
      "ts_ls",
      "eslint",
      "pyright",
    })
  end,
}
