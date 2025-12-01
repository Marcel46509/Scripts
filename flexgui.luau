--[[==================================================================
    FLEX GUI | SIMPLE
    Converted UI (Improved Readability)
    @marcel
====================================================================]]

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local Mouse = LocalPlayer:GetMouse()

local CurrentCamera = workspace.CurrentCamera

local parentChildren = PlayerGui
local G2L = {}

if (not RunService:IsStudio()) then
	if (not gethui) then
		LocalPlayer:Kick("Exploit not supported, gethui()!")
		return
	else
		parentChildren = gethui()
	end

	if (not writefile) then
		LocalPlayer:Kick("Exploit not supported, writefile()!")
		return
	end
end

local connections = {}

local options = {
	["visibleCheck"] = false,
	["teamCheck"] = false,
	["aimMode"] = true, -- Assist (true or 1) | AimLock (false or 2)
	["smoothness"] = 0.5,
	["fov"] = 85,
	["esp"] = false,
	["skipAssistHold"] = false,
	["lockBind"] = Enum.KeyCode.E,
	["lockPlayer"] = nil,
	["menuBind"] = Enum.KeyCode.Insert,
	["saveBind"] = Enum.KeyCode.Home,
	["deleteBind"] = Enum.KeyCode.J
}

local function addConnection(rbxScriptConnection : RBXScriptConnection)
	table.insert(connections, rbxScriptConnection)
end

local function removeConnections()
	for _, rbxScriptConnection : RBXScriptConnection in ipairs(connections) do
		rbxScriptConnection:Disconnect()
	end

	table.clear(connections)
end

local espFolder = Instance.new("Folder")
espFolder.Name = ""
espFolder.Parent = parentChildren

G2L["random"] = espFolder

--//

local function saveConfig()
	writefile("flexgui.cfg", HttpService:JSONEncode(options))
end

local function loadConfig()
	xpcall(function()
		for name : string, value : any in HttpService:JSONDecode(readfile("flexgui.cfg")) do
			if (options[name] ~= nil) then
				options[name] = value
			end
		end
	end, function(message : string)
		if (isfile("flexgui.cfg")) then
			delfile("flexgui.cfg")
		end

		warn(message)
	end)
end

if (not RunService:IsStudio()) then
	if (not isfile("flexgui.cfg")) then
		saveConfig()
	else
		loadConfig()
	end
end

----------------------------------------------------------------
-- ScreenGui
----------------------------------------------------------------
local Gui = Instance.new("ScreenGui")
Gui.Name = "Gui"
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = parentChildren
G2L["1"] = Gui

----------------------------------------------------------------
-- Main Frame (Top Bar)
----------------------------------------------------------------
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 260, 0, 27)
Main.Position = UDim2.new(0.2123, 0, 0.25059, 0)
Main.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Main.LayoutOrder = 9999
Main.BackgroundTransparency = 0.1
Main.BorderSizePixel = 0
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.Parent = Gui
G2L["2"] = Main

-- Main UICorner
local MainUICorner = Instance.new("UICorner")
MainUICorner.CornerRadius = UDim.new(0, 4)
MainUICorner.Parent = Main
G2L["a"] = MainUICorner

Main.Draggable = true
Main.Selectable = true
Main.Active = true

