-- required to have libdraw lib in addon folder
drawLib = LibStub("LibDraw-1.0")
drawLib.SetWidth(5)

-- libDraw checks for this global to be true (fh remnant)
HackEnabled = true

-- register draw function

local function getHealer()
	isArena, isRegistered = IsActiveBattlefieldArena()
	if not isArena then return end
	for i = 1, GetNumGroupMembers(), 1 do
		member = "party" .. i
		role = UnitGroupRolesAssigned(member)
		if role == "HEALER" then
			return member
		end
	end
	return nil
end

drawLib.Sync(function()
	healer = getHealer()
	if healer == nil then return end
    if UnitExists(healer) then
        local playerX, playerY, playerZ = ObjectPosition("player")
        local targetX, targetY, targetZ = ObjectPosition(healer)
		if TraceLine(playerX, playerY, playerZ + 5, targetX, targetY, targetZ + 5, 0x100111) == nil then
			drawLib.SetColorRaw(0, 1, 0, 1)
		else
			drawLib.SetColorRaw(1, 0, 0, 1)
		end
        drawLib.Line(playerX, playerY, playerZ, targetX, targetY, targetZ)
    end
end)
drawLib.Enable(0.01)



