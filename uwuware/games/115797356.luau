--//Locals
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local PolicyService = game:GetService("PolicyService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local CurrentCamera = workspace.CurrentCamera

local Library, ESPLibrary, Window, Watermark, Configuration = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcel46509/Scripts/refs/heads/main/uwuware/ui.luau'))()

local Sounds = {
	[workspace.Sounds.Arm] = "Arm",
	[workspace.Sounds.Becky] = "Becky",
	[workspace.Sounds.Beep] = "Beep",
	[workspace.Sounds.CT] = "CT",
	[workspace.Sounds.T] = "T",
	[workspace.Sounds.Defuse] = "Defuse",
	[workspace.Sounds.Rescue] = "Rescue",
	[workspace.Sounds.Explosion] = "Explosion",
	[workspace.RoundEnd] = "RoundEnd",
	[workspace.RoundStart] = "RoundStart"
}

--//Functions

local function IsVisible(Position : Vector3, IgnoreList : {any})
	local head : BasePart = ((LocalPlayer.Character) and (LocalPlayer.Character:FindFirstChild("Head")))

	if ((head) and (#CurrentCamera:GetPartsObscuringTarget({head.Position, Position}, IgnoreList) == 0)) then
		return true
	end

	return false
end

local function IsAlive(player : Player)
	local humanoid = ((player.Character) and (player.Character:FindFirstChildOfClass("Humanoid")))

    if (not humanoid) then return end
    if (humanoid.Health <= 0) then return end

	return true
end

local function IsTeammate(player : Player)
    return (LocalPlayer.Team.Name == player.Team.Name)
end

local function GetPlayersNames()
	local list = {}

	for _, player : Player in ipairs(Players:GetPlayers()) do
		table.insert(list, player.Name)
	end

	return list
end

--//Main

local function GetClosestPlayer(FOV : number)
	local closestPlayer = nil

	for _, player in ipairs(Players:GetPlayers()) do
		if (player == LocalPlayer) then continue end

		if (not IsAlive(player)) then continue end
        if (not Configuration.Aimbot_Teammates) then if (IsTeammate(player)) then continue end end

		local head = ((player.Character) and (player.Character:FindFirstChild("Head")))
		if (not head) then continue end

		if (Configuration.Aimbot_VisibleOnly) then
			if (not IsVisible(head.Position, {player.Character, LocalPlayer.Character, CurrentCamera})) then
				continue
			end
		end

		local viewportPoint, isOnScreen = CurrentCamera:WorldToViewportPoint(head.Position)

		if (isOnScreen) then
			local screenPosition = Vector2.new(viewportPoint.X, viewportPoint.Y)
			local distance = (UserInputService:GetMouseLocation() - screenPosition).Magnitude

			if (distance < FOV) then
				closestPlayer = player
				FOV = distance
			end
		end
	end

	return closestPlayer, FOV
end

--//Scripts

local materials = {}

for _, material in pairs(Enum.Material:GetEnumItems()) do
	table.insert(materials, material.Name)
end

pcall(function()
	Configuration.AssistCircle = Drawing.new("Circle")
	Configuration.SilentCircle = Drawing.new("Circle")

	Configuration.AssistCircle.Visible = false
	Configuration.SilentCircle.Visible = false

	Configuration.AssistCircle.Color = Configuration.Color
	Configuration.SilentCircle.Color = Configuration.Color

	Configuration.AssistCircle.Transparency = 0.5
	Configuration.SilentCircle.Transparency = 0.5
end)

--//

ESPLibrary.teamcheck = true

ESPLibrary.outlines = false
ESPLibrary.shortnames = false

ESPLibrary.team_boxes = { false, Configuration.Color,Color3.fromRGB(1,1,1), 0 }
ESPLibrary.team_chams = { false, Configuration.Color, Configuration.Color, .25, .75, true}
ESPLibrary.team_names = { false, Configuration.Color }
ESPLibrary.team_distance = false
ESPLibrary.team_health = false

--//

local Legit = Window:CreateTab("Legit")

local Aimbot = Legit:CreateSector("Aimbot", "Left")

Aimbot:AddToggle("Enabled", false, function(toggle : boolean)
	Configuration.Aimbot_Enabled = toggle
end)

Aimbot:AddToggle("Aim Assist", false, function(toggle : boolean)
	Configuration.AssistAim = toggle
end):AddKeybind(Enum.KeyCode.E, "AimAssist")

Aimbot:AddToggle("Silent Aim", false, function(toggle : boolean)
	Configuration.SilentAim = toggle
end)

Aimbot:AddToggle("Visible Only", false, function(toggle : boolean)
	Configuration.Aimbot_VisibleOnly = toggle
end)

Aimbot:AddToggle("Teammates", false, function(toggle : boolean)
	Configuration.Aimbot_Teammates = toggle
end)

Aimbot:AddSlider("Aim Assist FOV", 1, 1, 1000, 1, function(value : number)
	Configuration.AssistFOV = value
end)

Aimbot:AddSlider("Silent Aim FOV", 1, 1, 1000, 1, function(value : number)
	Configuration.SilentFOV = value
end)

Aimbot:AddSlider("Smoothness", 1, 1, 10, 1, function(value : number)
	Configuration.Smoothness = value
end)

Aimbot:AddDropdown("Hitboxes", {"Head", "Body", "Arms", "Legs"}, nil, true, function(selected : string)
	Configuration.Hitboxes = selected
end)

local LegitOther = Legit:CreateSector("Other", "Right")

LegitOther:AddToggle("Triggerbot", false, function(toggle : boolean)
	Configuration.Triggerbot = toggle
end)

LegitOther:AddSlider("Triggerbot Delay [ms]", 0, 0, 1000, 1, function(value : number)
	Configuration.TriggerbotDelay = (value / 1000)
end)

--//

local Rage = Window:CreateTab("Rage")

local RageBot = Rage:CreateSector("Ragebot", "Left")

local RageOther = Rage:CreateSector("Other", "Right")

RageOther:AddToggle("Kill All", false, function(toggle : boolean)
    Configuration.KillAll = toggle
end)

RageOther:AddToggle("Fake Duck", false, function(toggle : boolean)
    Configuration.FakeDuck = toggle
end):AddKeybind(Enum.KeyCode.Y, "FakeDuck")

local AntiAim = Rage:CreateSector("Anti-Aim", "Left")

--//

local Visuals = Window:CreateTab("Visuals")

local ESP = Visuals:CreateSector("ESP", "Left")

ESP:AddToggle("Enabled", false, function(toggle : boolean)
	ESPLibrary.enabled = toggle
end)

ESP:AddToggle("Box ESP", false, function(toggle : boolean)
	ESPLibrary.team_boxes[1] = toggle
end):AddColorpicker(Configuration.Color, function(color : Color3)
	ESPLibrary.team_boxes[2] = color
end)

ESP:AddToggle("Chams ESP", false, function(toggle : boolean)
	ESPLibrary.team_chams[1] = toggle
end):AddColorpicker(Configuration.Color, function(color : Color3)
	ESPLibrary.team_chams[2] = color
	ESPLibrary.team_chams[3] = color
end)

ESP:AddToggle("Name ESP", false, function(toggle : boolean)
	ESPLibrary.team_names[1] = toggle
end):AddColorpicker(Configuration.Color, function(color : Color3)
	ESPLibrary.team_names[2] = color
end)

ESP:AddToggle("Tracers", false, function(toggle : boolean)

end):AddColorpicker(Configuration.Color, function(color : Color3)

end)

ESP:AddToggle("Short Names", false, function(toggle : boolean)
	ESPLibrary.shortnames = toggle
end)

ESP:AddToggle("Distance", false, function(toggle : boolean)
	ESPLibrary.team_distance = toggle
end)

ESP:AddToggle("Health", false, function(toggle : boolean)
	ESPLibrary.team_health = toggle
end)

ESP:AddToggle("Outlines", false, function(toggle : boolean)
	ESPLibrary.outlines = toggle
end)

ESP:AddToggle("Teammates", false, function(toggle : boolean)
	ESPLibrary.teamcheck = (not toggle)
end)

local Local = Visuals:CreateSector("Local", "Right")

Local:AddToggle("Force Crosshair", false, function(toggle : boolean)
    Configuration.ForceCrosshair = toggle
end)

Local:AddToggle("Remove Scope", false, function(toggle : boolean)
    Configuration.RemoveScope = toggle
end)

Local:AddToggle("Remove Flash", false, function(toggle : boolean)
    Configuration.RemoveFlash = toggle
end)

Local:AddToggle("Remove Smoke", false, function(toggle : boolean)
    Configuration.RemoveSmoke = toggle
end)

Local:AddToggle("Remove Bullet Holes", false, function(toggle : boolean)
    Configuration.RemoveBullet = toggle
end)

Local:AddToggle("Remove Blood", false, function(toggle : boolean)
    Configuration.RemoveBlood = toggle
end)

Local:AddToggle("Remove Ragdolls", false, function(toggle : boolean)
    Configuration.RemoveRagdolls = toggle
end)

local VMChams = Local:AddToggle("Viewmodel Chams", false, function(toggle : boolean)
    Configuration.Viewmodel_Chams_Enabled = toggle
end)

VMChams:AddColorpicker(Configuration.Color, function(color : Color3)
    Configuration.Viewmodel_Chams = color
end)

VMChams:AddDropdown(materials, materials[1], false, function(selected : string)
    Configuration.Viewmodel_Chams_Material = selected
end)

local WeaponChams = Local:AddToggle("Weapon Chams", false, function(toggle : boolean)
    Configuration.Weapon_Chams_Enabled = toggle
end)

WeaponChams:AddColorpicker(Configuration.Color, function(color : Color3)
    Configuration.Weapon_Chams = color
end)

WeaponChams:AddDropdown(materials, materials[1], false, function(selected : string)
   Configuration.Weapon_Chams_Material = selected
end)

Local:AddToggle("FOV Changer", false, function(toggle : boolean)
    Configuration.FOVChanger = toggle
end):AddSlider(0, 80, 120, 1, function(value : number)
    Configuration.FOVValue = value
end)

local FOVCircle = Local:AddToggle("FOV Circle", false, function(toggle : boolean)
	Configuration.FOVCircle = toggle
end)

FOVCircle:AddColorpicker(Configuration.Color, function(color : Color3)
	Configuration.AssistCircleColor = color
end)

FOVCircle:AddColorpicker(Configuration.Color, function(color : Color3)
	Configuration.SilentCircleColor = color
end)

local VisualsMisc = Visuals:CreateSector("Misc", "Left")

VisualsMisc:AddToggle("Bullet Tracers", false, function(toggle : boolean)
	Configuration.BulletTracers = toggle
end):AddColorpicker(Configuration.Color, function(color : Color3)
	Configuration.BulletTracerColor = color
end)

VisualsMisc:AddToggle("Hit Chams", false, function(toggle : boolean)
	Configuration.HitChams = toggle
end):AddColorpicker(Configuration.Color, function(color : Color3)
	Configuration.HitChamColor = color
end)

VisualsMisc:AddToggle("Third Person", false, function(toggle : boolean)
    Configuration.ThirdPerson = toggle
end):AddKeybind(Enum.KeyCode.X)

VisualsMisc:AddSlider("Third Person Distance", 0, 5, 128, 1, function(value : number)
    Configuration.ThirdPersonDistance = value
end)

VisualsMisc:AddDropdown("Tracer Type", {}, "Part", false, function(selected : string)
	Configuration.BulletTracerType = selected
end)

local World = Visuals:CreateSector("World", "Right")

World:AddToggle("Correction", false, function(toggle : boolean)
	if (Configuration.ColorCorrection) then
		Configuration.ColorCorrection.Enabled = toggle
	else
		local color = Instance.new("ColorCorrectionEffect")
		color.TintColor = (Configuration.ColorCorrectionColor or Configuration.Color)
		color.Enabled = toggle
		color.Parent = Lighting

		Configuration.ColorCorrection = color
	end
end):AddColorpicker(Configuration.Color, function(color : Color3)
	local colorCorrection = Configuration.ColorCorrection

    Configuration.ColorCorrectionColor = color

	if (colorCorrection) then
		colorCorrection.TintColor = Configuration.ColorCorrectionColor
	end
end)

World:AddToggle("Time Changer", false, function(toggle : boolean)
	if (toggle) then
		Configuration.OldTime = Lighting.ClockTime
	else
		Lighting.ClockTime = (Configuration.OldTime or Lighting.ClockTime)
	end

	Configuration.TimeChanger = toggle
end):AddSlider(0, 14, 24, 1, function(value : number)
	Configuration.Time = value
end)

World:AddToggle("Remove Shadows", false, function(toggle : boolean)
	Lighting.GlobalShadows = (not toggle)
end)

local Viewmodel = Visuals:CreateSector("Viewmodel", "Right")

Viewmodel:AddToggle("Enabled", false, function(toggle : boolean)
    Configuration.Viewmodel_Enabled = toggle
end, "ViewmodelEnabled")

Viewmodel:AddSlider("X", 0, 180, 360, 1, function(value : number)
    Configuration.Viewmodel_X = value
end, "ViewmodelX")

Viewmodel:AddSlider("Y", 0, 180, 360, 1, function(value : number)
    Configuration.Viewmodel_Y = value
end, "ViewmodelY")

Viewmodel:AddSlider("Z", 0, 180, 360, 1, function(value : number)
    Configuration.Viewmodel_Z = value
end, "ViewmodelZ")

Viewmodel:AddSlider("Roll", 0, 180, 360, 1, function(value : number)
    Configuration.Viewmodel_Roll = value
end, "ViewmodelRoll")

--//

local Misc = Window:CreateTab("Misc")

local MiscMain = Misc:CreateSector("Main", "Left")

MiscMain:AddToggle("Hit Logs", false, function(toggle : boolean)
	Configuration.HitLogs = toggle
end)

MiscMain:AddToggle("Spectator List", false, function(toggle : boolean)
	Configuration.SpectatorList = toggle
end)

MiscMain:AddButton("Unlock Inventory")

local MiscPlayers = Misc:CreateSector("Players", "Right")

local PlayerSelector = MiscPlayers:AddDropdown("Player", GetPlayersNames(), "nil", false, function(selected : string)
	local player : Player = Players:FindFirstChild(selected)

	if (player) then
        Configuration.SelectedPlayer = selected

		local success, result = pcall(function()
			return PolicyService:GetPolicyInfoForPlayerAsync(player)
		end)

		if (success) then
			Configuration.UnderAge:Set("<13: ".. tostring(not result.AreAdsAllowed))
		else
			Configuration.UnderAge:Set("<13: ".. "error")
		end

        if (table.find(Configuration.LoopKill, selected)) then
            Configuration.LPKill:Set(true)
        else
            Configuration.LPKill:Set(false)
        end

		Configuration.Team:Set("Team: ".. (player.Team.Name or ""))
		Configuration.Alive:Set("Alive: ".. tostring(IsAlive(player)))

		Configuration.Age:Set("Account Age: ".. player.AccountAge)
	end
end)

Configuration.LPKill =  MiscPlayers:AddToggle("Loop Kill", false, function(toggle : boolean)
    if (toggle) then
        if (not Configuration.LoopKill) then
            Configuration.LoopKill = {}
        end

        table.insert(Configuration.LoopKill, (Configuration.SelectedPlayer or ""))
    else
        local loopKillId = ((Configuration.LoopKill) and (table.find(Configuration.LoopKill, Configuration.SelectedPlayer)))

        if (loopKillId) then
            table.remove(Configuration.LoopKill, loopKillId)
        end
    end
end)

Configuration.UnderAge = MiscPlayers:AddLabel("<13: ")
Configuration.Team = MiscPlayers:AddLabel("Team: ")
Configuration.Alive = MiscPlayers:AddLabel("Alive: ")
Configuration.Age = MiscPlayers:AddLabel("Account Age: ")

local Funny = Misc:CreateSector("Funny", "Left")

Funny:AddDropdown("Play Sound", Sounds, "sound", false, function(selected : string)
	for sound : Sound, name : string in next, Sounds do
		if (name == selected) then
			sound:Play()
			break
		end
	end
end)

--//

local Exploits = Window:CreateTab("Exploits")

local ExploitsMain = Exploits:CreateSector("Main", "Left")

ExploitsMain:AddToggle("Infinite Cash", false, function(toggle : boolean)
    Configuration.InfiniteCash = toggle
end)

ExploitsMain:AddToggle("Infinite Ammo", false, function(toggle : boolean)
    Configuration.InfiniteAmmo = toggle
end)

ExploitsMain:AddToggle("Instant Equip", false, function(toggle : boolean)
    Configuration.InstantEquip = toggle
end)

ExploitsMain:AddToggle("Instant Reload", false, function(toggle : boolean)
    Configuration.InstantReload = toggle
end)

ExploitsMain:AddToggle("Double Tap", false, function(toggle : boolean)
    Configuration.DoubleTap = toggle
end)

ExploitsMain:AddToggle("No Fall Damage", false, function(toggle : boolean)
    Configuration.NoFallDamage = toggle
end)

ExploitsMain:AddToggle("No Fire Damage", false, function(toggle : boolean)
    Configuration.NoFireDamage = toggle
end)

ExploitsMain:AddToggle("Anti Votekick", false, function(toggle : boolean)
    Configuration.AntiVotekick = toggle
end)

ExploitsMain:AddToggle("Lag Spectators", false, function(toggle : boolean)
    Configuration.LagSpectators = toggle
	Configuration.SpectatorTick = (tick() - 10)
end):AddSlider(0, 5, 10, 1, function(value : number)
    Configuration.SpectatorDelay = value
end)

--[[
ExploitsMain:AddToggle("Fake Lag", false, function(toggle : boolean)

end)
--]]

local GunMods = Exploits:CreateSector("Gun Mods", "Right")

--[[
GunMods:AddToggle("Damage Modifier", false, function(toggle : boolean)

end)
--]]

GunMods:AddToggle("Remove Recoil", false, function(toggle : boolean)
    Configuration.RemoveRecoil = toggle
end)

GunMods:AddToggle("Remove Spread", false, function(toggle : boolean)
    Configuration.RemoveSpread = toggle
end)

GunMods:AddToggle("Minimum Damage", false, function(toggle : boolean)
    Configuration.MinimumDamage = toggle
end):AddSlider(0, 1, 100, 1, function(value : number)
    Configuration.MinimumDamageValue = value
end)

local ExploitsOther = Exploits:CreateSector("Other", "Right")

ExploitsOther:AddKeybind("Mouse Target Remove", Enum.KeyCode.J, nil, function()
    if (Mouse.Target) then
        Mouse.Target:Destroy()
    end
end)

--//

Players.PlayerAdded:Connect(function(player : Player)
	PlayerSelector:Add(player.Name)
end)

Players.PlayerRemoving:Connect(function(player : Player)
	PlayerSelector:Remove(player.Name)
end)

--//

local connection

connection = RunService.RenderStepped:Connect(function()
	if ((not Window) or (not Window.Main)) then
		connection:Disconnect()
		return
	end

	--//

	if (Configuration["TimeChanger"]) then
		Lighting.ClockTime = Configuration.Time
	end

	--//

	if (Configuration["LagSpectators"]) then
		if ((tick() - Configuration.SpectatorTick) >= Configuration.SpectatorDelay) then
			Configuration.SpectatorCFrame = CurrentCamera.CFrame
		end
	end

	--//

	if ((Configuration["FOVCircle"]) and (Configuration["Aimbot_Enabled"])) then
		local mouseLocation = UserInputService:GetMouseLocation()

		--//

		Configuration.AssistCircle.Visible = Configuration.AssistAim
		Configuration.AssistCircle.Color = (Configuration.AssistCircleColor or Configuration.Color)

		Configuration.AssistCircle.Radius = (Configuration.AssistFOV or 1)
		Configuration.AssistCircle.Thickness = 1
		Configuration.AssistCircle.Filled = false
		Configuration.AssistCircle.NumSides = 60
		Configuration.AssistCircle.Position = Vector2.new(mouseLocation.X, mouseLocation.Y)

		--//

		Configuration.SilentCircle.Visible = Configuration.SilentAim
		Configuration.SilentCircle.Color = (Configuration.SilentCircleColor or Configuration.Color)

		Configuration.SilentCircle.Radius = (Configuration.SilentFOV or 1)
		Configuration.SilentCircle.Thickness = 1
		Configuration.SilentCircle.Filled = false
		Configuration.SilentCircle.NumSides = 60
		Configuration.SilentCircle.Position = Vector2.new(mouseLocation.X, mouseLocation.Y)
	else
		Configuration.AssistCircle.Visible = false
		Configuration.SilentCircle.Visible = false
	end

	--//

	if (Configuration["Triggerbot"]) then
        local player = ((Mouse.Target) and (Players:GetPlayerFromCharacter(Mouse.Target.Parent)))

		if (player) then
			if (not Configuration.TriggerbotDeb) then
				Configuration.TriggerbotDeb = true

				task.delay((Configuration.TriggerbotDelay or 0), function()
					Configuration.TriggerbotDeb = false

                    if (Mouse.Target.Parent ~= player.Character) then
                        return
                    end

                    if ((IsTeammate(player)) and (Configuration.Aimbot_Teammates)) or (not IsTeammate(player)) then
                        mouse1click()
                    end
				end)
			end
		end
	end

	--//

	if ((Configuration["Aimbot_Enabled"])) and (Configuration["AssistAim"]) then
		local closestPlayer = GetClosestPlayer(Configuration.AssistFOV)
		local hitbox = ((closestPlayer) and (closestPlayer.Character) and (closestPlayer.Character:FindFirstChild("Head")))

		if (hitbox) then
			CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(CFrame.new(CurrentCamera.CFrame.Position, hitbox.Position), (Configuration.Smoothness / 10))
		end
	end
end)

--//

pcall(function()
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local callingscript = getcallingscript()

        local args = {...}

        if (not checkcaller()) then
            if (method == "Kick") then
                return
            elseif (method == "FireServer") then
				if ((self.Name == "ReplicateCameraUDP") and (Configuration["LagSpectators"])) then
					args[1] = Configuration.SpectatorCFrame
				end
            elseif ((method == "SetPrimaryPartCFrame") and (Configuration.Viewmodel_Enabled) and (self.Name:lower() == "arms")) then
                args[1] *= CFrame.new(Vector3.new(math.rad(Configuration.Viewmodel_X - 180), math.rad(Configuration.Viewmodel_Y - 180), math.rad(Configuration.Viewmodel_Z - 180))) * CFrame.Angles(0, 0, math.rad(Configuration.Viewmodel_Roll - 180))
            end
        end

        return oldNamecall(self, unpack(args))
    end)
end)

--//End