--[[
-- Drag detector (this shit doesn't work on rbx menu)
local DragDetector = Instance.new("UIDragDetector")
DragDetector.Parent = Main
G2L["5"] = DragDetector
--]]

----------------------------------------------------------------
-- Title Label
----------------------------------------------------------------
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Label"
TitleLabel.Text = "FLEX GUI | SIMPLE"
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextScaled = true
TitleLabel.TextWrapped = true
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.TextTransparency = 0.01
TitleLabel.TextSize = 14
TitleLabel.FontFace =
	Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
TitleLabel.Parent = Main
G2L["3"] = TitleLabel

-- Title UIPadding (values preserved)
local TitlePadding = Instance.new("UIPadding")
TitlePadding.PaddingTop = UDim.new(0.9, 0)
TitlePadding.PaddingRight = UDim.new(0.97, 0)
TitlePadding.PaddingLeft = UDim.new(0.97, 0)
TitlePadding.PaddingBottom = UDim.new(0.9, 0)
TitlePadding.Parent = TitleLabel
G2L["4"] = TitlePadding

----------------------------------------------------------------
-- Close Button
----------------------------------------------------------------
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "Close"
CloseBtn.Text = "X"
CloseBtn.TextSize = 14
CloseBtn.TextScaled = true
CloseBtn.TextWrapped = true
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundTransparency = 1
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BorderSizePixel = 0
CloseBtn.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
CloseBtn.AnchorPoint = Vector2.new(1, 0.5)
CloseBtn.Size = UDim2.new(0.09615, 0, 1, 0)
CloseBtn.Position = UDim2.new(1, 0, 0.5, 0)
CloseBtn.Parent = Main
G2L["6"] = CloseBtn

local ClosePadding = Instance.new("UIPadding")
ClosePadding.PaddingTop = UDim.new(0.8, 0)
ClosePadding.PaddingRight = UDim.new(0.8, 0)
ClosePadding.PaddingLeft = UDim.new(0.8, 0)
ClosePadding.PaddingBottom = UDim.new(0.8, 0)
ClosePadding.Parent = CloseBtn
G2L["7"] = ClosePadding

----------------------------------------------------------------
-- Minimize Button
----------------------------------------------------------------
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "Minimize"
MinimizeBtn.Text = "_"
MinimizeBtn.TextSize = 14
MinimizeBtn.TextScaled = true
MinimizeBtn.TextWrapped = true
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
MinimizeBtn.AnchorPoint = Vector2.new(1, 0.5)
MinimizeBtn.Size = UDim2.new(0.09615, 0, 0.8, 0)
MinimizeBtn.Position = UDim2.new(0.90385, 0, 0.5, 0)
MinimizeBtn.Parent = Main
G2L["8"] = MinimizeBtn

local MinimizePadding = Instance.new("UIPadding")
MinimizePadding.PaddingTop = UDim.new(0.8, 0)
MinimizePadding.PaddingRight = UDim.new(0.8, 0)
MinimizePadding.PaddingLeft = UDim.new(0.8, 0)
MinimizePadding.PaddingBottom = UDim.new(0.8, 0)
MinimizePadding.Parent = MinimizeBtn
G2L["9"] = MinimizePadding

----------------------------------------------------------------
-- Group (CanvasGroup background)
----------------------------------------------------------------
local Group = Instance.new("CanvasGroup")
Group.Name = "Group"
Group.Size = UDim2.new(1, 0, 10.37, 0)
Group.Position = UDim2.new(0, 0, 0.93, 0)
Group.BackgroundTransparency = 1
Group.Parent = Main
G2L["b"] = Group

----------------------------------------------------------------
-- List Frame inside Group
----------------------------------------------------------------
local List = Instance.new("Frame")
List.Name = "List"
List.Size = UDim2.new(1, 0, 1, 0)
List.BackgroundTransparency = 1
List.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
List.BackgroundTransparency = 0.3
List.BorderColor3 = Color3.fromRGB(0, 0, 0)
List.BorderSizePixel = 0
List.Parent = Group
G2L["d"] = List

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 4)
ListCorner.Parent = List
G2L["c"] = ListCorner

local ListLayout = Instance.new("UIListLayout")
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.Padding = UDim.new(0, 3)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = List
G2L["e"] = ListLayout

----------------------------------------------------------------
-- Mode Label + Toggle
----------------------------------------------------------------
local Mode = Instance.new("TextLabel")
Mode.Name = "aimMode"
Mode.Text = "Aim Mode: 1 (Assist)"
Mode.TextSize = 14
Mode.TextScaled = true
Mode.TextWrapped = true
Mode.TextTransparency = 0.01
Mode.TextXAlignment = Enum.TextXAlignment.Left
Mode.BackgroundTransparency = 1
Mode.TextColor3 = Color3.fromRGB(255, 255, 255)
Mode.FontFace =
	Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
Mode.Size = UDim2.new(0.95, 0, 0.09153, 0)
Mode.LayoutOrder = -1
Mode.Parent = List
G2L["f"] = Mode

