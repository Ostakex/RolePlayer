local function HideHUD( name )
	if(name == "CHudHealth") or (name == "CHudBattery") then
        return false
    end
end

hook.Add( "HUDShouldDraw", "HideHUD", HideHUD )


rpHUD = { }

local function clr( color ) return color.r, color.g, color.b, color.a end

function rpHUD:PaintBar(x, y, w, h, colors, value)

	surface.SetDrawColor( clr( colors.border ))
	surface.DrawOutlinedRect( x, y, w, h)

	x = x + 1
	y = y + 1
	w = w - 2
	h = h - 2

	surface.SetDrawColor( clr( colors.background ) )
	surface.DrawRect( x, y, w, h )
 
	local width = w * math.Clamp( value, 0, 1 )
 
	surface.SetDrawColor( clr( colors.fill ) )
	surface.DrawRect( x, y, width, h )
 

end

function rpHUD:PaintText( x, y, text, font, colors )
 
	surface.SetFont( font )
 
	surface.SetTextPos( x + 1, y + 1 )
	surface.SetTextColor( clr( colors.shadow ) )
	surface.DrawText( text )
 
	surface.SetTextPos( x, y )
	surface.SetTextColor( clr( colors.text ) )
	surface.DrawText( text )
 
end

function rpHUD:TextSize( text, font )
 
	surface.SetFont( font )
	return surface.GetTextSize( text )
 
end

 
local vars =
{
 
	font = "TargetID",
 
	padding = 10,
	margin = 35,
 
	text_spacing = 2,
	bar_spacing = 5,
 
	bar_height = 16,
 
	width = 0.15
 
}

local colors =
{
 
	text =
	{
 
		shadow = Color( 0, 0, 0, 120 ),
		text = Color( 255, 255, 255, 255 )
 
	},
 
	health_bar =
	{
 
		border = Color( 0, 0, 0, 255 ),
		background = Color( 120, 27, 26, 150 ),
		fill = Color( 231, 25, 23, 220 )
 
	}
 
}

local function HUDPaint( )
 
	client = client or LocalPlayer( )
	if( !client:Alive() ) then return end
 
	local _, th = rpHUD:TextSize( "TEXT", vars.font )
 
	local i = 1
	local padding = -20
	local margin = 40
	local bar_height = 16
	local text = client:Health()
 
	local width = 0.15 * ScrW( )
	local bar_width = width - padding
	local height = padding
 
	local x = margin
	local y = ScrH( ) - margin - height
 
	local cx = x + padding;
	local cy = y + padding;
 
	local by = th + vars.text_spacing;
 	
 	if (text < 100) then
		rpHUD:PaintText( cx, cy, text, "TargetID", colors.text)
		rpHUD:PaintBar( cx, cy + by, bar_width, bar_height, colors.health_bar, client:Health() / 100 )
	end
 
 
end
hook.Add( "HUDPaint", "PaintOurHud", HUDPaint )