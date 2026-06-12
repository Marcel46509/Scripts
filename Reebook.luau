--// Locals

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local sharedEvents : Folder = ReplicatedStorage.SharedEvents
local sharedModules : Folder = ReplicatedStorage.SharedModules

--// Main

if (not _G.Loaded) then
    _G.Loaded = true

    --// Anti-Cheat

    local antiCheatRemote : RemoteEvent = sharedEvents:WaitForChild("Soccer"):WaitForChild("AntiCheat")

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

                    if (_G.DebugPrints) then
                        print("Spoofed!")
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
