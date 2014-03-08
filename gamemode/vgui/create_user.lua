/*function showRules()
	local introForm = vgui.Create( "DFrame" )
	introForm:Center()
	introForm:SetSize( 300, 150 ) -- Size form
	introForm:SetTitle( "Welcome to GModRP" ) -- Form set name
	introForm:SetVisible( true ) -- Form rendered ( true or false )
	introForm:SetDraggable( false ) -- Form draggable
	introForm:ShowCloseButton( false ) -- Show buttons panel
	introForm:MakePopup()

	local MOTDFrame = vgui.Create( "DFrame" )
	MOTDFrame:SetTitle( "Message of The day" )
	MOTDFrame:SetSize( ScrW() - 100, ScrH() - 100 )
	MOTDFrame:Center()
	MOTDFrame:SetBackgroundBlur( true )
	MOTDFrame:MakePopup()
	 
	local MOTDHTMLFrame = vgui.Create( "HTML", MOTDFrame )
	MOTDHTMLFrame:SetPos( 25, 50 )
	MOTDHTMLFrame:SetSize( MOTDFrame:GetWide() - 50, MOTDFrame:GetTall() - 150 )
	MOTDHTMLFrame:OpenURL( "wiki.garrysmod.com" )
end
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawn", showRules )*/