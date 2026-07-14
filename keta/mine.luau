-- @marcel

local runService = game:GetService("RunService")
local isStudio = runService:IsStudio()

if (isStudio) then
	isfile = function(...)
		return
	end

	writefile = function(...)
		return
	end

	readfile = function(...)
		return
	end

	hookmetamethod = function(...)
		return
	end

	getcustomasset = function(...)
		return "rbxassetid://18820535797"
	end
end

-- Instances: 24 | Scripts: 0 | Modules: 0 | Tags: 0
-- StarterGui.UI

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local parentChildren = PlayerGui

local sharedModules : Folder = ReplicatedStorage.SharedModules
local lightingDetailsUpdater : RemoteEvent = ReplicatedStorage:WaitForChild("LightingDetailsUpdater")

local hitboxModule = require(sharedModules.Hitbox)
local hitboxConfig = require(sharedModules.Hitbox.Config)

local config = {}
local garbage = {}

local function addGarbage(item) --> Ultra pro garbage handler lol
	table.insert(garbage, item)

	return item
end

local function clearGarbage()
	for _, item in ipairs(garbage) do
		if (typeof(item) == "RBXScriptConnection") then
			item:Disconnect()
		else
			item:Destroy()
		end
	end

	table.clear(garbage)
end

local function loadConfig()
	if (isfile("ketamine.slut.cfg")) then
		xpcall(function()
			for name : string, value : any in HttpService:JSONDecode(readfile("ketamine.slut.cfg")) do
				if (config[name] ~= nil) then
					config[name] = value
				end
			end
		end, function(message : string)
			delfile("ketamine.slut.cfg")

			warn(message)
		end)
	end
end

local function saveConfig()
	writefile("ketamine.slut.cfg", HttpService:JSONEncode(config))
end

loadConfig()

if (not isStudio) then
	if (not writefile) then
		LocalPlayer:Kick("The shittest rblx exploit in the world 💀")
		return
	end

	if (not gethui) then
		LocalPlayer:Kick("Exploit not supported, gethui()!")
		return
	else
		parentChildren = gethui()
	end

	if (not hookmetamethod) then
		LocalPlayer:Kick("Exploit not supported, hookmetamethod()!")
		return
	end

	writefile("boykisser.png", game:HttpGet("https://raw.githubusercontent.com/Marcel46509/Scripts/refs/heads/main/keta/boykisserreal.png"))
end

_G.CustomHitboxes = {}

--//

local UI = addGarbage(Instance.new("ScreenGui"))
UI.IgnoreGuiInset = true
UI.ResetOnSpawn = false
UI.Name = "UI"
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UI.Parent = parentChildren

-- StarterGui.UI.Main
local Main = Instance.new("CanvasGroup", UI)
Main.BorderSizePixel = 0
Main.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
Main.Size = UDim2.new(0, 489, 0, 320)
Main.Position = UDim2.new(0.294, 0, 0.247, 0)
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.Name = "Main"

Main.Selectable = true
Main.Draggable = true
Main.Active = true

-- StarterGui.UI.Main.UICorner
local Object = Instance.new("UICorner", Main)
Object.CornerRadius = UDim.new(0, 11)


-- StarterGui.UI.Main.Top
local Top = Instance.new("CanvasGroup", Main)
Top.BorderSizePixel = 0
Top.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
Top.Size = UDim2.new(1, 0, 0.1, 0)
Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
Top.Name = "Top"


-- StarterGui.UI.Main.Top.Title
local Title = Instance.new("TextLabel", Top)
Title.TextWrapped = true
Title.BorderSizePixel = 0
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextScaled = true
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.AnchorPoint = Vector2.new(0, 0.5)
Title.Size = UDim2.new(0.39387, 0, 0.63, 0)
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.Text = "ketamine.slut"
Title.Name = "Title"
Title.Position = UDim2.new(0.02198, 0, 0.5, 0)


