local ply = FindMetaTable("Player")

local teams = {}

teams[0] = {name = "citizen", color = Vector( 0, 1, 0 ), weapons = {"rp_fists"} }
teams[1] = {name = "Police", color = Vector( 0, 0, 1.0 ), weapons = {"weapon_crowbar", "weapon_pistol"} }
teams[2] = {name = "Mayor", color = Vector( 1, 0, 0 ), weapons = {"weapon_pistol"} }

function ply:SetGamemodeTeam( n )
	if not teams[n] then return end
	
	self:SetTeam( n )
	
	self:SetPlayerColor( teams[n].color )
	
	self:GiveGamemodeWeapons()
	
	return true
end

function ply:GiveGamemodeWeapons()
	local n = self:Team()
	self:StripWeapons()
	
	for k, wep in pairs(teams[n].weapons) do
		self:Give(wep)
	end
end