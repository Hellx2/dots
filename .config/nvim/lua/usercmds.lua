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

vim.api.nvim_create_user_command("Projects", function(_)
    vim.cmd("Telescope projections")
end, { nargs = 0 })

vim.api.nvim_create_user_command("NewRustProject", function(x)
    local project_type = nil
    local project_name = nil

    if x.fargs[1] == nil then
        project_type = vim.fn.input("Enter the project type: ")
    else
        project_type = x.fargs[1]
    end

    if x.fargs[2] == nil then
        project_name = vim.fn.input("Enter the project name: ")
    else
        project_name = x.fargs[2]
    end

    local project_type_name = nil
    if project_type == "lib" then
        project_type_name = "Libraries"
    elseif project_type == "gtk" then
        project_type_name = "Applications/GTK"
    elseif project_type == "terminal" then
        project_type_name = "Applications/Terminal"
    end

    project_dir = os.getenv("HOME") .. "/Programming/Rust/" .. project_type

    os.execute("mkdir -p " .. project_dir)
    os.execute("cd " .. project_dir .. " && cargo new " .. project_name)
    os.execute("git init")

    vim.cmd("cd " .. project_dir .. "/" .. project_name)
end, { nargs = "*" })

vim.api.nvim_create_user_command("NewGoProject", function(x)
    local project_name = nil
    if x.fargs[1] == nil then
        project_name = vim.fn.input("Enter the project name: ")
    else
        project_name = x.fargs[1]
    end
    os.execute("mkdir -p " .. os.getenv("HOME") .. "/Programming/Go/" .. project_name)
    os.execute("cd " .. os.getenv("HOME") .. "/Programming/Go/" .. project_name)
    os.execute("go mod init " .. project_name)
    os.execute("git init")

    vim.cmd("cd " .. os.getenv("HOME") .. "/Programming/Go/" .. project_name)
end, { nargs = "*" })

vim.api.nvim_create_user_command("NewJavaProject", function(x)
    local project_name = nil
    if x.fargs[1] == nil then
        project_name = vim.fn.input("Enter the project name: ")
    else
        project_name = x.fargs[1]
    end

    local home_dir = os.getenv("HOME") .. "/Programming/Java/" .. project_name
    os.execute(
        "mkdir -p "
            .. home_dir
            .. " && cd "
            .. home_dir
            .. " && mkdir -p src/io/github/hellx2/"
            .. project_name
            .. " && mkdir build"
            .. [[ && echo -e 'package io.github.hellx2.]]
            .. project_name
            .. [[;\n\npublic class Main {\n    public static void main(String[] args) {\n        System.out.println("Hello, world!");\n    }\n}' > src/io/github/hellx2/]]
            .. project_name
            .. [[/Main.java]]
            .. " && git init"
    )

    vim.cmd("cd " .. os.getenv("HOME") .. "/Programming/java/" .. project_name)
end, { nargs = "*" })

vim.api.nvim_create_user_command("NewPythonProject", function(x)
    local project_name = nil
    if x.fargs[1] == nil then
        project_name = vim.fn.input("Enter the project name: ")
    else
        project_name = x.fargs[1]
    end

    local project_dir = os.getenv("HOME") .. "/Programming/python/" .. project_name

    os.execute("mkdir -p " .. project_dir)
    os.execute("git init" .. project_dir)

    vim.cmd("cd " .. project_dir)
end, { nargs = "*" })

vim.api.nvim_create_user_command("NewProject", function(x)
    if x.fargs[1] == "rust" then
        vim.cmd("NewRustProject")
    elseif x.fargs[1] == "go" then
        vim.cmd("NewGoProject")
    elseif x.fargs[1] == "java" then
        vim.cmd("NewJavaProject")
    elseif x.fargs[1] == "python" then
        vim.cmd("NewPythonProject")
    elseif x.fargs[1] == nil then
        local buf = vim.api.nvim_create_buf(false, true)
        local ui = vim.api.nvim_list_uis()[1]
        local win = vim.api.nvim_open_win(buf, true, {
            width = 100,
            height = 30,
            relative = "editor",
            style = "minimal",
            border = "single",
            col = ui.width / 2 - 50,
            row = ui.height / 2 - 15,
        })

        vim.api.nvim_buf_set_lines(buf, 0, 30, false, {
            "Welcome to the new project creator!",
            "Choose the project type:",
            "[1] rust",
            "[2] go",
            "[3] java",
            "[4] python",
            "[5] quit",
        })

        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, true, true), "n", false)

        vim.keymap.set("n", "<esc>", function()
            vim.api.nvim_win_close(win, true)
        end, { buffer = buf })

        vim.keymap.set("n", "q", function()
            vim.api.nvim_win_close(win, true)
        end, { buffer = buf })

        vim.keymap.set("n", "1", function()
            vim.cmd("NewRustProject")
        end, { buffer = buf })

        vim.keymap.set("n", "2", function()
            vim.cmd("NewGoProject")
        end, { buffer = buf })

        vim.keymap.set("n", "3", function()
            vim.cmd("NewJavaProject")
        end, { buffer = buf })

        vim.keymap.set("n", "4", function()
            vim.cmd("NewPythonProject")
        end, { buffer = buf })

        vim.keymap.set("n", "5", function()
            vim.api.nvim_win_close(win, true)
        end, { buffer = buf })
    end
end, { nargs = "*" })