-- StarterGui.UI.Main.Top.Close
local Close = Instance.new("TextButton", Top)
Close.TextWrapped = true
Close.BorderSizePixel = 0
Close.TextSize = 19
Close.TextScaled = true
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Close.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
Close.BackgroundTransparency = 1
Close.Size = UDim2.new(0.06606, 0, 1, 0)
Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
Close.Text = "X"
Close.Name = "Close"
Close.Position = UDim2.new(0.93394, 0, 0, 0)


-- StarterGui.UI.Main.Top.Close.UIPadding
local Object_1 = Instance.new("UIPadding", Close)
Object_1.PaddingTop = UDim.new(0.81, 0)
Object_1.PaddingRight = UDim.new(0.81, 0)
Object_1.PaddingLeft = UDim.new(0.81, 0)
Object_1.PaddingBottom = UDim.new(0.81, 0)


-- StarterGui.UI.Main.Top.Hide
local Hide = Instance.new("TextButton", Top)
Hide.TextWrapped = true
Hide.BorderSizePixel = 0
Hide.TextSize = 14
Hide.TextScaled = true
Hide.TextColor3 = Color3.fromRGB(255, 255, 255)
Hide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Hide.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
Hide.BackgroundTransparency = 1
Hide.Size = UDim2.new(0.06606, 0, 1, 0)
Hide.BorderColor3 = Color3.fromRGB(0, 0, 0)
Hide.Text = "-"
Hide.Name = "Hide"
Hide.Position = UDim2.new(0.86787, 0, 0, 0)

local Save = Instance.new("TextButton", Top)
Save.TextWrapped = true
Save.BorderSizePixel = 0
Save.TextSize = 14
Save.TextScaled = true
Save.TextColor3 = Color3.fromRGB(255, 255, 255)
Save.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Save.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
Save.BackgroundTransparency = 1
Save.Size = UDim2.fromScale(0.082, 1)
Save.BorderColor3 = Color3.fromRGB(0, 0, 0)
Save.Text = "Save"
Save.Name = "Save"
Save.Position = UDim2.fromScale(0.785, 0)

-- StarterGui.UI.Main.Top.Logo
local Logo = Instance.new("ImageLabel", Top)
Logo.BorderSizePixel = 0
Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo.AnchorPoint = Vector2.new(0, 0.5)
Logo.Image = getcustomasset("boykisser.png")
Logo.Size = UDim2.new(0, 25, 0, 25)
Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
Logo.BackgroundTransparency = 1
Logo.Name = "Logo"
Logo.Position = UDim2.new(0.2863, 0, 0.5, 0)


-- StarterGui.UI.Main.List
local List = Instance.new("ScrollingFrame", Main)
List.BorderSizePixel = 0
List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
List.Size = UDim2.new(1, 0, 0.88125, 0)
List.CanvasSize = UDim2.new()
List.Position = UDim2.new(0, 0, 0.11875, 0)
List.BorderColor3 = Color3.fromRGB(0, 0, 0)
List.Name = "List"
List.TopImage = List.MidImage
List.BottomImage = List.MidImage
List.BackgroundTransparency = 1
List.ScrollBarThickness = 2
List.ScrollBarImageTransparency = 0.5


-- StarterGui.UI.Main.List.UIListLayout
local Object_10 = Instance.new("UIListLayout", List)
Object_10.SortOrder = Enum.SortOrder.LayoutOrder


--// end of creating an ui

local function handleTextbox(name : string, textBox : TextBox)
	addGarbage(textBox:GetPropertyChangedSignal("Text"):Connect(function()
		config[name][textBox.Name] = (tonumber(textBox.Text) or 0)

		local cfg = config[name]

		_G.CustomHitboxes[name] = Vector3.new(cfg.X, cfg.Y, cfg.Z)
	end))
end