local ModePadding = Instance.new("UIPadding")
ModePadding.PaddingTop = UDim.new(0.93, 0)
ModePadding.PaddingRight = UDim.new(1, 0)
ModePadding.PaddingLeft = UDim.new(1, 0)
ModePadding.PaddingBottom = UDim.new(0.93, 0)
ModePadding.Parent = Mode
G2L["10"] = ModePadding

local ModeToggle = Instance.new("TextButton")
ModeToggle.Name = "Toggle"
ModeToggle.Text = ""
ModeToggle.TextTransparency = 1
ModeToggle.TextSize = 14
ModeToggle.BackgroundTransparency = 1
ModeToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ModeToggle.BorderSizePixel = 0
ModeToggle.Size = UDim2.new(1, 0, 1, 0)
ModeToggle.Parent = Mode
G2L["11"] = ModeToggle

----------------------------------------------------------------
-- VisibleCheck Label + Toggle
----------------------------------------------------------------
local VisibleCheck = Instance.new("TextLabel")
VisibleCheck.Name = "visibleCheck"
VisibleCheck.Text = `Visible Check: {tostring(options.visibleCheck)}`
VisibleCheck.TextSize = 14
VisibleCheck.TextScaled = true
VisibleCheck.TextWrapped = true
VisibleCheck.TextTransparency = 0.01
VisibleCheck.TextXAlignment = Enum.TextXAlignment.Left
VisibleCheck.BackgroundTransparency = 1
VisibleCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
VisibleCheck.FontFace =
	Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
VisibleCheck.Size = UDim2.new(0.95, 0, 0.09153, 0)
VisibleCheck.Position = UDim2.new(0, 0, 0.10847, 0)
VisibleCheck.Parent = List
G2L["12"] = VisibleCheck

local VisiblePadding = Instance.new("UIPadding")
VisiblePadding.PaddingTop = UDim.new(0.93, 0)
VisiblePadding.PaddingRight = UDim.new(1, 0)
VisiblePadding.PaddingLeft = UDim.new(1, 0)
VisiblePadding.PaddingBottom = UDim.new(0.93, 0)
VisiblePadding.Parent = VisibleCheck
G2L["13"] = VisiblePadding

local VisibleToggle = Instance.new("TextButton")
VisibleToggle.Name = "Toggle"
VisibleToggle.Text = ""
VisibleToggle.TextTransparency = 1
VisibleToggle.TextSize = 14
VisibleToggle.BackgroundTransparency = 1
VisibleToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
VisibleToggle.BorderSizePixel = 0
VisibleToggle.Size = UDim2.new(1, 0, 1, 0)
VisibleToggle.Parent = VisibleCheck
G2L["14"] = VisibleToggle

--//

local TeamCheck = Instance.new("TextLabel")
TeamCheck.Name = "teamCheck"
TeamCheck.Text = `Team Check: {tostring(options.teamCheck)}`
TeamCheck.TextSize = 14
TeamCheck.TextScaled = true
TeamCheck.TextWrapped = true
TeamCheck.TextTransparency = 0.01
TeamCheck.TextXAlignment = Enum.TextXAlignment.Left
TeamCheck.BackgroundTransparency = 1
TeamCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
TeamCheck.FontFace =
	Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
TeamCheck.Size = UDim2.new(0.95, 0, 0.09153, 0)
TeamCheck.Position = UDim2.new(0, 0, 0.10847, 0)
TeamCheck.Parent = List
G2L["453534"] = TeamCheck

local TeamPadding = Instance.new("UIPadding")
TeamPadding.PaddingTop = UDim.new(0.93, 0)
TeamPadding.PaddingRight = UDim.new(1, 0)
TeamPadding.PaddingLeft = UDim.new(1, 0)
TeamPadding.PaddingBottom = UDim.new(0.93, 0)
TeamPadding.Parent = TeamCheck
G2L["4535345"] = TeamPadding

local TeamToggle = Instance.new("TextButton")
TeamToggle.Name = "Toggle"
TeamToggle.Text = ""
TeamToggle.TextTransparency = 1
TeamToggle.TextSize = 14
TeamToggle.BackgroundTransparency = 1
TeamToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeamToggle.BorderSizePixel = 0
TeamToggle.Size = UDim2.new(1, 0, 1, 0)
TeamToggle.Parent = TeamCheck
G2L["45353443"] = TeamToggle

