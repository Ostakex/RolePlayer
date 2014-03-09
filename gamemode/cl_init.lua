include( "shared.lua" )
for k, v in pairs(file.Find("roleplayer/gamemode/vgui/*.lua", "LUA")) do include("vgui/" .. v); end

function GM:PostDrawViewModel( vm, ply, weapon )

	if ( weapon.UseHands || !weapon:IsScripted() ) then

		local hands = LocalPlayer():GetHands()
		
		if ( IsValid( hands ) ) then hands:DrawModel() end

	end

end

