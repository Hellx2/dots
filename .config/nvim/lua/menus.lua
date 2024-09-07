vim.opt.swapfile = false

if vim.g.menu_howto then
    vim.cmd("aunmenu PopUp.How-to\\ disable\\ mouse")
    vim.g.menu_howto = false
end
--vim.cmd("aunmenu PopUp.-1-")

local function add_line(name, command)
    vim.cmd("inoremenu PopUp." .. name .. " " .. command)
    vim.cmd("nnoremenu PopUp." .. name .. " " .. command)
end

local function addnline(name, command)
    vim.cmd("nnoremenu PopUp." .. name .. " " .. command)
end

add_line("Swap\\ With\\ Line\\ Above", "<cmd>delete<cr><up><up><cmd>put<cr>")
add_line("Swap\\ With\\ Line\\ Below", "<cmd>delete<cr><cmd>put<cr>")

add_line("-2-", "_")

add_line("Copy\\ Line", "<cmd>yank +<cr>")
add_line("Delete\\ Line", "<cmd>delete<cr>")

add_line("-3-", "_")

add_line("Undo", "<cmd>undo<cr>")
add_line("Redo", "<cmd>redo<cr>")

add_line("-4-", "_")
add_line("Go\\ To\\ Definition", "<cmd>lua vim.lsp.buf.definition()<cr>")
add_line("Go\\ To\\ Implementation", "<cmd>lua vim.lsp.buf.implementation()<cr>")

add_line("-5-", "_")

add_line("Fold", "<cmd>foldclose<cr>")
add_line("Unfold", "<cmd>foldopen<cr>")

add_line("-6-", "_")

add_line("Settings", "<cmd>e ~/.config/nvim/init.lua<cr>")

-----------------
-- NORMAL ONLY --
-----------------

addnline("-6-", "_")
addnline("Move\\ Window To Left", "")
