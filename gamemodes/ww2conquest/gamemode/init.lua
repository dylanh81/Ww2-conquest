 AddCSLuaFile( "cl_init.lua" )
 AddCSLuaFile( "shared.lua" )
 AddCSLuaFile( "player.lua" )
 
 include( 'shared.lua' )
 include( 'player.lua' )
 
 -- This shit is for da playerzzz
 resource.AddFile("models/weapons/syndod/v_mp40.mdl")
  
  
  local TEAM_SPEC, TEAM_AXIS, TEAM_ALLIED = 1, 2, 3

function GM:PlayerInitialSpawn( ply )

    if team.NumPlayers( TEAM_ALLIED ) > team.NumPlayers( TEAM_AXIS ) then
        ply:SetTeam( TEAM_AXIS )
        ply:SetModel( "models/players/phoenix.mdl" ) 
    elseif team.NumPlayers( TEAM_AXIS ) > team.NumPlayers( TEAM_ALLIED ) then
	    ply:SetTeam( TEAM_ALLIED ) 
		ply:SetModel( "models/players/riot.mdl" )
    else
	    local r = math.Rand( 1, 2 )
		if r == 1 then
		    ply:SetTeam( TEAM_ALLIED )
            ply:SetModel( "models/players/riot.mdl" )
	    else
	        ply:SetTeam( TEAM_AXIS )
	        ply:SetModel( "models/players/phoenix.mdl" )
	   end
   end



   ply:SetGravity( 1 ) 
   ply:SetWalkSpeed( 250 )
   ply:SetRunSpeed( 320 )
   ply:SetDuckSpeed( 0.5 )
   ply:SendLua( [[chat.AddText( Color( 70, 70, 200 ), "[Ww2 conquest] ", Color( 255, 255, 255), "Welcome to our Ww2 server, ]] .. ply:Nick() .. [[!" )]] )
end

function GM:PlayerDeath( ply, inf, att )
    timer.Destroy( "HPRegen_" .. ply:UniqueID() )
	if ply != att then
	    if att:IsPlayer() and IsValid( att ) then
		    if ply.lasthg and ply.lasthg == HITGROUP_HEAD then
			    net.Start( "tdm_killnotification" )
				    net.WriteInt( 1, 32)
		        net.Send( att )	
			else
			    net.Start( "tdm_killnotification" )	
				    net.WriteInt( 0, 32 )
				net.send( att )
			end
		end
	end
	
	ply:EmitSound( "npc/metropolice/pain3.wav", 100, 100 )
	
	for k, v in pairs( team.GetPlayers( TEAM_ALLIED ) ) do
	    if v:Alive() then
		    ply:ChatPrint( k )
		end
	end
end


function GM:PlayerLoadout( ply )
    ply:Give( "Weapon_357" )
	ply:GiveAmmo( 24, "357", true )
    
	ply:Give( "npc_dod_weapon_752_mp40" )

end

function GM:GetFallDamage( ply, flFallSpeed )
   return flFallSpeed / 25
end

function GM:PlayerDeathSound() return true end

function GM:ScalePlayerDamage( ply, hg )
    ply.lasthg =- hg
end

function GM:PlayerShouldTakeDamage( ply, att )
    if att:IsPlayer() then
	    if ply:Team() == att:Team() then
		    return false
		end
	end
    return true
end

function GM:PlayerHurt( ply, att, hp, dt )
    timer.Destroy( "HPRegen_" .. ply:UniqueID() )
	timer.Create( "HPRegen_" .. ply:UniqueID(), 3, 100 - ply:Health(), function()
	    ply:SetHealth( ply:Health() + 1 )
    end )
end

function GM:CanPlayerSuicide()
    return true
end


function GM:PlayerSelectSpawn( ply )
    local spawns_allied
	local spawn_axis
	local i
	if ply:Team() == TEAM_ALLIED then
	    spawns_allied = ents.FindByClass( "spawnpoint_allied" )
		i = math.random( #spawns_allied )
		return spawns_axis[i]
    end
end


function AddSpawnAllied( map, pos, ang )
    timer.Simple( 3, function()
	    if game.GetMap() == map then
	        local crate = ents.Create( "spawnpoint_allied" )
	        if not crate:IsValid() then return end
	        crate:SetPos( pos )
	        crate:SetAngles( ang )
	        crate:Spawn()
	        crate:DropToFloor()
		end
	end )
end
hook.Add("InitPostEntity", "AddSpawnAllied", AddSpawnAllied )

function AddSpawnAxis( map, pos, ang )
    timer.Simple( 3, function()
	    if game.GetMap() == map then
		    local crate = ents.Create( "spawnpoint_axis" )
			if not crate:IsValid() then return end
			crate:SetPos( pos )
			crate:SetAngles( ang )
			crate:Spawn()
			crate:DropToFloor()
		end
	end )
end
hook.Add("InitPostEntity", "AddSpawnAxis", AddSpawnAxis )	

resource.AddWorkshop( "104557094" )


AddSpawnAxis( "gm_construct", Vector( -4354.668457, -982.966858, 320.031250 ), Angle( 0, 80, 0 ) )

AddSpawnAllied( "gm_construct", Vector( -4377.547363, -3620.756592, 320.031250 ), Angle( 0, 90, 0 ) )

function GM:PlayerSetModel( ply )
	ply:SetModel( "models/player/kleiner.mdl" )
end

function RandomPlayerModel( ply )
 
 local t_model = spawnModels[ math.random( #spawnModels ) ]
 if t_model == ply:GetModel() then
  RandomPlayerModel( ply )
 else
  ply:SetModel( t_model )
  if ply:GetModel() == "models/player/kleiner.mdl" then
   ply:SetSkin( 1 )
  else
   ply:SetSkin( 0 )
  end
 end
 
end

function GM:PlayerSelectSpawn( pl )

	local spawns = ents.FindByClass( "info_player_start" )
	local random_entry = math.random( #spawns )

	return spawns[ random_entry ]

end
