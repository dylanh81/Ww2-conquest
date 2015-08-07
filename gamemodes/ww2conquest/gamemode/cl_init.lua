include( 'player.lua' )
include( "shared.lua" )
 
 function set_team() 
 
 frame = vgui.	Create( "DFrame" ) 
 frame:SetPos( 100, ScrH() / 2 ) //Set the window in the middle of the players screen/game window 
 frame:SetSize( 200, 210 ) //Set the size 
 frame:SetTitle( "Change Team" ) //Set title 
 frame:SetVisible( true ) 
 frame:SetDraggable( false ) 
 frame:ShowCloseButton( true ) 
 frame:MakePopup() 
 
 team_1 = vgui.Create( "DButton", frame ) 
 team_1:SetPos( 30, 30 )
 team_1:SetSize( 100, 50 ) 
 team_1:SetText( "Team 1" ) 
 team_1.DoClick = function() //Make the player join team 1 
 
     RunConsoleCommand( "team_1" ) 
 
 end 
 
 team_2 = vgui.Create( "DButton", frame ) 
 team_2:SetPos( 30, 85 ) //Place it next to our previous one 
 team_2:SetSize( 100, 50 ) 
 team_2:SetText( "Team 2" ) 
 team_2.DoClick = function() //Make the player join team 2 
 
     RunConsoleCommand( "team_2" ) 
 
 end 
 
 end 
 concommand.Add( "team_menu", set_team )

surface.CreateFont("HUDKill", {
    font = "Arial",
    size = 28,
    weight = 500
})

surface.CreateFont("HUDKillInfo", {
    font = "Arial",
    size = 20,
    weight = 500
})

function KillNotification()
    hs = net.ReadInt( 32 )
    color = Color( 255, 255, 0, 255 )
    duration = 3
    fade = 0.1
    local start = CurTime()

    local function drawToScreen()
        local alpha = 255
        local dtime = CurTime() - start

        if dtime > duration then
            hook.Remove( "HUDPaint", "KillNotification" )
            return
        end

        if fade - dtime > 0 then
            alpha = (fade - dtime) / fade
            alpha = 1 - alpha
            alpha = alpha * 255
        end

        if duration - dtime < fade then
            alpha = (duration - dtime) / fade
            alpha = alpha * 255
        end
        color.a  = alpha
        if hs == 1 then
            draw.DrawText( "+150", "HUDKill", ScrW() * 0.5, ScrH() * 0.25, color, TEXT_ALIGN_CENTER )
            draw.DrawText( "Headshot", "HUDKillInfo", ScrW() * 0.5 + 5, ScrH() * 0.25 + 36, color, TEXT_ALIGN_CENTER )
        else
            draw.DrawText( "+100", "HUDKill", ScrW() * 0.5, ( ScrH() * 0.25 ) - 74, color, TEXT_ALIGN_CENTER )
        end
    end

    hook.Add( "HUDPaint", "KillNotification", drawToScreen )
    
    if hs == 1 then
        LocalPlayer():addPoints( 150 )
    else
        LocalPlayer():addPoints( 100 )
    end
    
end
net.Receive( "tdm_killnotification", KillNotification )

function DrawPoints()
    draw.SimpleText( ( tostring( LocalPlayer():getPoints() ) or "0" ) .. " points", "HUDKill", 10, 10, color_white )
end
hook.Add( "HUDPaint", "DrawPoints", DrawPoints )