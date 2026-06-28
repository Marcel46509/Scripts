--> Wiemy że to widzicie chłopaki :3 <333

--// Locals

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local sharedModules : Folder = ReplicatedStorage.SharedModules
local lightingDetailsUpdater : RemoteEvent = ReplicatedStorage:WaitForChild("LightingDetailsUpdater")

--// Main

if (not _G.Loaded) then
    _G.Loaded = true

    --// Anti-Cheat

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
                        for _, reportData in ipairs(reports) do
                            warn("[🟥] Possible Detection:", reportData.Category, ",", reportData.Description)
                        end
                    end

                    args[2] = {}

                    if (_G.DebugPrints) then
                        print("Spoofed report!")
                    end
                end
            end
        end

        return oldNamecall(self, unpack(args))
    end)

    --// Hitboxes

	local hitBox = require(sharedModules.Hitbox)
	local oldFunc = hitBox.new

	hitBox.new = function(...)
		local newOld = oldFunc(...)

		newOld.Size = Vector3.new(
            (newOld.Size.X + _G.HitboxSize.X),
            (newOld.Size.Y + _G.HitboxSize.Y),
            (newOld.Size.Z + _G.HitboxSize.X)
        )

        if (_G.DebugPrints) then
            print(newOld.Size.X, newOld.Size.Y, newOld.Size.Z)
        end

		return newOld
	end
end
