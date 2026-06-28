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
                        for _, reportData in next, reports do
                            warn("[🟥] Possible Detection:", reportData.Category, reportData.Description)
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

        local args = {...}
        local name = args[2]

        if (_G.DebugPrints) then
            print(name)
        end

        local newHitbox = ((_G.CustomHitboxSizes and _G.CustomHitboxSizes[name]) or _G.HitboxSize)

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
