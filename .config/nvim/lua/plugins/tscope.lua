return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    opts = {
        defaults = {
            prompt_prefix = "🔎 ",
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
        pickers = {
            find_files = { theme = "dropdown" },
            filetypes = { theme = "dropdown" },
            neoclip = { theme = "dropdown" },
            current_buffer_fuzzy_find = { theme = "dropdown" },
            diagnostics = { theme = "dropdown" },
            lsp_references = { theme = "dropdown" },
            oldfiles = { theme = "dropdown" },
        },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
    end,
}
