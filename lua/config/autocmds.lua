local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    desc = "Open Neo-tree on startup with directory",
    group = augroup("neo_tree_start"),
    callback = function()
        if package.loaded["neo-tree"] then
            vim.api.nvim_del_augroup_by_name("lazyvim_neo_tree_start")
        else
            local status = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
            if status and status.type == "directory" then
                vim.api.nvim_del_augroup_by_name("lazyvim_neo_tree_start")
                require("neo-tree")
            end
        end
    end,
})
