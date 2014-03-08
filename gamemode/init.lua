AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "vgui/create_user.lua" )
 
include( "shared.lua" )
include("sv_config.lua")
include( "libs/sv_database.lua" )
include( "vgui/create_user.lua" )

function GM:PlayerSpawn( ply )
    self.BaseClass:PlayerSpawn( ply )   
 
    ply:SetGravity  ( 1 )  
    ply:SetMaxHealth( 100, true )  
 
    ply:SetWalkSpeed( 190 )  
    ply:SetRunSpeed ( 235 ) 
 
end

function GM:PlayerLoadout( ply )
	
end

function GM:PlayerInitialSpawn( ply )
	   ply:PrintMessage( HUD_PRINTTALK, "Welcome, " .. ply:Name() .. "!" )
end
