AddCSLuaFile("shared.lua")

include("shared.lua")

function GM:PlayerConnect( name, ip )
	print("Player: " .. name .. ", has joined the game.")
end

function GM:PlayerInitialSpawn( ply )
	print("Player: " .. ply:Nick() .. ", has spawned.")
end

function GM:PlayerSpawn( ply )
end

function GM:PlayerAuthed( ply, steamID, uniqueID )
	print("Player: " .. ply:Nick() .. ", has gotten authed.")
end