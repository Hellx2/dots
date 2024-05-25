return {
    "mhartington/formatter.nvim",
    config = function()
        vim.cmd([[
        augroup FormatAutogroup
            autocmd!
            autocmd BufWritePost * FormatWrite
        augroup END
    ]])
        local util = require("formatter.util")
        require("formatter").setup({
            logging = true,
            log_level = vim.log.levels.WARN,
            filetype = {
                lua = {
                    require("formatter.filetypes.lua").stylua,

                    function()
                        if util.get_current_buffer_file_name() == "special.lua" then
                            return nil
                        end

                        return {
                            exe = "stylua",
                            args = {
                                "--search-parent-directories",
                                "--indent-type=Spaces",
                                "--stdin-filepath",
                                util.escape_path(util.get_current_buffer_file_path()),
                                "--",
                                "-",
                            },
                            stdin = true,
                        }
                    end,
                },

                rust = {
                    require("formatter.filetypes.rust").rustfmt,
                },

                html = {
                    function()
                        return {
                            exe = "prettier",
                            args = {
                                "--tab-width=4",
                                util.escape_path(util.get_current_buffer_file_path()),
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },

                css = {
                    function()
                        return {
                            exe = "prettier",
                            args = {
                                "--tab-width=4",
                                util.escape_path(util.get_current_buffer_file_path()),
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },

                php = {
                    require("formatter.defaults.prettier"),
                },

                ["*"] = {
                    require("formatter.filetypes.any").remove_trailing_whitespace,
                },
            },
        })
    end,
}
