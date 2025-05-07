-- Basic Settings
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false

-- Make line numbers more visible (with higher priority than themes)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#888888" })
  end,
})

vim.cmd("language en_US.UTF-8")

-- Lazy.nvim (Plugin Manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

require("lsp")

-- fzf config
vim.g.fzf_preview_window = {'right:50%', 'ctrl-/'}
vim.env.FZF_DEFAULT_COMMAND = "fd --type f"
vim.env.FZF_DEFAULT_OPTS = "--preview 'bat --style=numbers --color=always --line-range=:100 {}'"
vim.keymap.set("n", "<C-p>", ":Files<CR>", { noremap = true, silent = true })

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 }) -- Adjust timeout as needed
  end,
})

-- Navigate tabs with PageUp/PageDown
vim.keymap.set("n", "<PageUp>", "gT", { noremap = true, silent = true })
vim.keymap.set("n", "<PageDown>", "gt", { noremap = true, silent = true })

-- Go template using custom implementation instead of GoNew
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.go", 
  callback = function()
    -- Apply basic template for Go files
    local filename = vim.fn.expand("%:t")
    local dirname = vim.fn.expand("%:p:h:t")
    local package_name = dirname
    
    -- Default to main for main.go files or when directory might not be a good package name
    if filename == "main.go" or package_name:match("^%d") then
      package_name = "main"
    end
    
    local template = {
      "package " .. package_name,
      "",
    }
    
    -- Add import and main function for main package
    if package_name == "main" then
      table.insert(template, "import (")
      table.insert(template, '\t"fmt"')
      table.insert(template, ")")
      table.insert(template, "")
      table.insert(template, "func main() {")
      table.insert(template, '\tfmt.Println("Hello, world!")')
      table.insert(template, "}")
    end
    
    vim.api.nvim_buf_set_lines(0, 0, 0, false, template)
  end,
})