local function addHitboxItem(name : string)
	if (not config[name]) then
		config[name] = {}
	end

	-- StarterGui.UI.Main.List.Hitbox
	local Hitbox = addGarbage(Instance.new("Frame", List))
	Hitbox.BorderSizePixel = 0
	Hitbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Hitbox.Size = UDim2.new(1, 0, 0.10005, 0)
	Hitbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Hitbox.Name = name
	Hitbox.BackgroundTransparency = 1

	-- StarterGui.UI.Main.List.Hitbox.Title
	local Title_1 = Instance.new("TextLabel", Hitbox)
	Title_1.TextWrapped = true
	Title_1.BorderSizePixel = 0
	Title_1.TextSize = 14
	Title_1.TextXAlignment = Enum.TextXAlignment.Left
	Title_1.TextScaled = true
	Title_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_1.BackgroundTransparency = 1
	Title_1.AnchorPoint = Vector2.new(0, 0.5)
	Title_1.Size = UDim2.new(0.78865, 0, 1, 0)
	Title_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title_1.Text = name
	Title_1.Name = "Title"
	Title_1.Position = UDim2.new(0, 0, 0.5, 0)


	-- StarterGui.UI.Main.List.Hitbox.Title.UIPadding
	local Object_2 = Instance.new("UIPadding", Title_1)
	Object_2.PaddingTop = UDim.new(0.83, 0)
	Object_2.PaddingRight = UDim.new(0.96, 0)
	Object_2.PaddingLeft = UDim.new(0.96, 0)
	Object_2.PaddingBottom = UDim.new(0.83, 0)


	-- StarterGui.UI.Main.List.Hitbox.X
	local X = Instance.new("TextBox", Hitbox)
	X.CursorPosition = -1
	X.Name = "X"
	X.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
	X.BorderSizePixel = 0
	X.TextWrapped = true
	X.TextSize = 14
	X.TextColor3 = Color3.fromRGB(255, 255, 255)
	X.TextScaled = true
	X.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
	X.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	X.AnchorPoint = Vector2.new(0, 0.5)
	X.ClearTextOnFocus = false
	X.PlaceholderText = "X"
	X.Size = UDim2.new(0.05457, 0, 0.95, 0)
	X.Position = UDim2.new(0.79765, 0, 0.475, 0)
	X.BorderColor3 = Color3.fromRGB(0, 0, 0)
	X.Text = (config[name].X or "")


	-- StarterGui.UI.Main.List.Hitbox.X.UICorner
	local Object_3 = Instance.new("UICorner", X)

	-- StarterGui.UI.Main.List.Hitbox.X.UIPadding
	local Object_4 = Instance.new("UIPadding", X)
	Object_4.PaddingTop = UDim.new(0.85, 0)
	Object_4.PaddingRight = UDim.new(0.85, 0)
	Object_4.PaddingLeft = UDim.new(0.85, 0)
	Object_4.PaddingBottom = UDim.new(0.85, 0)


	-- StarterGui.UI.Main.List.Hitbox.UIListLayout
	local Object_5 = Instance.new("UIListLayout", Hitbox)
	Object_5.Padding = UDim.new(0.009, 0)
	Object_5.SortOrder = Enum.SortOrder.LayoutOrder
	Object_5.FillDirection = Enum.FillDirection.Horizontal


	-- StarterGui.UI.Main.List.Hitbox.Y
	local Y = Instance.new("TextBox", Hitbox)
	Y.CursorPosition = -1
	Y.Name = "Y"
	Y.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
	Y.BorderSizePixel = 0
	Y.TextWrapped = true
	Y.TextSize = 14
	Y.TextColor3 = Color3.fromRGB(255, 255, 255)
	Y.TextScaled = true
	Y.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
	Y.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	Y.AnchorPoint = Vector2.new(0, 0.5)
	Y.ClearTextOnFocus = false
	Y.PlaceholderText = "Y"
	Y.Size = UDim2.new(0.05457, 0, 0.95, 0)
	Y.Position = UDim2.new(0.86113, 0, 0.475, 0)
	Y.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Y.Text = (config[name].Y or "")


	-- StarterGui.UI.Main.List.Hitbox.Y.UICorner
	local Object_6 = Instance.new("UICorner", Y)

	-- StarterGui.UI.Main.List.Hitbox.Y.UIPadding
	local Object_7 = Instance.new("UIPadding", Y)
	Object_7.PaddingTop = UDim.new(0.85, 0)
	Object_7.PaddingRight = UDim.new(0.85, 0)
	Object_7.PaddingLeft = UDim.new(0.85, 0)
	Object_7.PaddingBottom = UDim.new(0.85, 0)


	-- StarterGui.UI.Main.List.Hitbox.Z
	local Z = Instance.new("TextBox", Hitbox)
	Z.CursorPosition = -1
	Z.Name = "Z"
	Z.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
	Z.BorderSizePixel = 0
	Z.TextWrapped = true
	Z.TextSize = 14
	Z.TextColor3 = Color3.fromRGB(255, 255, 255)
	Z.TextScaled = true
	Z.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
	Z.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	Z.AnchorPoint = Vector2.new(0, 0.5)
	Z.ClearTextOnFocus = false
	Z.PlaceholderText = "Z"
	Z.Size = UDim2.new(0.05457, 0, 0.95, 0)
	Z.Position = UDim2.new(0.9246, 0, 0.475, 0)
	Z.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Z.Text = (config[name].Z or "")

	config[name] = {
		["X"] = 0,
		["Y"] = 0,
		["Z"] = 0
	}

	handleTextbox(name, X)
	handleTextbox(name, Y)
	handleTextbox(name, Z)

	-- StarterGui.UI.Main.List.Hitbox.Z.UICorner
	local Object_8 = Instance.new("UICorner", Z)

	-- StarterGui.UI.Main.List.Hitbox.Z.UIPadding
	local Object_9 = Instance.new("UIPadding", Z)
	Object_9.PaddingTop = UDim.new(0.85, 0)
	Object_9.PaddingRight = UDim.new(0.85, 0)
	Object_9.PaddingLeft = UDim.new(0.85, 0)
	Object_9.PaddingBottom = UDim.new(0.85, 0)
