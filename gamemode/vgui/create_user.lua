
local function characterCreation()

	local x, y = ScrW() * .5, ScrH() * .5;
	local createFrame = vgui.Create("DFrame")
	createFrame:SetTitle("Create your character")
	createFrame:SetSize( x, y)
	createFrame:Center()
	createFrame:MakePopup()
	createFrame:SetBackgroundBlur( true )
	createFrame:ShowCloseButton( false )
	createFrame:SetDraggable(false)

	local icon = vgui.Create("DModelPanel", createFrame)
	icon:SetSize(x * 0.5, y * 0.5)
	icon:SetPos(x * 0.55, y * 0.1)
	icon:SetFOV()
	icon:SetLookAt( Vector( 0,0,35 ) )
	icon:SetModel( LocalPlayer():GetModel() )	
	function icon:LayoutEntity( ent )
		ent:SetAngles( Angle( 0, 45, 0 ) );
	end

	local textboxFirst = vgui.Create("DTextEntry", createFrame)
	textboxFirst:SetSize(x * .5, 30) 
	textboxFirst:SetPos(x * 0.25, y * 0.75 )
	textboxFirst:SetText("First Name")

	local textboxLast = vgui.Create("DTextEntry", createFrame)
	textboxLast:SetSize(x * .5, 30) 
	textboxLast:SetPos(x * 0.25, y * 0.85 )
	textboxLast:SetText("Last Name")

	local SubmitButton = vgui.Create("DButton", createFrame)
	SubmitButton:SetPos(x * 0.25, y * 0.95 )
	SubmitButton:SetSize(x * .5, 20)
	SubmitButton:SetText("Create")
	SubmitButton:SetDisabled(false)

	function SubmitButton:DoClick ( )
		createFrame:Remove();
	end

	concommand.Add( "remove",function( )
		createFrame:Close()
	end )

end
concommand.Add("add", characterCreation);



local function initspawnmenu()

	local W, H = ScrW() * .75, ScrH() * .85;
	local ruleFrame = vgui.Create( "DFrame" )
	ruleFrame:SetTitle( "Rules" )
	ruleFrame:SetSize( W, H)
	ruleFrame:Center()
	ruleFrame:SetBackgroundBlur( true )
	ruleFrame:MakePopup()
	ruleFrame:ShowCloseButton( false )
	ruleFrame:SetDraggable(false)

	local htmlRules = vgui.Create( "HTML", ruleFrame )
	htmlRules:SetPos( 25, 50 )
	htmlRules:SetSize( ruleFrame:GetWide() - 50, ruleFrame:GetTall() - 100 )
	htmlRules:OpenURL( "http://perpheads.com/rules" )

	local SubmitButton = vgui.Create("DButton", ruleFrame)
	SubmitButton:SetPos(10 + (W * .5 - 7.5), H - 25)
	SubmitButton:SetSize(W * .5 - 7.5, 20)
	SubmitButton:SetText("I Agree ( 10 Seconds )")
	SubmitButton:SetDisabled(false)
	
	/*timer.Simple(1, function ( ) SubmitButton:SetText("I Agree ( 9 Seconds )") end)
	timer.Simple(2, function ( ) SubmitButton:SetText("I Agree ( 8 Seconds )") end)
	timer.Simple(3, function ( ) SubmitButton:SetText("I Agree ( 7 Seconds )") end)
	timer.Simple(4, function ( ) SubmitButton:SetText("I Agree ( 6 Seconds )") end)
	timer.Simple(5, function ( ) SubmitButton:SetText("I Agree ( 5 Seconds )") end)
	timer.Simple(6, function ( ) SubmitButton:SetText("I Agree ( 4 Seconds )") end)
	timer.Simple(7, function ( ) SubmitButton:SetText("I Agree ( 3 Seconds )") end)
	timer.Simple(8, function ( ) SubmitButton:SetText("I Agree ( 2 Seconds )") end)
	timer.Simple(9, function ( ) SubmitButton:SetText("I Agree ( 1 Seconds )") end)
	timer.Simple(10, function ( ) SubmitButton:SetText("I Agree") SubmitButton:SetDisabled(false) end)*/

	function SubmitButton:DoClick ( )
		ruleFrame:Remove();
		characterCreation()
	end

	local SubmitButton = vgui.Create("DButton", ruleFrame);
	SubmitButton:SetPos(5, H - 25)
	SubmitButton:SetSize(W * .5 - 7.5, 20)
	SubmitButton:SetText("I Disagree")
	
	function SubmitButton:DoClick ( )
		RunConsoleCommand('disconnect')
	end

end
usermessage.Hook("rp_newchar", initspawnmenu)
