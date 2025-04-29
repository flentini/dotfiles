local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

-- Shared capabilities for all LSP servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Function to run when LSP attaches to a buffer
local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  
  -- LSP Keybindings
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)       -- Go to definition
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)       -- Show references
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)   -- Go to implementation
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)             -- Hover info
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)     -- Previous diagnostic
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)     -- Next diagnostic

  require("lsp_signature").on_attach({
    bind = true,
    floating_window = true,
    hint_enable = false,
  }, bufnr)
end

-- Deno LSP
lspconfig.denols.setup {
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

-- TypeScript & JavaScript LSP
lspconfig.ts_ls.setup {
  on_attach = on_attach,   -- Attach keybindings
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("package.json"),
  single_file_support = false
}

-- Python LSP
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        extraPaths = {
          "${workspaceFolder}", -- Add current project
        }
      }
    }
  },
})

-- nvim-cmp setup for autocompletion
local cmp = require("cmp")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 1000 }, -- LSP suggestions
    { name = 'buffer', priority = 500 }, -- Buffer words
    { name = 'path', priority = 250 } -- File paths
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier, -- Prettier for JavaScript/TypeScript
    null_ls.builtins.formatting.black.with({ -- Black for Python formatting
      extra_args = { "--fast" },
    }),
    null_ls.builtins.diagnostics.ruff, -- Ruff for Python linting
    null_ls.builtins.code_actions.gitsigns,
  },
})

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.py", "*.json" },
  callback = function()
    vim.lsp.buf.format({
      timeout_ms = 2000,
      filter = function(client)
        return client.name == "null-ls"
      end
    })
  end,
})
