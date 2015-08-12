ENT.Base = "base_point"
ENT.Type = "point"
ENT.ClassName = "ww2c_player_spawn"

ENT.Spawnable = false

function ENT:KeyValue(k,v)
	if k == "team" then
		self.GetTeam = v
	end
	
	if k == "section" then
		self.GetSection = v
	end
end