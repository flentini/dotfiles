return {
  -- Plugin manager (lazy.nvim)
  {
    "folke/lazy.nvim",
    version = "*",
  },

  -- LSP & Autocompletion for TypeScript
  { "neovim/nvim-lspconfig" },
  {
    "hrsh7th/nvim-cmp",                  -- Autocompletion
    dependencies = {
      "ray-x/lsp_signature.nvim",        -- Function signature help
    },
  },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  -- { "saadparwaiz1/cmp_luasnip" },
  -- { "L3MON4D3/LuaSnip" },

  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" }, -- Lazy load on Git commands
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "typescript", "javascript", "tsx", "json", "lua" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = true, -- Enable Flash during `/` search
        },
        char = {
          jump_labels = true, -- Show labels for quick jumps
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "gs", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "gS", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme catppuccin")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim" ,
    -- remember to brew install --cask font-jetbrains-mono-nerd-font
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional, adds file icons
    config = function()
      require("lualine").setup({})
    end,
  },

  -- File Explorer
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   config = function()
  --     require("nvim-tree").setup()
  --   end
  -- },

  -- Linter and formatter
  { "nvim-lua/plenary.nvim" },
  { "jose-elias-alvarez/null-ls.nvim" },

  -- fzf for ultra-fast fuzzy searching
  {
    "junegunn/fzf",
    build = function() vim.fn.system("fzf/install --bin") end
  },
  { "junegunn/fzf.vim" },

  -- AI-powered coding
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        opts = {
          log_level = "DEBUG", -- or "TRACE"
        },
        strategies = {
          chat = {
            adapter = "anthropic",
          },
          inline = {
            adapter = "anthropic",
          },
        },
        display = {
          diff = {
            enabled = false
          }
        }
      })
    end,
  },
}
