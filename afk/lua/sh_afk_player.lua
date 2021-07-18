local meta = FindMetaTable( "Player" )

function meta:IsAFK()
    return self:GetNWBool( "AT_AFK", false )
end