
AddCSLuaFile()

SWEP.PrintName			= "Fists"

SWEP.Author			= ""
SWEP.Purpose		= "Punch people till they die"

SWEP.Spawnable			= true
SWEP.UseHands			= true
SWEP.DrawAmmo			= false

SWEP.ViewModel			= "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel			= ""

SWEP.ViewModelFOV		= 52
SWEP.Slot				= 2
SWEP.SlotPos			= 0

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= ""

local SwingSound = Sound( "weapons/slam/throw.wav" )
local HitSound = Sound( "Flesh.ImpactHard" )

function SWEP:Initialize()

	self:SetWeaponHoldType( "fist" )

end

function SWEP:PreDrawViewModel( vm, wep, ply )

	vm:SetMaterial( "engine/occlusionproxy" ) -- Hide that view model with hacky material

end

SWEP.HitDistance = 48
function SWEP:PrimaryAttack( right )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( !IsFirstTimePredicted() ) then return end

	-- We need this because attack sequences won't work otherwise in multiplayer
	local vm = self.Owner:GetViewModel()
	vm:ResetSequence( vm:LookupSequence( "fists_idle_01" ) )

	local anim = "fists_left"
	if ( right ) then anim = "fists_right" end
	if ( math.random( 1, 10 ) == 1 ) then anim = "fists_uppercut" end

	timer.Simple( 0, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
	
		local vm = self.Owner:GetViewModel()
		vm:ResetSequence( vm:LookupSequence( anim ) )

		self:Idle()
	end )

	timer.Simple( 0.05, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		if ( anim == "fists_left" ) then
			self.Owner:ViewPunch( Angle( 0, 10, 0 ) )
		elseif ( anim == "fists_right" ) then
			self.Owner:ViewPunch( Angle( 0, -10, 0 ) )
		elseif ( anim == "fists_uppercut" ) then
			self.Owner:ViewPunch( Angle( 10, -5, 0 ) )
		end
	end )

	timer.Simple( 0.2, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		if ( anim == "fists_left" ) then
			self.Owner:ViewPunch( Angle( 2, -10, 0 ) )
		elseif ( anim == "fists_right" ) then
			self.Owner:ViewPunch( Angle( 2, 10, 0 ) )
		elseif ( anim == "fists_uppercut" ) then
			self.Owner:ViewPunch( Angle( -20, 0, 0 ) )
		end
		self.Owner:EmitSound( SwingSound )
		
	end )

	timer.Simple( 0.2, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self || CLIENT ) then return end
		self:DealDamage( anim )
	end )

	self:SetNextPrimaryFire( CurTime() + 0.9 )
	self:SetNextSecondaryFire( CurTime() + 0.9 )

end

function SWEP:SecondaryAttack()
	self:PrimaryAttack( true )
end

function SWEP:DealDamage( anim )
	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
		filter = self.Owner
	} )

	if ( !IsValid( tr.Entity ) ) then 
		tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
			filter = self.Owner,
			mins = Vector( -10, -10, -8 ),
			maxs = Vector( 10, 10, 8 )
		} )
	end

	if ( tr.Hit ) then self.Owner:EmitSound( HitSound ) end

	if ( IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then
		local dmginfo = DamageInfo()
		dmginfo:SetDamage( math.random( 8, 12 ) )
		if ( anim == "fists_left" ) then
			dmginfo:SetDamageForce( self.Owner:GetRight() * 49125 + self.Owner:GetForward() * 99984 ) -- Yes we need those specific numbers
		elseif ( anim == "fists_right" ) then
			dmginfo:SetDamageForce( self.Owner:GetRight() * -49124 + self.Owner:GetForward() * 99899 )
		elseif ( anim == "fists_uppercut" ) then
			dmginfo:SetDamageForce( self.Owner:GetUp() * 51589 + self.Owner:GetForward() * 100128 )
			dmginfo:SetDamage( math.random( 12, 24 ) )
		end
		dmginfo:SetInflictor( self )
		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )

		tr.Entity:TakeDamageInfo( dmginfo )
	end
end

function SWEP:Idle()

	local vm = self.Owner:GetViewModel()
	timer.Create( "fists_idle" .. self:EntIndex(), vm:SequenceDuration(), 1, function()
		vm:ResetSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) )
	end )

end

function SWEP:OnRemove()

	if ( IsValid( self.Owner ) ) then
		local vm = self.Owner:GetViewModel()
		if ( IsValid( vm ) ) then vm:SetMaterial( "" ) end
	end

	timer.Stop( "fists_idle" .. self:EntIndex() )

end

function SWEP:Holster( wep )

	self:OnRemove()

	return true
end

function SWEP:Deploy()

	local vm = self.Owner:GetViewModel()
	vm:ResetSequence( vm:LookupSequence( "fists_draw" ) )

	self:Idle()

	return true

end
