require("toggleterm").setup({
    size = function(term)
        if term.direction == "horizontal" then
            return 20
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.3
        end
    end,

    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    autochdir = false,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
            return term.name
        end,
    },
    float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "single",
        -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
        width = 200,
        height = 50,
        winblend = 3,
        --zindex = 0,
        title_pos = "center",
    },
})
