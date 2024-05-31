vim.tbl_isarray = vim.isarray
vim.lsp.get_active_clients = vim.lsp.get_clients

vim.diagnostic.is_disabled = function()
    return not vim.diagnostic.is_enabled()
end

vim.cmd([[
    syntax on

    set nobackup
    set nowritebackup
]])

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.termguicolors = true
vim.o.mousemoveevent = true
vim.o.updatetime = 298
vim.o.signcolumn = "yes"

vim.o.foldcolumn = "0"
vim.o.foldlevel = 100
vim.o.foldlevelstart = 101
vim.o.foldenable = true

vim.o.number = true
vim.o.expandtab = true
vim.o.list = true

vim.o.cursorline = true

require("plugins")

require("eagle").setup({
    -- override the default values found in config.lua
})
-- make sure mousemoveevent is enabled
vim.o.mousemoveevent = true

require("menus")

--require("ai")
--require("comp")
--require("dbg")
--require("eaglesetup")
--require("format")
require("keybinds")
require("line")
require("lspsetup")
--require("plugins")
require("styles")
require("tgterm")
require("tree")
--require("tscope")
--require("tsit")
require("snippets")
require("autocmds")

vim.keymap.set("n", "<C-r>", function() end)

vim.api.nvim_create_user_command("FloatingWin", function(x)
    local width = tonumber(x.fargs[1])
    local height = tonumber(x.fargs[2])
    local ui = vim.api.nvim_list_uis()[1]

    local col = (ui.width / 2) - (width / 2)
    local row = (ui.height / 2) - (height / 2)

    if not (x.fargs[3] == nil) then
        col = tonumber(x.fargs[3])
    end

    if not (x.fargs[4] == nil) then
        row = tonumber(x.fargs[4])
    end

    local opts = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        anchor = "NW",
        style = "minimal",
    }

    local buf = vim.api.nvim_create_buf(false, true)

    local win = vim.api.nvim_open_win(buf, 1, opts)
end, { bang = false, nargs = "+" })

vim.keymap.set("i", "<C-M-l>", "<cmd>lua print(vim.bo[vim.api.nvim_win_get_buf(0)].filetype)<cr>")

--vim.cmd("colorscheme material-deep-ocean")
