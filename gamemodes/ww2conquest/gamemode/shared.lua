GM.Name = "ww2conquest"
GM.Author = "RIPP3R"

DeriveGamemode( "base" )

function GM:CreateTeams()

	if ( !GAMEMODE.TeamBased ) then return end
	
	team.SetUp( TEAM_GREEN, "Green Team", Color( 70, 230, 70 ), true )
	team.SetSpawnPoint( TEAM_GREEN, "info_player_start" ) // The list of entities can be a table
	
	team.SetUp( TEAM_ORANGE, "Orange Team", Color( 255, 200, 50 ) )
	team.SetSpawnPoint( TEAM_ORANGE, "info_player_start", true )
	
	team.SetUp( TEAM_BLUE, "Blue Team", Color( 80, 150, 255 ) )
	team.SetSpawnPoint( TEAM_BLUE, "info_player_start", true )
	
	team.SetUp( TEAM_RED, "Red Team", Color( 255, 80, 80 ) )
	team.SetSpawnPoint( TEAM_RED, "info_player_start", true )
	
	team.SetUp( TEAM_SPECTATOR, "Spectators", Color( 200, 200, 200 ), true )
	team.SetSpawnPoint( TEAM_SPECTATOR, "info_player_start" )
	team.SetClass( TEAM_SPECTATOR, { "Spectator" } )

end