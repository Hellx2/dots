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
        if vim.bo[buf].filetype == "html" then
            vim.keymap.set("i", "=", function()
                local key = "="
                if vim.bo[vim.api.nvim_win_get_buf(0)].filetype == "html" then
                    -- TODO: Check if in HTML tag, and not the closing one
                    key = vim.api.nvim_replace_termcodes('=""<left>', true, true, true)
                end
                vim.api.nvim_feedkeys(key, "n", false)
            end, { noremap = true })
        end
    end,
})

vim.api.nvim_create_autocmd(--[["DiagnosticChanged"]] "BufWritePre", {
    group = vim.api.nvim_create_augroup("DoFixCode", {}),
    callback = function(x)
        local buf = vim.api.nvim_win_get_buf(0)
        if vim.bo[buf].filetype == "rust" then
            vim.cmd("silent! %s/\\()\\)\\@<=[\\s\\n]*\\(\\s*[a-z0-9]\\)\\@=/;\\r/gie")
            --vim.cmd('silent! %s/\\(".*"\\)\\@<=[\\s\\n]*\\(\\s*[a-z0-9]\\)\\@=/;\\r/gie')
            local bufnr = vim.api.nvim_get_current_buf()
            local params = vim.lsp.util.make_range_params()

            params.context = {
                triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
                diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
            }

            local mutfixes = {}

            vim.lsp.buf.code_action({
                filter = function(a)
                    --vim.notify(a.command)
                    local title = a.title
                    if title:find("`mut") or title:find("+=") then
                        return true
                    end
                    return false
                end,
                apply = true,
                range = {
                    start = { 1, 0 },
                    ["end"] = { vim.fn.line("$"), 256 },
                },
            })

            vim.diagnostic.show()
        end
    end,
})
