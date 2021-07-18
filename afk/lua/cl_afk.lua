include( "sh_afk_player.lua" )

surface.CreateFont( "AT_AFK", { font = "Roboto", size = 28 * 10, extended = true } )
hook.Add( "PostDrawTranslucentRenderables", "AT_AFK_Timer", function()
    for _, ply in pairs( player.GetAll() ) do
        if ( !IsValid( ply ) ) then continue end
        if ( !ply:Alive() ) then continue end
        if ( !ply:IsAFK() ) then continue end
        local dist = LocalPlayer():GetPos():DistToSqr( ply:GetPos() )
        local maxDist = 256^2
        if ( dist > maxDist ) then continue end
        
        local alpha = 1 - ( 1 * ( dist / maxDist ) )
        if ( alpha > 0 ) then
            local afkCount = ply:GetNWFloat( "AT_AFK_COUNT", 0.0 )
            local kickin = string.ToMinutesSeconds( math.ceil( -( afkCount - CurTime() ) ) )

            local bone = ply:LookupBone( "ValveBiped.Bip01_Head1" )
            local pos = ply:GetPos() + Vector( 0, 0, 92 )
            if ( isnumber( bone ) ) then
                pos = ply:GetBonePosition( bone )
                pos = pos + Vector( 0, 0, 48 )
            end

            cam.Start3D2D( pos + Vector(-20,0,-20) + Vector( 35, 0, 0 ), Angle( 0, EyeAngles().y - 90, 90 ), 0.025 )
                draw.SimpleText( "AFK - " .. kickin, "AT_AFK", 0, 900, Color( 255, 255, 255, 255 * alpha ), 1 )
            cam.End3D2D()
        end
    end
end )