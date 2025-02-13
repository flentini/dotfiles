-- Basic Settings
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false

vim.cmd("language en_US")

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
