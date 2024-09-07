local neogit_open = false

return {
    "nvim-lualine/lualine.nvim",
    enabled = vim.g.settings.enabled.lualine,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                globalstatus = true,
                theme = "auto",
            },
            sections = {
                lualine_a = {
                    {
                        'v:"e"',
                        draw_empty = true,
                        fmt = function()
                            return "Project"
                        end,
                        on_click = function()
                            vim.cmd([[
                                Neogit
                                q
                            ]])

                            neogit_open = false

                            require("neo-tree.command").execute({ action = "show", toggle = true })
                        end,
                    },
                    {
                        'v:"Commit"',
                        draw_empty = true,
                        fmt = function()
                            return "Commit"
                        end,
                        on_click = function()
                            vim.cmd("Neotree close")

                            if neogit_open then
                                vim.cmd([[
                                    Neogit kind=vsplit
                                    wincmd H
                                    vert res 40
                                ]])
                            else
                                vim.cmd([[
                                    Neogit
                                    q
                                ]])
                            end

                            neogit_open = not neogit_open
                        end,
                    },
                },
                lualine_z = {
                    {
                        'v:"Build"',
                        draw_empty = true,
                        fmt = function()
                            return "Build"
                        end,
                        on_click = function()
                            function run_this_file()
                                local buf = vim.api.nvim_win_get_buf(0)
                                local ft = vim.bo[buf].filetype
                                local filepath = vim.api.nvim_buf_get_name(0)

                                if ft == "go" then
                                    return "go run ."
                                elseif ft == "lua" then
                                    return "lua " .. filepath
                                elseif ft == "python" then
                                    return "python " .. filepath
                                elseif ft == "rust" then
                                    return "cargo run"
                                end
                            end

                            local key = vim.api.nvim_replace_termcodes(run_this_file() .. "<cr>", true, true, true)
                            vim.cmd("horizontal botright terminal")
                            vim.cmd("startinsert")
                            vim.api.nvim_feedkeys(
                                vim.api.nvim_replace_termcodes("clear<cr>", true, true, true),
                                "n",
                                true
                            )

                            vim.api.nvim_feedkeys(key, "n", true)
                        end,
                    },
                },
            },
        })
    end,
}
