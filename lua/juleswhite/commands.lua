vim.cmd [[
    command! BuildSaveshare lua BuildSaveshare()
    command! SServer lua SServer()
]]

function BuildSaveshare()
    local cmd = 'dotnet build ~/projects/saveshare/src/client/saveshare.csproj'
    local output = vim.fn.system(cmd)
    vim.notify(output)
end

function SServer()
    local sessionname = "SSERVER"
    local windowExists = CheckTmuxWindowExists(sessionname)

    if windowExists then
        vim.notify("Window already exists")
        return
    end

    os.execute("tmux new-window -n " .. sessionname)
    os.execute("tmux send-keys -t " .. sessionname .. " 'clear; cd ~/projects/saveshare/src/server' Enter")
    os.execute("tmux send-keys -t " .. sessionname .. " 'clear; dotnet run' Enter")
    vim.notify("Started Server!")
end


function CheckTmuxWindowExists(windowName)
    local cmd = 'tmux list-windows -F "#W" | grep -q "^' .. windowName .. '$"'
    local success, _ = os.execute(cmd)
    return success == 0
end

