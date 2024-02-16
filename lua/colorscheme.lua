local success, errmsg = pcall(vim.cmd.colorscheme, 'torte')
if not success then
    vim.notify(errmsg, vim.log.levels.WARN)
end
