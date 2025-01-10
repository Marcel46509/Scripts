--//Locals
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local library = (script:FindFirstChild("Lib") and require(script.Lib)) or (loadstring(game:HttpGet("https://raw.githubusercontent.com/Marcel46509/Scripts/refs/heads/main/Apple-Library.luau"))())
local window = library:init("SLPN", true, Enum.KeyCode.Insert, true)

local WalkSpeedBind = false
local WalkSpeed = game.StarterPlayer.CharacterWalkSpeed

local Auto_TPBall = false
local Binded_Ball = false
local Binded_HitBox = false
local Ball_Studs = 1

local OldHitBox

--//Functions

local function Notify(Text1 : string, Text2 : string)
	window:TempNotify(Text1, Text2, "rbxassetid://12608259004")
end

--//Main

local function GetBall(skipStudCheck : boolean)	
	for _,v : Instance in next, game:GetService("Workspace").EngineWorkspace.Balls:GetChildren() do
		if (v:IsA("BasePart")) then
			local Studs = (LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
			
			if (not skipStudCheck) then
				if (Ball_Studs < Studs) then
					continue
				end
			end
			
			if (not OldHitBox) then
				OldHitBox = v.Size
			end
			
			--//
			
			return v
		end
	end
	
	--//
	
	return false
end

local function TPBall()
	local Ball = GetBall()
	if (Ball) then
		Ball.Position = LocalPlayer.Character.HumanoidRootPart.Position
	end
end

--//Scripts

window:GreenButton(function()
	
end)

--//

window:Divider("Engine Components")

local mainSection = window:Section("Main")

mainSection:Divider("Ball")

mainSection:Button("Teleport Ball", function()
	TPBall()
end)

mainSection:Switch("Auto Teleport Ball", false, function(a)
	Auto_TPBall = a
end)

mainSection:Switch("Binded Ball Teleport [E]", false, function(a)
	Binded_Ball = a
end)

mainSection:TextField("Ball Magnitude", "Enter [magnitude] here...", function(a)
	Ball_Studs = (tonumber(a) or 0)
end)

mainSection:Switch("Binded Ball HitBox [F4]", false, function(a)
	Binded_HitBox = a
end)

--//

window:Divider("Client")

local miscSection = window:Section("Misc")

miscSection:Divider("LocalPlayer")

miscSection:Switch("WalkSpeed Enabled", false, function(a)
	WalkSpeedBind = a
end)

miscSection:TextField("WalkSpeed", "Enter [number] here...", function(a)
	WalkSpeed = ((tonumber(a)) or (game.StarterPlayer.CharacterWalkSpeed))
end)

miscSection:Divider("Rage")

miscSection:Button("Teleport to all Players [Fling Required]", function()
	local Character = LocalPlayer.Character
	for _,v in next, Players:GetPlayers() do
		if (v.Character) then
			Character:PivotTo(v.Character:GetPivot())
			
			task.wait(0.2)
			
			Character:PivotTo(v.Character:GetPivot())
			
			task.wait(0.35)
		end
	end
end)

--// Handlers \\--

UserInputService.InputBegan:Connect(function(inp, GPE)
	if (GPE) then return end
	--//
	if (miscSection) then
		if (Binded_Ball) then
			if (inp.KeyCode == Enum.KeyCode.E) then
				TPBall()
			end
		end
		--//
		if (Binded_HitBox) then
			if (inp.KeyCode == Enum.KeyCode.F4) then
				local Pilka = GetBall(true)
				if (Pilka) then
					if (Pilka.Size ~= OldHitBox) then
						Pilka.Size = OldHitBox
					else
						Pilka.Size = (OldHitBox * 2)
					end
				end
			end
		end
	end
end)

task.defer(function()
	while task.wait(0.1) do
		if (not miscSection) then
			break
		end
		
		--//
		
		if (Auto_TPBall) then
			TPBall()
		end
		
		--//
		
		if (WalkSpeedBind) then
			local Humanoid = ((LocalPlayer.Character) and (LocalPlayer.Character:FindFirstChildOfClass("Humanoid")))
			if (Humanoid) then
				Humanoid.WalkSpeed = WalkSpeed
			end
		end
	end
end)

--//End
mainSection:Select()
