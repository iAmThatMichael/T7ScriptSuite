// ==========================================================
// T7ScriptSuite
//
// Component: utility
// Purpose: shared utility code for all gamemodes
//
// Initial author: DidUknowiPwn
// Started: May 16, 2017
// ==========================================================

#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\statstable_shared.gsh;

// T7 Script Suite - Include everything
#insert scripts\m_shared\utility.gsh;
T7_SCRIPT_SUITE_INCLUDES
#insert scripts\m_shared\lui.gsh;
#insert scripts\m_shared\bits.gsh;

#namespace m_util;

/@
"Author: DidUknowiPwn"
"Name: m_util::to_string( <convert> )"
"Summary: Converts given values to a string"
"Module: Utility"
"MandatoryArg: <convert> : the value to convert to a string"
"OptionalArg: [append_str] : append each convert item with this"
"Example: str = m_util::to_string( 15 );"
@/
function to_string( convert, append_str = "" )
{
	// also usable is STR()/STR_DEFAULT() within shared.gsh
	if ( IsString( convert ) )
		return convert;

	string = "";

	if ( IsArray( convert ) )
	{
		foreach ( str in convert )
			string += convert + append_str;
	}
	else
		string += convert + append_str;

	return string;
}

/@
"Author: DidUknowiPwn"
"Name: m_util::get_team_count( <team> )"
"Summary: Gets the total of players in a team"
"Module: Utility"
"MandatoryArg: <team> : team to return"
"Example: num = m_util::get_team_count( "axis" );"
@/
function get_team_count( team = "allies" )
{
	Assert( isdefined( level.playerCount[ team ] ), "Unknown team passed in m_util::get_team_count() - " + team );

	return level.playerCount[ team ];
}

/@
"Author: DidUknowiPwn"
"Name: m_util::get_players_in_team( <team> )"
"Summary: Gets an array of players in a team"
"Module: Utility"
"MandatoryArg: <team> : team to return"
"Example: num = m_util::get_team_count( "axis" );"
@/
function get_players_in_team( team = "allies" )
{
	Assert( isdefined( level.teams[ team ] ), "Unknown team passed in m_util::get_players_in_team() - " + team );

	players = [];

	foreach ( player in level.players )
	{
		if ( player.team == team )
			ARRAY_ADD( players, player );
	}

	return players;
}

/@
"Author: DidUknowiPwn"
"Name: m_util::spawn_bot_button()"
"Summary: A threaded function that spawns a bot on Reload & Use buttons press"
"Module: Utility"
"Example: player thread m_util::spawn_bot_button();"
@/
function spawn_bot_button()
{
	self endon( "death" );
	self endon( "disconnect" );

	if ( self IsTestClient() )
		return;

	self thread buttons_pressed( Array( &ReloadButtonPressed, &UseButtonPressed ), &spawn_bot );
}

function spawn_bot()
{
	bot = AddTestClient();
	if ( isdefined( bot ) )
		bot BotSetRandomCharacterCustomization();
	return bot;
}

function button_pressed( button, callback, s_notify, cooldown = SERVER_FRAME )
{
	self endon( "death" );
	self endon( "disconnect" );

	if ( isdefined( s_notify ) )
	{
		self notify( s_notify );
		self endon( s_notify );
	}

	assert( IsPlayer( self ), "Must call this on a player [m_util::button_pressed()]");
	assert( IsFunctionPtr( button ), "Must use 1 function for button arg [m_util::button_pressed()]");

	while ( true )
	{
		WAIT_SERVER_FRAME;

		if ( WAS_BUTTON_PRESSED( button ) )
		{
			self [[ callback ]]();

			while ( WAS_BUTTON_PRESSED( button ) )
				wait ( cooldown );
		}
	}
}

function buttons_pressed( buttons, callback, s_notify, cooldown = SERVER_FRAME )
{
	self endon( "death" );
	self endon( "disconnect" );

	if ( isdefined( s_notify ) )
	{
		self notify( s_notify );
		self endon( s_notify );
	}

	assert( IsPlayer( self ), "Must call this on a player [m_util::button_pressed()]");
	assert( IsArray( buttons ) && buttons.size > 1, "Must use more than 1 function for buttons arg [m_util::buttons_pressed()]");

	while ( true )
	{
		a_buttons_selected = []; // re(set) the array

		WAIT_SERVER_FRAME;

		foreach ( button in buttons )
		{
			if ( WAS_BUTTON_PRESSED( button ) )
				ARRAY_ADD( a_buttons_selected, true );
		}

		if ( a_buttons_selected.size == buttons.size ) // just assuming that the array is all true
			self [[ callback ]]();

		while ( WAS_BUTTON_PRESSED( buttons[0] ) )
			wait ( cooldown );
	}
}

function message( severity = S_TRACE, str )
{
	// space is deliberate
	IPrintLn( " ^" + severity + str );
}