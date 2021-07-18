include( "sh_afk_player.lua" )
inclide( "cl_afk.lua" )

function ResetAFK( ply )
    ply:SetNWBool( "AT_AFK", false )
    ply:SetNWFloat( "AT_AFK_KICK", CurTime() + 100 )
    ply:SetNWFloat( "AT_AFK_COUNT", CurTime() )
end

hook.Add( "PlayerSay", "AFKCheckForChat", function( ply )
    if ( !IsValid( ply ) ) then return end

    ResetAFK( ply )
end )

hook.Add( "KeyPress", "ATCheckForKeyPress", function( ply )
    if ( !IsValid( ply ) || !ply:Alive() ) then return end

	ResetAFK( ply )
end )

hook.Add( "PlayerSpawn", "ATAFKReset", function( ply )
    ResetAFK( ply )
end )

hook.Add( "PlayerPostThink", "ATAFKTimer", function( ply )
    local afkkick = ply:GetNWFloat( "AT_AFK_KICK" )

    if ( !afkkick ) then
        return
    end

    if ply.ang then

        if ply.ang ~= ply:GetAngles() then

            ResetAFK(ply)

        end

    end

    local timediff = afkkick - CurTime()
    if ( timediff < ( 100 / 3 ) ) then
        if ( ply.SetNWBool ) then
            if ( !ply:GetNWBool( "AT_AFK", false ) ) then
                ply:SetNWBool( "AT_AFK", true )
                ply:SetNWFloat( "AT_AFK_COUNT", CurTime() )
                ply.ang = ply:GetAngles()
            end
        end
    end
end )