----------------------------------------------------------------
-- Separator Line 1
----------------------------------------------------------------
local Line1 = Instance.new("Frame")
Line1.Name = "Line"
Line1.Size = UDim2.new(1, 0, 0.005, 0)
Line1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line1.BackgroundTransparency = 0.9
Line1.BorderSizePixel = 0
Line1.Parent = List
G2L["15"] = Line1

----------------------------------------------------------------
-- FovBox (Frame) with TextBox and Label
----------------------------------------------------------------
local FovBox = Instance.new("Frame")
FovBox.Name = "FovBox"
FovBox.Size = UDim2.new(0.95, 0, 0.092, 0)
FovBox.BackgroundTransparency = 1
FovBox.BorderSizePixel = 0
FovBox.Parent = List
G2L["16"] = FovBox

-- Fov TextBox (Box)
local FovBoxBox = Instance.new("TextBox")
FovBoxBox.Name = "fov"
FovBoxBox.Text = ""
FovBoxBox.PlaceholderText = options.fov
FovBoxBox.CursorPosition = -1
FovBoxBox.ClearTextOnFocus = false
FovBoxBox.TextSize = 14
FovBoxBox.TextScaled = true
FovBoxBox.TextWrapped = true
FovBoxBox.TextTransparency = 0.01
FovBoxBox.TextColor3 = Color3.fromRGB(255, 255, 255)
FovBoxBox.TextXAlignment = Enum.TextXAlignment.Left
FovBoxBox.BackgroundTransparency = 1
FovBoxBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FovBoxBox.BorderSizePixel = 0
FovBoxBox.FontFace =
	Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
FovBoxBox.Size = UDim2.new(0.87814, 0, 1, 0)
FovBoxBox.Position = UDim2.new(0.14818, 0, 0, 0)
FovBoxBox.Parent = FovBox
G2L["17"] = FovBoxBox

local FovBoxBoxPadding = Instance.new("UIPadding")
FovBoxBoxPadding.PaddingTop = UDim.new(0.93, 0)
FovBoxBoxPadding.PaddingRight = UDim.new(0.97, 0)
FovBoxBoxPadding.PaddingLeft = UDim.new(0.97, 0)
FovBoxBoxPadding.PaddingBottom = UDim.new(0.93, 0)
FovBoxBoxPadding.Parent = FovBoxBox
G2L["18"] = FovBoxBoxPadding

-- Fov Label
local FovLabel = Instance.new("TextLabel")
FovLabel.Name = "Label"
FovLabel.Text = "Fov:"
FovLabel.TextSize = 14
FovLabel.TextScaled = true
FovLabel.TextWrapped = true
FovLabel.TextTransparency = 0.01
FovLabel.TextXAlignment = Enum.TextXAlignment.Left
FovLabel.BackgroundTransparency = 1
FovLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FovLabel.FontFace =
	Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
FovLabel.Size = UDim2.new(0.14413, 0, 1, 0)
FovLabel.Position = UDim2.new(0, 0, 0, 0)
FovLabel.LayoutOrder = -1
FovLabel.Parent = FovBox
G2L["19"] = FovLabel

local FovLabelPadding = Instance.new("UIPadding")
FovLabelPadding.PaddingTop = UDim.new(0.93, 0)
FovLabelPadding.PaddingRight = UDim.new(1, 0)
FovLabelPadding.PaddingLeft = UDim.new(1, 0)
FovLabelPadding.PaddingBottom = UDim.new(0.93, 0)
FovLabelPadding.Parent = FovLabel
G2L["1a"] = FovLabelPadding

-- FovBox layout (horizontal)
local FovBoxLayout = Instance.new("UIListLayout")
FovBoxLayout.SortOrder = Enum.SortOrder.LayoutOrder
FovBoxLayout.FillDirection = Enum.FillDirection.Horizontal
FovBoxLayout.Parent = FovBox
G2L["1b"] = FovBoxLayout

