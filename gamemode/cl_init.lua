include( "shared.lua" )
for k, v in pairs(file.Find("roleplayer/gamemode/vgui/*.lua", "LUA")) do include("vgui/" .. v); end