return {
  -- Plugin manager (lazy.nvim)
  {
    "folke/lazy.nvim",
    version = "*",
  },

  -- Language Server Protocol configuration for TypeScript and other languages
  { "neovim/nvim-lspconfig" },
  
  -- Simple plugin for HTML syntax highlighting and formatting
  {
    "mattn/emmet-vim",  -- HTML/CSS abbreviation expansion
    ft = { "html", "css" }
  },
  
  -- Prettier formatting for HTML, CSS, JavaScript, etc
  {
    "prettier/vim-prettier",
    build = "npm install --frozen-lockfile --production",
    ft = { "html", "css", "javascript", "typescript", "json" }
  },
  -- Autocompletion engine with LSP integration
  {
    "hrsh7th/nvim-cmp",                  -- Autocompletion
    dependencies = {
      "ray-x/lsp_signature.nvim",        -- Function signature help
    },
  },
  -- LSP completion source for nvim-cmp
  { "hrsh7th/cmp-nvim-lsp" },
  -- Buffer text completion source for nvim-cmp
  { "hrsh7th/cmp-buffer" },
  -- File path completion source for nvim-cmp
  { "hrsh7th/cmp-path" },
  -- { "saadparwaiz1/cmp_luasnip" },
  -- { "L3MON4D3/LuaSnip" },

  -- Git integration for Neovim with Git commands and interface
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
        ensure_installed = { "typescript", "javascript", "tsx", "json", "lua", "go", "html" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Fast cursor movement and navigation with labeled jumps
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = false, -- Disable Flash during `/` search to avoid interference
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

  -- Catppuccin color scheme theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme catppuccin")
    end,
  },

  -- Customizable statusline with file info and Git status
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

  -- Utility library required by many Lua plugins
  { "nvim-lua/plenary.nvim" },
  -- LSP integration for linters and formatters (deprecated but still functional)
  { "jose-elias-alvarez/null-ls.nvim" },

  -- Ultra-fast fuzzy finder command-line tool
  {
    "junegunn/fzf",
    build = function() vim.fn.system("fzf/install --bin") end
  },
  -- Vim integration for fzf with file/buffer/search commands
  { "junegunn/fzf.vim" },
  
  -- Go plugin for enhanced Go development
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("go").setup({
        -- Enable auto-formatting on save
        gofmt = 'gofumpt',
        lsp_gofumpt = true,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- Installs/updates tooling
  },

  -- AI-powered coding assistant with chat and inline completion
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
