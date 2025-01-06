--// SETTINGS //
local ColorOnClick = Color3.new(0.976471, 0.631373, 1)
local ColorOnEnd = Color3.new(0.176471, 0.145098, 0.184314)
local FontColor = Color3.new(1, 0.670588, 0.941176)

local BorderSizePixel = 0

local TextSize = 25
local TextTransparency = 0.05
local TextBorderTransparency = 0.9
local Font = "Highway"

local BgTransparency = 0.35

local GUI_POSITION = UDim2.new(0.02, 0,0.07, 0)
local GUI_SIZE = UDim2.new(0, 176,0, 144)
local GUI_PARENT = nil
local GUI_NAME = "KeyStrokes"

--// PARENT CHECKS //

_, Success = pcall(function()
	GUI_PARENT = game.CoreGui
end)
if (not Success) then
	GUI_PARENT = game.Players.LocalPlayer.PlayerGui
end

--// MAIN CHECKS //

local oldGui = GUI_PARENT:FindFirstChild(GUI_NAME) --> Destroy's old gui
if (oldGui) then
	oldGui:Destroy()
end

--// MAIN //

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local W = Instance.new("TextLabel")
local S = Instance.new("TextLabel")
local A = Instance.new("TextLabel")
local D = Instance.new("TextLabel")
local LMB = Instance.new("TextLabel")
local RMB = Instance.new("TextLabel")
local Space = Instance.new("TextLabel")

ScreenGui.Name = GUI_NAME
ScreenGui.Parent = GUI_PARENT
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ScreenGui.ResetOnSpawn = false

Frame.Name = "Main"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.Position = GUI_POSITION
Frame.Size = GUI_SIZE

W.Name = "W"
W.Parent = Frame
W.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
W.BorderColor3 = Color3.fromRGB(27, 42, 53)
W.Position = UDim2.new(0.391, 0,0, 0)
W.Size = UDim2.new(0.217, 0,0.266, 0)
W.Font = Enum.Font.Arial
W.Text = "W"
W.TextColor3 = Color3.fromRGB(0, 0, 0)
W.TextSize = 14.000

S.Name = "S"
S.Parent = Frame
S.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
S.Position = UDim2.new(0.391, 0,0.306, 0)
S.Size = UDim2.new(0.217, 0,0.266, 0)
S.Font = Enum.Font.Arial
S.Text = "S"
S.TextColor3 = Color3.fromRGB(0, 0, 0)
S.TextSize = 14.000

A.Name = "A"
A.Parent = Frame
A.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
A.Position = UDim2.new(0.143, 0,0.306, 0)
A.Size = UDim2.new(0.217, 0,0.266, 0)
A.Font = Enum.Font.Arial
A.Text = "A"
A.TextColor3 = Color3.fromRGB(0, 0, 0)
A.TextSize = 14.000

D.Name = "D"
D.Parent = Frame
D.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
D.Position = UDim2.new(0.639, 0,0.306, 0)
D.Size = UDim2.new(0.217, 0,0.266, 0)
D.Font = Enum.Font.Arial
D.Text = "D"
D.TextColor3 = Color3.fromRGB(0, 0, 0)
D.TextSize = 14.000

LMB.Name = "LMB"
LMB.Parent = Frame
LMB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LMB.Position = UDim2.new(0.143, 0,0.609, 0)
LMB.Size = UDim2.new(0.339, 0,0.197, 0)
LMB.Font = Enum.Font.Arial
LMB.Text = "LMB"
LMB.TextColor3 = Color3.fromRGB(0, 0, 0)
LMB.TextSize = 14.000

RMB.Name = "RMB"
RMB.Parent = Frame
RMB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RMB.Position = UDim2.new(0.517, 0,0.609, 0)
RMB.Size = UDim2.new(0.339, 0,0.197, 0)
RMB.Font = Enum.Font.Arial
RMB.Text = "RMB"
RMB.TextColor3 = Color3.fromRGB(0, 0, 0)
RMB.TextSize = 14.000

Space.Name = "Space"
Space.Parent = Frame
Space.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Space.Position = UDim2.new(0.142, 0,0.848, 0)
Space.Size = UDim2.new(0.713, 0,0.112, 0)
Space.Font = Enum.Font.SourceSans
Space.Text = "_____"
Space.TextColor3 = Color3.fromRGB(0, 0, 0)
Space.TextScaled = true
Space.TextSize = 14.000
Space.TextWrapped = true

--// SCRIPTS //

local function YXGDBCV_fake_script() -- Frame.LocalScript 
	local script = Instance.new('LocalScript', Frame)
	
	local Keye = script.Parent
	local A = game:GetService("UserInputService")
	Keye.W.BackgroundColor3 = ColorOnEnd			
	Keye.S.BackgroundColor3 = ColorOnEnd
	Keye.A.BackgroundColor3 = ColorOnEnd
	Keye.D.BackgroundColor3 = ColorOnEnd
	Keye.Space.BackgroundColor3 = ColorOnEnd	
	Keye.LMB.BackgroundColor3 = ColorOnEnd	
	Keye.RMB.BackgroundColor3 = ColorOnEnd

	for i,v in next, Keye:GetChildren() do
		if (v:IsA("TextLabel")) then
			v.BorderSizePixel = BorderSizePixel
			v.TextTransparency = TextTransparency
			v.TextStrokeTransparency = TextBorderTransparency
			
			if (v.Name ~= "Space") then
				v.TextSize = TextSize
				v.Font = Font
			end
			
			v.BackgroundTransparency = BgTransparency
			v.TextColor3 = FontColor
		end
	end

	A.InputBegan:Connect(function(Input,UserInput)
		if Input.KeyCode == Enum.KeyCode.W then
			Keye.W.BackgroundColor3 = ColorOnClick			
		end
		if Input.KeyCode == Enum.KeyCode.S then
			Keye.S.BackgroundColor3 = ColorOnClick
		end
		if Input.KeyCode == Enum.KeyCode.A then
			Keye.A.BackgroundColor3 = ColorOnClick
		end
		if Input.KeyCode == Enum.KeyCode.D then
			Keye.D.BackgroundColor3 = ColorOnClick
		end
		if Input.KeyCode == Enum.KeyCode.Space then
			Keye.Space.BackgroundColor3 = ColorOnClick		
		end
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Keye.LMB.BackgroundColor3 = ColorOnClick			
		end
		if Input.UserInputType == Enum.UserInputType.MouseButton2 then
			Keye.RMB.BackgroundColor3 = ColorOnClick			
		end
	end)

	A.InputEnded:Connect(function(Input,UserInput)
		if Input.KeyCode == Enum.KeyCode.W then
			Keye.W.BackgroundColor3 = ColorOnEnd			
		end
		if Input.KeyCode == Enum.KeyCode.S then
			Keye.S.BackgroundColor3 = ColorOnEnd
		end
		if Input.KeyCode == Enum.KeyCode.A then
			Keye.A.BackgroundColor3 = ColorOnEnd
		end
		if Input.KeyCode == Enum.KeyCode.D then
			Keye.D.BackgroundColor3 = ColorOnEnd
		end	
		if Input.KeyCode == Enum.KeyCode.Space then
			Keye.Space.BackgroundColor3 = ColorOnEnd	
		end
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Keye.LMB.BackgroundColor3 = ColorOnEnd			
		end
		if Input.UserInputType == Enum.UserInputType.MouseButton2 then
			Keye.RMB.BackgroundColor3 = ColorOnEnd			
		end
	end)
end

coroutine.wrap(YXGDBCV_fake_script)()
