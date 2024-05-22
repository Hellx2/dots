vim.tbl_isarray = vim.isarray

vim.cmd([[
    syntax on

    set nobackup
    set nowritebackup
]])

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.termguicolors = true
vim.o.updatetime = 300
vim.o.signcolumn = "yes"

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.mousemoveevent = true

vim.o.number = true
vim.o.expandtab = true
--vim.o.lcs = "space:·,eol:↴"
vim.o.list = true

--require("telescope").load_extension("ui-select")
--vim.cmd.colorscheme("catppuccin")

require("plugins")

require("ai")
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

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, {})
        end
        -- whatever other lsp config you want
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("ExitInsertIf", {}),
    callback = function(_)
        local buf = vim.api.nvim_win_get_buf(0)
        if not (vim.bo[buf].filetype == "dropbar_menu") then
            if not vim.bo[buf].modifiable then
                local key = vim.api.nvim_replace_termcodes("<esc>", true, true, true)
                vim.api.nvim_feedkeys(key, "n", false)
            else
                vim.cmd("startinsert")
            end
        end
    end,
})
