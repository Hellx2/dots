local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("html", {
    s("meta", {
        t({
            "<meta charset='utf-8' />",
            "<meta name='viewport' content='width=device-width, initial-scale=1' />",
            "<meta name='author' content='Hellx2' />",
            "<meta name='description' content='",
        }),
        i(1),
        t("' />"),
    }),
    s("head", {
        t({
            "<head>",
            "<title>",
        }),
        i(1),
        t({
            "</title>",
            "<meta charset='utf-8' />",
            "<meta name='viewport' content='width=device-width, initial-scale=1' />",
            "<meta name='author' content='Hellx2' />",
            "<meta name='description' content='",
        }),
        i(2),
        t({
            "' />",
            "</head>",
        }),
    }),
    s("doctype", {
        t({ "<!doctype html>" }),
    }),
    s("html", {
        t({ "<html lang='en'>", "    <head>" }),
        i(1),
        t({ "", "    </head>", "<body>", "</body>", "</html>" }),
    }),
})
