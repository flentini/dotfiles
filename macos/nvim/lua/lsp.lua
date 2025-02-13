local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

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
    hint_enable = true,
  }, bufnr)
end

-- TypeScript & JavaScript LSP
lspconfig.ts_ls.setup {
  on_attach = on_attach,   -- Attach keybindings
  capabilities = require("cmp_nvim_lsp").default_capabilities()
}

-- nvim-cmp setup for autocompletion
local cmp = require("cmp")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- LSP suggestions
    { name = 'buffer' }, -- Buffer words
    { name = 'path' } -- File paths
  })
})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier, -- Use Prettier for formatting
  },
})

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    vim.lsp.buf.format({
      timeout_ms = 2000,
      filter = function(client)
        return client.name == "null-ls"
      end
    })
  end,
})
