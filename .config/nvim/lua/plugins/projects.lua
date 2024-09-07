return {
    "gnikdroy/projections.nvim",
    branch = "pre_release",
    config = function()
        require("projections").setup({
            workspaces = {
                { "~/Programming/Rust/Libraries", { "Cargo.toml", ".git" } },
                { "~/Programming/Rust/Applications/GTK", { "Cargo.toml", ".git" } },
                { "~/Programming/Rust/Applications/Terminal", { "Cargo.toml", ".git" } },
                { "~/Programming/Go", { "go.mod", ".git" } },
                { "~/Programming/Go/GolandProjects", { "go.mod", ".git", ".idea" } },
                { "~/.config", { "init.lua" } },
                "~/Programming/C & C++/CLionProjects",
                "~/Programming/Python",
                "~/Programming/Python/PycharmProjects",
                "~/Programming/Web",
                "~/Programming/Java",
                "~/Programming/Oreon",
            },
            patterns = { ".git", ".idea", "Cargo.toml" },
            store_hooks = {
                pre = function()
                    vim.o.winbar = ""
                    vim.cmd([[Trouble diagnostics close]])
                    if pcall(require, "neo-tree") then
                        vim.cmd([[Neotree action=close]])
                    end
                end,
            },
        })

        -- Autostore session on VimExit
        local Session = require("projections.session")
        vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
            callback = function()
                Session.store(vim.loop.cwd())
            end,
        })

        vim.api.nvim_create_autocmd({ "VimEnter" }, {
            callback = function()
                if vim.fn.argc() ~= 0 then
                    return
                end
                local session_info = Session.info(vim.loop.cwd())
                if session_info == nil then
                    Session.restore_latest()
                else
                    Session.restore(vim.loop.cwd())
                end
            end,
            desc = "Restore last session automatically",
        })

        -- Switch to project if vim was started in a project dir
        --[[local switcher = require("projections.switcher")
        vim.api.nvim_create_autocmd({ "VimEnter" }, {
            callback = function()
                if vim.fn.argc() == 0 then
                    switcher.switch(vim.loop.cwd())
                end
            end,
        })]]
        --

        vim.opt.sessionoptions:append("localoptions")
    end,
}
