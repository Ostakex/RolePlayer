//Add Net Messages


// Include the shared init file.
include( "shared.lua" )

// Include the server files.
include("sv_config.lua")
include("player.lua")
include("libs/sv_database.lua")

// Add client lua resources.
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "vgui/create_user.lua" )
AddCSLuaFile( "vgui/cl_hud.lua" )

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
	umsg.Start("rp_newchar", ply);
	umsg.End();
end
