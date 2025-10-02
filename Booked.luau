--> Original Values Provided!
--> DO NOT CHANGE THEM

-- Made with love for Mimi<3

local debugPrints = true --> Disable when checked, only for devs)

local Z_Box = 7
local X_Box = 7

--> Y is for TOP (center)

--> SLPN
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local antiCheatRemote = ReplicatedStorage:WaitForChild("SharedEvents"):WaitForChild("Soccer"):WaitForChild("AntiCheat")

local function main()
    local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local callingscript = getcallingscript()

        local args = {...}

        if (not checkcaller()) then
            if (method == "Kick") then
                return
            elseif (method == "FireServer") then
                if (self.Name == antiCheatRemote.Name) then
                    args = {}

                    if (debugPrints) then
                        print("ReloadAnimations")
                    end
                end
            end
        end

        return oldNamecall(self, unpack(args))
    end)
end

pcall(main)

task.wait(1)

--//

local originalValues = { --> DO NOT CHANGE THAT. KEEP THEM FOR BETTER CONFIGURATION
    ["Default"] = {
        ["Offset"] = CFrame.new(0, -2, 0),
        ["Size"] = Vector3.new(4.5, 2, 4.5)
    },

    ["BehindLegs"] = {
        ["Offset"] = CFrame.new(0, -2, 1.25),
        ["Size"] = Vector3.new(4, 1.9, 2.25)
    },

    ["InFrontOfLegs"] = {
        ["Offset"] = CFrame.new(0, -2, -1.25),
        ["Size"] = Vector3.new(4, 1.9, 2.25)
    },

    ["GK"] = {
        ["Offset"] = CFrame.new(0, 1, -0.8),
        ["Size"] = Vector3.new(4, 5.7, 2.4)
    },

    ["LowBlockLeft"] = {
        ["Offset"] = CFrame.new(-2, 0, -0.8),
        ["Size"] = Vector3.new(6, 5.7, 2.4)
    },

    ["LowBlockRight"] = {
        ["Offset"] = CFrame.new(2, 0, -0.8),
        ["Size"] = Vector3.new(6, 5.7, 2.4)
    },

    ["Maradona"] = {
        ["Offset"] = CFrame.new(0, 1, -0.8),
        ["Size"] = Vector3.new(4, 5.7, 2.4)
    },

    ["TorsoCatch"] = {
        ["Offset"] = CFrame.new(0, 0.5, 0),
        ["Size"] = Vector3.new(4, 4, 2.25)
    },

    ["Slide"] = {
        ["Offset"] = CFrame.new(0, -2, -0.7),
        ["Size"] = Vector3.new(2.5, 2, 3)
    },

    ["Head"] = {
        ["Offset"] = CFrame.new(0, 1.7, -0.7),
        ["Size"] = Vector3.new(3, 3, 3)
    },

    ["Przewrotka"] = {
        ["Offset"] = CFrame.new(0, 2, -0.7),
        ["Size"] = Vector3.new(4, 6, 7)
    },

    ["CaptureBall"] = {
        ["Offset"] = CFrame.new(0, -1.2, 0),
        ["Size"] = Vector3.new(4.5, 4.2, 4.5)
    }
}

--//

local hitBox = require(game:GetService("ReplicatedStorage").SharedModules.Hitbox.HitboxPresets)

local box = { --> CHANGE FOR CONFIG (THEM)
    ["Default"] = {
        ["Offset"] = CFrame.new(0, -2, 0),
        ["Size"] = Vector3.new(X_Box, 2, Z_Box) --> 4.5, 2, 4.5
    },

    ["BehindLegs"] = {
        ["Offset"] = CFrame.new(0, -2, 1.25),
        ["Size"] = Vector3.new(X_Box, 1.9, Z_Box) --> 4, 1.9, 2.25
    },

    ["InFrontOfLegs"] = {
        ["Offset"] = CFrame.new(0, -2, -1.25),
        ["Size"] = Vector3.new(X_Box, 1.9, Z_Box) --> 4, 1.9, 2.25
    },

    ["GK"] = {
        ["Offset"] = CFrame.new(0, 1, -0.8),
        ["Size"] = Vector3.new(X_Box, 5.7, Z_Box) --> 4, 5.7, 2.4
    },

    ["LowBlockLeft"] = {
        ["Offset"] = CFrame.new(-2, 0, -0.8),
        ["Size"] = Vector3.new(X_Box, 5.7, Z_Box) --> 6, 5.7, 2.4
    },

    ["LowBlockRight"] = {
        ["Offset"] = CFrame.new(2, 0, -0.8),
        ["Size"] = Vector3.new(X_Box, 5.7, Z_Box) --> 6, 5.7, 2.4
    },

    ["Maradona"] = {
        ["Offset"] = CFrame.new(0, 1, -0.8),
        ["Size"] = Vector3.new(X_Box, 5.7, Z_Box) --> 4, 5.7, 2.4
    },

    ["TorsoCatch"] = {
        ["Offset"] = CFrame.new(0, 0.5, 0),
        ["Size"] = Vector3.new(X_Box, 4, Z_Box) --> 4, 4, 2.25
    },

    ["Slide"] = {
        ["Offset"] = CFrame.new(0, -2, -0.7),
        ["Size"] = Vector3.new(2.5, 2, 3) --> 2.5, 2, 3
    },

    ["Head"] = {
        ["Offset"] = CFrame.new(0, 1.7, -0.7),
        ["Size"] = Vector3.new(3, 3, 3) --> 3, 3, 3
    },

    ["Przewrotka"] = {
        ["Offset"] = CFrame.new(0, 2, -0.7),
        ["Size"] = Vector3.new(4, 6, 7) --> 4, 6, 7
    },

    ["CaptureBall"] = {
        ["Offset"] = CFrame.new(0, -1.2, 0),
        ["Size"] = Vector3.new(4.5, 4.2, 4.5) --> 4.5, 4.2, 4.5
    }
}

for name : string, _ in pairs(hitBox) do
	local found = box[name]

	if (found) then
		hitBox[name] = found

		if (debugPrints) then
			print("ReloadAnimations")
		end
	end
end

--//End

-->>>>>>>>>>>> CHECK UP AND MIDDLE
