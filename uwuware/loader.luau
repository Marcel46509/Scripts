local StarterGui = game:GetService("StarterGui")
local gamesURL = "https://raw.githubusercontent.com/Marcel46509/Scripts/refs/heads/main/uwuware/games/"

local success : boolean, mainUwu : string | any = pcall(function()
    return game:HttpGet(`{gamesURL.. game.GameId}.luau`)
end)

if ((not success) or (mainUwu == "404: Not Found")) then
    StarterGui:SetCore("SendNotification", {
        Title = "uwuware",
        Text = "Loading universal script..."
    })

    return loadstring(game:HttpGet(gamesURL.. "universal.luau"))
end

return loadstring(mainUwu)()
