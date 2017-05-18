// ==========================================================
// T7ScriptSuite
//
// Component: lui
// Purpose: shared lui code for all gamemodes
//
// Initial author: DidUknowiPwn
// Started: May 16, 2017
// ==========================================================

#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\string_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\lui_shared;

#insert scripts\shared\shared.gsh;

#namespace m_lui;

function autoexec init()
{
	callback::on_spawned( &on_player_spawned );
}

function on_player_spawned()
{
	if ( !isdefined( self.lui_hud ) )
		self.lui_hud = SpawnStruct();

	self.lui_hud.image = [];
	self.lui_hud.text = [];
}

/@
"Author: [TxM] WARDOG"
"LastChange: 18/5/17"
"Name: m_lui::show_shader( <shader>, [alignment], [x], [y], [width], [color] )"
"Summary: Displays a shader using the LUI system"
"Module: LUI"
"MandatoryArg: <shader> : the shader material that will be displayed"
"OptionalArg: [alignment] : select an alignment style using shared.gsh LUI_HUDELEM_ALIGNMENT_X"
"OptionalArg: [x] : x position for the message"
"OptionalArg: [y] : y position for the message"
"OptionalArg: [width] : width for the message"
"OptionalArg: [color] : color for the message"
"Example: player m_lui::show_shader( "specialty_fastreload_zombies", LUI_HUDELEM_ALIGNMENT_CENTER, 0, 320, SCREEN_WIDTH, WHITE ); "
@/
function show_shader( shader, alignment = LUI_HUDELEM_ALIGNMENT_CENTER, x = 0, y = 0, width = SCREEN_WIDTH, color = WHITE )
{
	self endon( "death" );
	self endon( "disconnect" );

	if ( IsString( shader ) && shader != "" )
	{
		hud = self OpenLUIMenu( "HudElementText" );
		self SetLUIMenuData( hud, "alignment", alignment );
		self SetLUIMenuData( hud, "x", x );
		self SetLUIMenuData( hud, "y", y );
		self SetLUIMenuData( hud, "width", width );
		self lui::set_color( hud, color );
		
		self SetLUIMenuData( hud, "material", shader );

		self.lui_hud.image[ self.lui_hud.image.size ] = hud;

		self thread clear_lui_menu_on_death( hud );
		self thread clear_lui_menu_on_end( hud );
	}

	return hud;
}

/@
"Author: [TxM] WARDOG"
"LastChange: 18/5/17"
"Name: m_lui::show_shader_for_time( <shader>, <time> [alignment], [x], [y], [width], [color] )"
"Summary: Displays a shader for some time using the LUI system"
"Module: LUI"
"MandatoryArg: <shader> : the shader material that will be displayed"
"MandatoryArg: [time] : the total time to display the string"
"OptionalArg: [alignment] : select an alignment style using shared.gsh LUI_HUDELEM_ALIGNMENT_X"
"OptionalArg: [x] : x position for the message"
"OptionalArg: [y] : y position for the message"
"OptionalArg: [width] : width for the message"
"OptionalArg: [color] : color for the message"
"Example: player m_lui::show_shader_for_time( "specialty_fastreload_zombies", 10, LUI_HUDELEM_ALIGNMENT_CENTER, 0, 320, SCREEN_WIDTH, WHITE ); "
@/
function show_shader_for_time( shader, time = 5, alignment = LUI_HUDELEM_ALIGNMENT_CENTER, x = 0, y = 0, width = SCREEN_WIDTH, color = WHITE )
{
	self endon( "death" );
	self endon( "disconnect" );

	lui_menu = self show_shader( shader, alignment, x, y, width, color );

	if ( isdefined( time ) && time > 0 )
	{
		wait time;
		self thread clear_lui_menu( lui_menu );
	}
}

/@
"Author: DidUknowiPwn"
"LastChange: 5/16/17"
"Name: m_lui::show_msg( <msg>, [alignment], [x], [y], [width], [color] )"
"Summary: Displays a message using the LUI system"
"Module: LUI"
"MandatoryArg: <msg> : the value to convert to a string"
"OptionalArg: [alignment] : select an alignment style using shared.gsh LUI_HUDELEM_ALIGNMENT_X"
"OptionalArg: [x] : x position for the message"
"OptionalArg: [y] : y position for the message"
"OptionalArg: [width] : width for the message"
"OptionalArg: [color] : color for the message"
"Example: player m_lui::show_msg( "ModTools!", LUI_HUDELEM_ALIGNMENT_CENTER, 0, 320, SCREEN_WIDTH, WHITE ); "
@/
function show_msg( msg, alignment = LUI_HUDELEM_ALIGNMENT_CENTER, x = 0, y = 0, width = SCREEN_WIDTH, color = WHITE )
{
	self endon( "death" );
	self endon( "disconnect" );

	if ( IsString( msg ) && msg != "" )
	{
		hud = self OpenLUIMenu( "HudElementText" );
		self SetLUIMenuData( hud, "alignment", alignment );
		self SetLUIMenuData( hud, "x", x );
		self SetLUIMenuData( hud, "y", y );
		self SetLUIMenuData( hud, "width", width );
		self lui::set_color( hud, color );
		
		self SetLUIMenuData( hud, "text", text );

		self.lui_hud.image[ self.lui_hud.image.size ] = hud;

		self thread clear_lui_menu_on_death( hud );
		self thread clear_lui_menu_on_end( hud );
	}

	return hud;
}

/@
"Author: DidUknowiPwn"
"LastChange: 5/16/17"
"Name: m_lui::show_msg( <msg>, <time>, [alignment], [x], [y], [width], [color] )"
"Summary: Displays a message for some time using the LUI system"
"Module: LUI"
"MandatoryArg: <msg> : the value to convert to a string"
"MandatoryArg: [time] : the total time to display the string"
"OptionalArg: [alignment] : select an alignment style using shared.gsh LUI_HUDELEM_ALIGNMENT_X"
"OptionalArg: [x] : x position for the message"
"OptionalArg: [y] : y position for the message"
"OptionalArg: [width] : width for the message"
"OptionalArg: [color] : color for the message"
"Example: player m_lui::show_msg( "ModTools!", 10, LUI_HUDELEM_ALIGNMENT_CENTER, 0, 320, SCREEN_WIDTH, WHITE ); "
@/
function show_msg_for_time( msg, time = 5, alignment = LUI_HUDELEM_ALIGNMENT_CENTER, x = 0, y = 0, width = SCREEN_WIDTH, color = WHITE )
{
	self endon( "death" );
	self endon( "disconnect" );

	self show_msg( msg, alignment, x, y, width, color );

	if ( isdefined( time ) && time > 0 )
	{
		wait time;

		self thread clear_lui_menu( self.lui_hud_text );
	}
}

// WARDOG - Change to be more universal
function clear_lui_menu_on_death( lui_menu )
{
	self endon( "disconnect" );

	self waittill( "death" );

	self thread clear_lui_menu( lui_menu );
}

function clear_lui_menu_on_end( lui_menu )
{
	self endon( "disconnect" );

	level util::waittill_either( "game_ended", "end_game" );

	self thread clear_lui_menu( lui_menu );
}

// WARDOG - Change to be more universal
function clear_lui_menu( lui_menu )
{
	self endon( "disconnect" );

	if ( isdefined( lui_menu ) )
		self CloseLUIMenu( lui_menu );
}