----------------------------------------------------------------
-- SmoothnessBox (Frame) with TextBox and Label
----------------------------------------------------------------
local SmoothnessBox = Instance.new("Frame")
SmoothnessBox.Name = "SmoothnessBox"
SmoothnessBox.Size = UDim2.new(0.95, 0, 0.092, 0)
SmoothnessBox.BackgroundTransparency = 1
SmoothnessBox.BorderSizePixel = 0
SmoothnessBox.Parent = List
G2L["1c"] = SmoothnessBox

-- Smoothness TextBox (Box)
local SmoothBoxBox = Instance.new("TextBox")
SmoothBoxBox.Name = "smoothness"
SmoothBoxBox.Text = ""
SmoothBoxBox.PlaceholderText = options.smoothness
SmoothBoxBox.CursorPosition = -1
SmoothBoxBox.ClearTextOnFocus = false
SmoothBoxBox.TextSize = 14
SmoothBoxBox.TextScaled = true
SmoothBoxBox.TextWrapped = true
SmoothBoxBox.TextTransparency = 0.01
SmoothBoxBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SmoothBoxBox.TextXAlignment = Enum.TextXAlignment.Left
SmoothBoxBox.BackgroundTransparency = 1
SmoothBoxBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SmoothBoxBox.BorderSizePixel = 0
SmoothBoxBox.FontFace =
	Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
SmoothBoxBox.Size = UDim2.new(0.60709, 0, 1, 0)
SmoothBoxBox.Position = UDim2.new(0.41923, 0, 0, 0)
SmoothBoxBox.Parent = SmoothnessBox
G2L["1d"] = SmoothBoxBox

local SmoothBoxBoxPadding = Instance.new("UIPadding")
SmoothBoxBoxPadding.PaddingTop = UDim.new(0.93, 0)
SmoothBoxBoxPadding.PaddingRight = UDim.new(0.97, 0)
SmoothBoxBoxPadding.PaddingLeft = UDim.new(0.97, 0)
SmoothBoxBoxPadding.PaddingBottom = UDim.new(0.93, 0)
SmoothBoxBoxPadding.Parent = SmoothBoxBox
G2L["1e"] = SmoothBoxBoxPadding

-- Smoothness Label
local SmoothLabel = Instance.new("TextLabel")
SmoothLabel.Name = "Label"
SmoothLabel.Text = "Smoothness:"
SmoothLabel.TextSize = 14
SmoothLabel.TextScaled = true
SmoothLabel.TextWrapped = true
SmoothLabel.TextTransparency = 0.01
SmoothLabel.TextXAlignment = Enum.TextXAlignment.Left
SmoothLabel.BackgroundTransparency = 1
SmoothLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SmoothLabel.FontFace =
	Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
SmoothLabel.Size = UDim2.new(0.41923, 0, 1, 0)
SmoothLabel.Position = UDim2.new(0, 0, 0.10847, 0)
SmoothLabel.LayoutOrder = -1
SmoothLabel.Parent = SmoothnessBox
G2L["1f"] = SmoothLabel

local SmoothLabelPadding = Instance.new("UIPadding")
SmoothLabelPadding.PaddingTop = UDim.new(0.93, 0)
SmoothLabelPadding.PaddingRight = UDim.new(1, 0)
SmoothLabelPadding.PaddingLeft = UDim.new(1, 0)
SmoothLabelPadding.PaddingBottom = UDim.new(0.93, 0)
SmoothLabelPadding.Parent = SmoothLabel
G2L["20"] = SmoothLabelPadding

-- Smoothness horizontal layout
local SmoothLayout = Instance.new("UIListLayout")
SmoothLayout.SortOrder = Enum.SortOrder.LayoutOrder
SmoothLayout.FillDirection = Enum.FillDirection.Horizontal
SmoothLayout.Parent = SmoothnessBox
G2L["21"] = SmoothLayout

----------------------------------------------------------------
-- Separator Line 2 (original had duplicate 'Line' entry at index 22)
----------------------------------------------------------------
local Line2 = Instance.new("Frame")
Line2.Name = "Line"
Line2.Size = UDim2.new(1, 0, 0.005, 0)
Line2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line2.BackgroundTransparency = 0.9
Line2.BorderSizePixel = 0
Line2.Parent = List
G2L["22"] = Line2

