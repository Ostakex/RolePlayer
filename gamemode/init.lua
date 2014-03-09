//Add Net Messages


// Include the shared init file.
include( "shared.lua" )

// Include the server files.
include("sv_config.lua")
include("libs/sv_teamswitch.lua")
include("libs/sv_database.lua")

// Add client lua resources.
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
for k, v in pairs(file.Find("roleplayer/gamemode/shared/*.lua","LUA")) do AddCSLuaFile("shared/" .. v); end
for k, v in pairs(file.Find("roleplayer/gamemode/vgui/*.lua","LUA")) do AddCSLuaFile("vgui/" .. v); end


function GM:PlayerSpawn( ply )
    self.BaseClass:PlayerSpawn( ply )   
 
    ply:SetGravity  ( 1 )  
    ply:SetMaxHealth( 100, true )  
 
    ply:SetWalkSpeed( 190 )  
    ply:SetRunSpeed ( 235 )  
    ply:SetGamemodeTeam(0)  

    getPlayerStats( ply )

    local oldhands = ply:GetHands()
	if ( IsValid( oldhands ) ) then oldhands:Remove() end

	local hands = ents.Create( "gmod_hands" )
	if ( IsValid( hands ) ) then
		ply:SetHands( hands )
		hands:SetOwner( ply )

		-- Which hands should we use?
		local cl_playermodel = ply:GetInfo( "cl_playermodel" )
		local info = player_manager.TranslatePlayerHands( cl_playermodel )
		if ( info ) then
			hands:SetModel( info.model )
			hands:SetSkin( info.skin )
			hands:SetBodyGroups( info.body )
		end

		-- Attach them to the viewmodel
		local vm = ply:GetViewModel( 0 )
		hands:AttachToViewmodel( vm )

		vm:DeleteOnRemove( hands )
		ply:DeleteOnRemove( hands )

		hands:Spawn()
	end
end

function GM:PlayerLoadout( ply )
	
end

function GM:PlayerInitialSpawn( ply )
end


hook.Add( "PlayerNoClip", "FeelFreeToTurnItOff", function( ply, desiredState )
	if ( desiredState == false ) then -- the player wants to turn noclip off
		return true -- always allow
	elseif ( ply:IsAdmin() ) then
		return true -- allow administrators to enter noclip
	end
end )
