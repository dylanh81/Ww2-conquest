local self = FindMetaTable( "Player" )

function self:addPoints( amt )
    if not type( amt ) == "number" then return end
    self:SetNWInt( "points", self:GetNWInt( "points" ) + amt )
end

function self:getPoints()
    return self:GetNWInt( "points" )
end