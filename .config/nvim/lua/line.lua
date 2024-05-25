local statusline = require("statusline")
statusline.lsp_diagnostics = true
statusline.tabline = false
require("bufferline").setup({
    options = {
        close_command = "Bdelete %d",
        right_mouse_command = "Bdelete %d",
        hover = {
            enabled = true,
            delay = 0,
            reveal = { "close" },
        },
        separator_style = "slant",
        always_show_bufferline = true,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
    },
})
