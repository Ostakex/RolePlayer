
local function characterCreation()
	local createFrame = vgui.Create("DFrame")
	createFrame:SetPos(10, 10)
	createFrame:SetSize( 200, 200)
	createFrame:ShowCloseButton( false )
	createFrame:SetDraggable(false)

	local icon = vgui.Create("DModelPanel", createFrame)
	icon:SetSize(200, 200)
	icon:SetModel( LocalPlayer():GetModel() )	
	function icon:LayoutEntity( ent )
		ent:SetAngles( Angle( 0, 45, 0 ) );
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
	SubmitButton:SetPos(5, H - 25)
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
		//characterCreation()
	end

	local SubmitButton = vgui.Create("DButton", ruleFrame);
	SubmitButton:SetPos(10 + (W * .5 - 7.5), H - 25)
	SubmitButton:SetSize(W * .5 - 7.5, 20)
	SubmitButton:SetText("I Disagree")
	
	function SubmitButton:DoClick ( )
		RunConsoleCommand('disconnect')
	end

end
usermessage.Hook("rp_newchar", initspawnmenu)