----------------------------------------------------------------
-- VisibleCheck Label + Toggle
----------------------------------------------------------------
local ESP = Instance.new("TextLabel")
ESP.Name = "esp"
ESP.Text = `ESP: {tostring(options.esp)}`
ESP.TextSize = 14
ESP.TextScaled = true
ESP.TextWrapped = true
ESP.TextTransparency = 0.01
ESP.TextXAlignment = Enum.TextXAlignment.Left
ESP.BackgroundTransparency = 1
ESP.TextColor3 = Color3.fromRGB(255, 255, 255)
ESP.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
ESP.Size = UDim2.new(0.95, 0, 0.09153, 0)
ESP.Position = UDim2.new(0, 0, 0.10847, 0)
ESP.Parent = List
G2L["45"] = ESP

local ESPPadding = Instance.new("UIPadding")
ESPPadding.PaddingTop = UDim.new(0.93, 0)
ESPPadding.PaddingRight = UDim.new(1, 0)
ESPPadding.PaddingLeft = UDim.new(1, 0)
ESPPadding.PaddingBottom = UDim.new(0.93, 0)
ESPPadding.Parent = ESP
G2L["55"] = ESPPadding

local ESPToggle = Instance.new("TextButton")
ESPToggle.Name = "Toggle"
ESPToggle.Text = ""
ESPToggle.TextTransparency = 1
ESPToggle.TextSize = 14
ESPToggle.BackgroundTransparency = 1
ESPToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ESPToggle.BorderSizePixel = 0
ESPToggle.Size = UDim2.new(1, 0, 1, 0)
ESPToggle.Parent = ESP
G2L["66"] = ESPToggle

--// Scripts

local TweenService = game:GetService("TweenService")

local oldPosition = List.Position
local minimize = false

local Smooth1 = TweenInfo.new(1, Enum.EasingStyle.Exponential)

--//

