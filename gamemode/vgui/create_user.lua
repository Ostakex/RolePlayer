local function characterCreation()

	local currentModel = 1
	local models={
	"models/player/group01/male_01.mdl",
	"models/player/group01/male_02.mdl",
	"models/player/group01/male_03.mdl",
	"models/player/group01/male_04.mdl",
	"models/player/group01/male_05.mdl",
	"models/player/group01/male_06.mdl",
	"models/player/group01/male_07.mdl",
	"models/player/group01/male_08.mdl",
	"models/player/group01/male_09.mdl",
	"models/player/group01/female_01.mdl",
	"models/player/group01/female_02.mdl",
	"models/player/group01/female_03.mdl",
	"models/player/group01/female_04.mdl",
	"models/player/group01/female_05.mdl",
	"models/player/group01/female_06.mdl"
	} 


	local x, y = ScrW() * .3, ScrH() * .5;
	local createFrame = vgui.Create("DFrame")
	createFrame:SetTitle("")
	createFrame:SetSize( x, y)
	createFrame:Center()
	createFrame:MakePopup()
	createFrame:SetBackgroundBlur( true )
	createFrame:ShowCloseButton( false )
	createFrame:SetDraggable(false)
	createFrame.Paint = function()
		draw.RoundedBox( 8, 0, 0, createFrame:GetWide(), createFrame:GetTall(), Color( 255, 255, 255, 180 ) )
	end

	local modelPanel = vgui.Create("DModelPanel", createFrame)
	modelPanel:SetSize(x * 0.5, y * 0.5)
	modelPanel:SetPos(x * 0.25, y * 0.1)
	modelPanel:SetFOV(45)
	modelPanel:SetLookAt( Vector( 0,0,50 ) )
	modelPanel:SetModel( models[currentModel] )	
	function modelPanel:LayoutEntity( ent )
		ent:SetAngles( Angle( 0, 45, 0 ) );
	end

	local SubmitButton = vgui.Create("DButton", createFrame)
	SubmitButton:SetPos(x * 0.60, y * 0.65 )
	SubmitButton:SetSize(x * 0.15, 20)
	SubmitButton:SetText(">")
	function SubmitButton:DoClick ( )
		if currentModel == table.Count(models) then 
			currentModel = 1
		else 
			currentModel = currentModel + 1
		end		
		modelPanel:SetModel(models[currentModel])	
	end

	local SubmitButton = vgui.Create("DButton", createFrame)
	SubmitButton:SetPos(x * 0.25, y * 0.65 )
	SubmitButton:SetSize(x * 0.15, 20)
	SubmitButton:SetText("<")
	function SubmitButton:DoClick ( )
		if currentModel == 1 then 
			currentModel = table.Count(models)
		else 
			currentModel = currentModel - 1
		end		
		modelPanel:SetModel(models[currentModel])	
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
	SubmitButton:SetSize(x * .5, 20)
	SubmitButton:SetPos(x * 0.25, y * 0.95 )
	SubmitButton:SetText("Create")
	SubmitButton:SetDisabled(false)

	function SubmitButton:DoClick ( )
		local selectedModel = models[currentModel]
		local selectedFirstName = textboxFirst:GetValue()
		local selectedLastName = textboxLast:GetValue()
		createFrame:Close()
		RunConsoleCommand("rp_register", selectedModel, selectedFirstName, selectedLastName)
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
	ruleFrame.Paint = function()
	draw.RoundedBox( 8, 0, 0, ruleFrame:GetWide(), ruleFrame:GetTall(), Color( 255, 255, 255, 180 ) )
	end

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
