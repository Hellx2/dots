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

--vim.wo.statuscolumn = "%C%s %l%= │  "

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.termguicolors = true
vim.o.mousemoveevent = true
vim.o.updatetime = 300
vim.o.signcolumn = "yes"

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

vim.o.foldcolumn = "2"
vim.o.foldlevel = 100
vim.o.foldlevelstart = 101
vim.o.foldenable = true

vim.o.number = true
vim.o.expandtab = true
vim.o.list = true

vim.o.cursorline = true
vim.o.scrolloff = 7

vim.o.mousemoveevent = true

vim.g.menu_howto = true

require("settings")

require("plugins")

function reload()
    vim.cmd("colorscheme github_dark_dimmed")

    require("menus")

    require("autocmds")
    require("keybinds")
    require("line")
    require("lspsetup")
    require("nvide")
    require("snippets")

    vim.cmd.colorscheme("github_dark_dimmed")
    require("styles")
    require("tgterm")
    require("usercmds")

    vim.keymap.set("n", "<C-r>", function() end)

    vim.keymap.set("i", "<C-M-l>", "<cmd>lua print(vim.bo[vim.api.nvim_win_get_buf(0)].filetype)<cr>")

    vim.schedule(function()
        vim.cmd("TSContextEnable")
    end)
end

reload()

vim.api.nvim_create_user_command("Reload", reload, {})

