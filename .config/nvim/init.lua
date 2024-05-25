vim.tbl_isarray = vim.isarray
vim.lsp.get_active_clients = vim.lsp.get_clients

vim.diagnostic.is_disabled = function()
    return not vim.diagnostic.is_enabled()
end

vim.cmd([[
    syntax on
]])
--[[
    set nobackup
    set nowritebackup
]]

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.termguicolors = true
vim.o.mousemoveevent = true
vim.o.updatetime = 300
vim.o.signcolumn = "yes"

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.number = true
vim.o.expandtab = true
vim.o.list = true

vim.o.cursorline = true

require("plugins")

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

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("ShowNoteSigns", {}),
    callback = function(_)
        require("quicknote").ShowNoteSigns()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("LogFiletype", {}),
    callback = function(_)
        if vim.bo[vim.api.nvim_win_get_buf(0)].filetype == "TelescopePrompt" then
            local key = vim.api.nvim_replace_termcodes("<bs>", true, true, true)
            vim.api.nvim_feedkeys(key, "n", false)
        end
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("ExitInsertIf", {}),
    callback = function(_)
        local buf = vim.api.nvim_win_get_buf(0)
        if (vim.bo[buf].filetype == "go") or (vim.bo[buf].filetype == "lua") then
            vim.cmd("LspStart")
            vim.o.expandtab = true
            vim.o.shiftwidth = 4
            vim.o.tabstop = 4
            vim.cmd("TSBufEnable highlight")
        end
        if vim.bo[buf].filetype == "lazy" then
            local key = vim.api.nvim_replace_termcodes("<esc>", true, true, true)
            vim.api.nvim_feedkeys(key, "n", false)
        elseif not (vim.bo[buf].filetype == "dropbar_menu") then
            if not vim.bo[buf].modifiable then
                local key = vim.api.nvim_replace_termcodes("<esc>", true, true, true)
                vim.api.nvim_feedkeys(key, "n", false)
            else
                vim.cmd("startinsert")
            end
        end
    end,
})

--[[
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        --local client = vim.lsp.get_client_by_id(ev.data.client_id)
        --require("virtualtypes").on_attach(client)

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})

vim.diagnostic.config({
    update_in_insert = true,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false, -- set to true if lsp_lines disabled
    underline = true,
    signs = true,
    update_in_insert = true,
})
]]
--

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
