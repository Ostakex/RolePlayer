//Add Net Messages


// Include the shared init file.
include( "shared.lua" )

// Include the server files.
include("sv_config.lua")
include("libs/sv_teamswitch.lua")
include("libs/sv_database.lua")

// Add client lua resources.
AddCSLuaFile( "cl_init.lua" )

for k, v in pairs(file.Find("roleplayer/gamemode/vgui/*.lua","LUA")) do AddCSLuaFile("vgui/" .. v); end

AddCSLuaFile( "shared.lua" )

function GM:PlayerSpawn( ply )
    self.BaseClass:PlayerSpawn( ply )   
 
    ply:SetGravity  ( 1 )  
    ply:SetMaxHealth( 100, true )  
 
    ply:SetWalkSpeed( 190 )  
    ply:SetRunSpeed ( 235 )  
    ply:SetGamemodeTeam(0)  
end

function GM:PlayerLoadout( ply )
	
end

function GM:PlayerInitialSpawn( ply )
end
