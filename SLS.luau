local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local BallLoopActive = false
local ball = nil
local ESP = nil

local function findBall()
    for _, obj in pairs(game:GetService("Workspace").Junk:GetChildren()) do
        if obj:IsA("Part") and obj.Name == "Football" then 
            return obj
        end
    end
    return nil
end

local function createESP(gameball)
    if ESP then
        ESP:Destroy()
    end

    ESP = Instance.new("SphereHandleAdornment", gameball)
    ESP.Radius = gameball.Size.Magnitude * 0.38
    ESP.AlwaysOnTop = true
    ESP.ZIndex = 5
    ESP.Transparency = 0.7
    ESP.Color3 = Color3.fromRGB(192, 192, 192)
    ESP.Adornee = gameball
    ESP.AdornCullingMode = Enum.AdornCullingMode.Never
end

local function followPlayer()
    if ball and Character and Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = Character.HumanoidRootPart.CFrame.p + Vector3.new(0, -6, 0)
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(ball, tweenInfo, {Position = targetPosition})
        
        tween:Play()
        
        ReplicatedStorage:WaitForChild("UpdateBallPosition"):FireServer(targetPosition)
    else
        print("Nie znaleziono piłki lub postaci")
    end
end

local function toggleBallLoop()
    BallLoopActive = not BallLoopActive
    if BallLoopActive then
        ball = findBall()
        if ball then
            createESP(ball) -- Create or update ESP around the ball
            spawn(function()
                while BallLoopActive do
                    followPlayer()
                    wait(0.1)
                end
            end)
        else
            print("Nie znaleziono piłki w Workspace")
        end
    end
end

local function onCharacterAdded(newCharacter)
    Character = newCharacter
    if BallLoopActive then
        toggleBallLoop()
    end
end

Player.CharacterAdded:Connect(onCharacterAdded)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Four and not gameProcessed then
        toggleBallLoop()
    elseif (input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl) and not gameProcessed then
        print("Naciśnięto klawisz Control")

        local foundBall = findBall()
        if foundBall then
            foundBall.Position = Player.Character.HumanoidRootPart.Position
            createESP(foundBall) -- Update ESP when ball position is changed
            print("Przeniesiono piłkę na pozycję gracza")
        else
            print("Nie znaleziono piłki w Workspace")
        end
    end
end)

local remoteEvent = Instance.new("RemoteEvent")
remoteEvent.Name = "UpdateBallPosition"
remoteEvent.Parent = ReplicatedStorage 

local function trackGameball()
    while true do
        local gameball = findBall()
        if gameball then
            createESP(gameball)
        end
        wait(0.1)
    end
end

-- Start tracking the gameball for ESP
spawn(trackGameball)
