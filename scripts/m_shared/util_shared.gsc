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

#namespace m_util;

/@
"Author: DidUknowiPwn"
"LastChange: 5/16/17"
"Name: m_util::to_string( <convert> )"
"Summary: Converts given values to a string"
"Module: Utility"
"MandatoryArg: <convert> : the value to convert to a string"
"OptionalArg: [append_str] : parameter 1 causes this to return an index instead of item"
"Example: str = m_util::to_string( 15 );"
@/
function to_string( convert, append_str = "" )
{
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
"LastChange: 5/16/17"
"Name: m_util::get_team_count( <team> )"
"Summary: Gets the total of players in a team"
"Module: Utility"
"MandatoryArg: <team> : the value to convert to a string"
"Example: num = m_util::get_team_count( "axis" );"
@/
function get_team_count( team = "allies" )
{
	Assert( isdefined( level.playerCount[ team ] ), "Unknown team passed in m_util::get_team_count() - " + team );

	return level.playerCount[ team ];
}