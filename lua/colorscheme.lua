local cs = {}


function cs.setup(args)
    local default_args = {
        colorscheme = 'torte',
    }
    setmetatable(args, {__index = default_args})

    local colorscheme = args[1] or args.colorscheme
    local success, errmsg = pcall(vim.cmd.colorscheme, colorscheme)
    if not success then
        vim.notify(errmsg, vim.log.levels.WARN)
    end
end


return cs