end

for hitboxName : string, _ in next, hitboxConfig do
	addHitboxItem(hitboxName)
end

Close.MouseButton1Click:Once(function()
	clearGarbage()

	table.clear(config)
end)

addGarbage(Hide.MouseButton1Click:Connect(function()
	Main.Visible = false
end))

addGarbage(Save.MouseButton1Click:Connect(saveConfig))

addGarbage(UserInputService.InputBegan:Connect(function(inp, gpe)
	if (gpe) then
		return
	end

	if (inp.KeyCode == Enum.KeyCode.Insert) then
		Main.Visible = (not Main.Visible)
	end
end))

if (not _G.Loaded) then
	_G.Loaded = true

	--// Spoof woof

	local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
		local method = getnamecallmethod()
		local callingscript = getcallingscript()

		local args = {...}

		if (not checkcaller()) then
			if (method == "Kick") then
				return
			elseif (method == "FireServer") then
				if (self.Name == lightingDetailsUpdater.Name) then
					local reports = args[2]

					if (reports and (reports ~= {})) then
						for _, reportData in next, reports do
							warn("[🟥] Possible Detection:", reportData.Category, reportData.Description)
						end
					end

					args[2] = {}

					if (_G.DebugPrints) then
						print("Spoofed report!")
					end
				elseif (self.Name == "AntiCheat") then
					if (args[2]) then
						warn("[🟥] Possible Detection:", args[2])
					end

					args = {}

					if (_G.DebugPrints) then
						print("Spoofed ac!")
					end
				end
			end
		end

		return oldNamecall(self, unpack(args))
	end)

	--// Yeye hitbox settin'

	local oldFunc = hitboxModule.new

	hitboxModule.new = function(...)
		local newOld = oldFunc(...)

		local args = {...}
		local name = args[2]

		if (_G.DebugPrints) then
			print(name)
		end

		local newHitbox = ((_G.CustomHitboxes and _G.CustomHitboxes[name]) or 0)

		newOld.Size = Vector3.new(
			(newOld.Size.X + newHitbox.X),
			(newOld.Size.Y + newHitbox.Y),
			(newOld.Size.Z + newHitbox.X)
		)

		if (_G.DebugPrints) then
			print(newOld.Size.X, newOld.Size.Y, newOld.Size.Z)
		end

		return newOld
	end
end

if (_G.DebugPrints) then
	print("[✅] Loaded!")
end