local function isVisible(position : Vector3, ignoreList : { any }) : boolean
	local head : BasePart = (LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("Head")))

	return (head and (#CurrentCamera:GetPartsObscuringTarget({ head.Position, position }, ignoreList) == 0))
end

local function isTeammate(player : Player)
	return (player.TeamColor == LocalPlayer.TeamColor)
end

local function isAlive(player : Player)
	local humanoid : Humanoid = (player.Character and (player.Character:FindFirstChildOfClass("Humanoid")))
	return (humanoid and (humanoid.Health > 0))
end

local function getClosestPlayer(FOV : number)
	local closestPlayer = nil

	for _, player : Player in ipairs(Players:GetPlayers()) do
		if (player == LocalPlayer) then
			continue
		end

		if (not isAlive(player)) then
			continue
		end

		if (options.teamCheck) then
			if (isTeammate(player)) then
				continue
			end
		end

		local head : BasePart = (player.Character and (player.Character:FindFirstChild("Head")))
		if (not head) then
			continue
		end

		if (options.visibleCheck) then
			if (not isVisible(head.Position, { player.Character, LocalPlayer.Character, CurrentCamera })) then
				continue
			end
		end

		local viewportPoint, isOnScreen = CurrentCamera:WorldToViewportPoint(head.Position)

		if (isOnScreen) then
			local screenPosition = Vector2.new(viewportPoint.X, viewportPoint.Y)
			local distance : number = (UserInputService:GetMouseLocation() - screenPosition).Magnitude

			if (distance < FOV) then
				closestPlayer = player
				FOV = distance
			end
		end
	end

	return closestPlayer, FOV
end

--//

local function toggleText(textLabel : TextLabel, toggle : boolean, textToggle : string?, textToggle2 : string?)
	textLabel.Text = textLabel.Text:split(":")[1].. ": "

	if ((toggle) and (textToggle)) then
		toggle = textToggle
	elseif (textToggle2) then
		toggle = textToggle2
	end

	textLabel.Text = textLabel.Text.. tostring(toggle)
end

local function handleToggle(
	button : TextButton | ImageButton,
	textLabel : TextLabel,
	toggle : boolean?,
	textToggle : string?,
	textToggle2 : string?,
	callBack : (toggle : boolean) -> ()?
)
	toggleText(textLabel, toggle, textToggle, textToggle2)

	addConnection(button.MouseButton1Click:Connect(function()
		toggle = (not toggle)
		toggleText(textLabel, toggle, textToggle, textToggle2)

		options[textLabel.Name] = toggle

		if (callBack) then
			callBack(toggle)
		end
	end))
end

local function handleNumber(textBox : TextBox)
	addConnection(textBox:GetPropertyChangedSignal("Text"):Connect(function()
		local number = tonumber(textBox.Text)

		if (number) then
			options[textBox.Name] = number
		else
			options[textBox.Name] = tonumber(textBox.PlaceholderText)
			textBox.Text = ""
		end
	end))
end

--//

addConnection(CloseBtn.MouseButton1Click:Connect(function() --> Bye
	removeConnections()

	for _, ins : Instance in next, G2L do
		if (ins) then
			ins:Destroy()
		end
	end
end))

addConnection(MinimizeBtn.MouseButton1Click:Connect(function()
	minimize = (not minimize)

	if (minimize) then
		TweenService:Create(List, Smooth1, { Position = UDim2.fromScale(0, -1) }):Play()
	else
		TweenService:Create(List, Smooth1, { Position = oldPosition }):Play()
	end
end))

--// values and toggles

handleToggle(ESPToggle, ESP, options.esp)
handleToggle(VisibleToggle, VisibleCheck, options.visibleCheck)

handleToggle(ModeToggle, Mode, options.aimMode, "1 (Assist)", "2 (AimLock)", function(toggle : boolean)
	SmoothnessBox.Visible = toggle
end)

handleToggle(TeamToggle, TeamCheck, options.teamCheck)

handleNumber(SmoothBoxBox)
handleNumber(FovBoxBox)

--//

addConnection(UserInputService.InputBegan:Connect(function(input : InputObject, gameProcessedEvent : boolean)
	if (gameProcessedEvent) then
		return
	end

	if ((not options.aimMode) and (input.KeyCode == options.lockBind)) then
		if (options.lockPlayer) then
			options.lockPlayer = nil
		else
			options.lockPlayer = getClosestPlayer(options.fov)
		end
	elseif (input.KeyCode == options.menuBind) then
		Main.Visible = not Main.Visible
	elseif (input.KeyCode == options.saveBind) then
		saveConfig()
	elseif (input.KeyCode == options.deleteBind) then
		if (Mouse.Target) then
			Mouse.Target:Destroy()
		end
	end
end))

addConnection(RunService.RenderStepped:Connect(function()
	espFolder:ClearAllChildren()

	if (options.esp) then
		for _, player : Player in ipairs(Players:GetPlayers()) do
			if (player == LocalPlayer) then
				continue
			end

			if (not player.Character) then
				continue
			end

			if ((not options.teamCheck) or (not isTeammate(player))) then
				local highLight : Highlight = Instance.new("Highlight")
				highLight.Name = player.DisplayName
				highLight.FillTransparency = 1
				highLight.OutlineTransparency = 0.25
				highLight.OutlineColor = player.TeamColor.Color
				highLight.Adornee = player.Character
				highLight.Parent = espFolder
			end
		end
	end

	if ((options.aimMode) and (UserInputService:IsKeyDown(options.lockBind) or options.skipAssistHold)) then
		local closestPlayer = getClosestPlayer(options.fov)
		local head : BasePart = (
			(closestPlayer and closestPlayer.Character) and (closestPlayer.Character:FindFirstChild("Head"))
		)

		if (head) then
			CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(CFrame.new(CurrentCamera.CFrame.Position, head.Position), options.smoothness)
		end
	elseif (options.lockPlayer) then
		if (not isAlive(options.lockPlayer)) then
			options.lockPlayer = nil

			return
		end

		local head : BasePart = options.lockPlayer.Character:FindFirstChild("Head")

		if (head) then
			CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, head.Position)
		else
			options.lockPlayer = nil
		end
	end
end))

return options
