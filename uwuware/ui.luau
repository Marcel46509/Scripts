--//Locals
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcel46509/Scripts/refs/heads/main/uwuware/library.luau'))()
local ESPLibrary = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcel46509/Scripts/refs/heads/main/uwuware/espLibrary.luau'))()

local Window = Library:CreateWindow("uwuware", Vector2.new(450, 552), Enum.KeyCode.Insert)
local Watermark = Library:CreateWatermark("uwuware | {fps}", Vector2.new(1400, -48))

local PinkieColor = Color3.fromRGB(253, 180, 255)

local Configuration = {}
local RunScripts = {
	["https://raw.githubusercontent.com/Marcel46509/Scripts/refs/heads/main/KeyStrokes.luau"] = "Key Strokes",
	["https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"] = "Infinite Yield"
}

local Theme = {
	fontsize = 15,
	titlesize = 18,
	font = Enum.Font.Code,
	background = "rbxassetid://5553946656",
	tilesize = 90,
	cursor = false,
	cursorimg = "https://t0.rbxcdn.com/42f66da98c40252ee151326a82aab51f",
	backgroundcolor = Color3.fromRGB(20, 20, 20),
	tabstextcolor = Color3.fromRGB(240, 240, 240),
	bordercolor = Color3.fromRGB(60, 60, 60),
	accentcolor = PinkieColor,
	accentcolor2 = Color3.fromRGB(16, 31, 78),
	outlinecolor = Color3.fromRGB(60, 60, 60),
	outlinecolor2 = Color3.fromRGB(0, 0, 0),
	sectorcolor = Color3.fromRGB(30, 30, 30),
	toptextcolor = Color3.fromRGB(255, 255, 255),
	topheight = 48,
	topcolor = Color3.fromRGB(30, 30, 30),
	topcolor2 = Color3.fromRGB(30, 30, 30),
	buttoncolor = Color3.fromRGB(49, 49, 49),
	buttoncolor2 = Color3.fromRGB(39, 39, 39),
	itemscolor = Color3.fromRGB(200, 200, 200),
	itemscolor2 = Color3.fromRGB(210, 210, 210)
}

--//Functions

--//Main

--//Scripts

Window:UpdateTheme(Theme)
Watermark:UpdateTheme(Theme)

Configuration.Color = PinkieColor

--//

task.delay(1, function()
	local Scripts = Window:CreateTab("Scripts")
	local ScriptsMain = Scripts:CreateSector("Scripts", "Left")

	ScriptsMain:AddDropdown("Script", RunScripts, "script", false, function(selected : string)
		Configuration.SelectedScript = selected
	end)

	ScriptsMain:AddButton("Run Script", function()
		for load : string, name : string in next, RunScripts do
			if (name == Configuration.SelectedScript) then
				loadstring(game:HttpGet(load))()
				break
			end
		end
	end)

	--//

	local Settings = Window:CreateTab("Settings")
	local Menu = Settings:CreateSector("Menu", "Left")

	Menu:AddKeybind("Open / Close", Library.hidebutton, function(newBind : boolean)
	    Library.hidebutton = newBind
	end)

	Menu:AddColorpicker("Theme Color", PinkieColor, function(color : Color3)
		Theme.accentcolor = color

		Window:UpdateTheme(Theme)
		Watermark:UpdateTheme(Theme)
	end)

	Menu:AddToggle("Watermark", true, function(toggle : boolean)
		Watermark.Visible = toggle
	end)

	xpcall(function()
		Settings:CreateConfigSystem("Right")
	end, warn)
end)

--//End

return Library, ESPLibrary, Window, Watermark, Configuration
