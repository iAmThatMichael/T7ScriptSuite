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

#precache( "lui_menu", "HudElementText" );
#precache( "lui_menu", "HudElementImage" );
#precache( "lui_menu", "HudElementTimer" );

function autoexec init()
{
	callback::on_spawned( &on_player_spawned );
}

function on_player_spawned()
{
	if ( !isdefined( self.lui_hud ) )
		self.lui_hud = [];

	self.lui_hud["image"] = [];
	self.lui_hud["text"] = [];
}

/@
"Author: DidUknowiPwn"
"Name: m_lui::show_msg( <msg>, [alignment], [x], [y], [color], [alpha] )"
"Summary: Displays a message using the LUI system"
"Module: LUI"
"MandatoryArg: <msg> : the value to convert to a string"
"OptionalArg: [alignment] : select an alignment style using shared.gsh LUI_HUDELEM_ALIGNMENT_X"
"OptionalArg: [x] : x position for the message"
"OptionalArg: [y] : y position for the message"
"OptionalArg: [color] : color for the message"
"OptionalArg: [alpha] : alpha for the message"
"OptionalArg: [auto_clear] : automatically clear the text on death, downed, or game end"
"Example: msg = player m_lui::show_msg( "ModTools!", LUI_HUDELEM_ALIGNMENT_CENTER, 0, 320, WHITE, alpha );"
@/
function show_msg( msg, alignment = LUI_HUDELEM_ALIGNMENT_CENTER, x = 0, y = 0, color = WHITE, alpha = 1, auto_clear = true )
{
	self endon( "death" );
	self endon( "disconnect" );

	if ( IsString( msg ) && msg != "" )
	{
		data = SpawnStruct();
		
		data.hud = self OpenLUIMenu( "HudElementText" );
		data.type = "text";
		data.idx = self.lui_hud["text"].size;

		self SetLUIMenuData( data.hud, "alignment", alignment );
		self SetLUIMenuData( data.hud, "x", x );
		self SetLUIMenuData( data.hud, "y", y );
		self SetLUIMenuData( data.hud, "width", SCREEN_WIDTH );
		self SetLUIMenuData( data.hud, "alpha", alpha );
		self lui::set_color( data.hud, color );

		self SetLUIMenuData( data.hud, "text", msg );

		self.lui_hud["text"][ data.idx ] = data.hud;

		if ( auto_clear )
		{
			self thread clear_lui_menu_on_death_or_downed( data );
			self thread clear_lui_menu_on_end( data );
		}
	}

	return data;
}

/@
"Author: DidUknowiPwn"
"Name: m_lui::show_msg_for_time( <msg>, <time>, [alignment], [x], [y], [color], [alpha] )"
"Summary: Displays a message for some time using the LUI system"
"Module: LUI"
"MandatoryArg: <msg> : the value to convert to a string"
"MandatoryArg: [time] : the total time to display the string"
"OptionalArg: [alignment] : select an alignment style using shared.gsh LUI_HUDELEM_ALIGNMENT_X"
"OptionalArg: [x] : x position for the message"
"OptionalArg: [y] : y position for the message"
"OptionalArg: [color] : color for the message"
"OptionalArg: [alpha] : alpha for the message"
"OptionalArg: [auto_clear] : automatically clear the text on death, downed, or game end"
"Example: player m_lui::show_msg_for_time( "ModTools!", 10, LUI_HUDELEM_ALIGNMENT_CENTER, 0, 320, WHITE );"
@/
function show_msg_for_time( msg, time = 5, alignment = LUI_HUDELEM_ALIGNMENT_CENTER, x = 0, y = 0, color = WHITE, alpha = 1, auto_clear = true )
{
	self endon( "death" );
	self endon( "disconnect" );

	lui_data = self show_msg( msg, alignment, x, y, color, alpha, auto_clear );

	if ( isdefined( time ) && time > 0 )
	{
		wait time;

		self thread clear_lui_menu( lui_data );
	}
}

/@
"Author: [TxM] WARDOG"
"Name: m_lui::show_shader( <shader>, [x], [y], [width], [height], [alpha], [auto_clear] )"
"Summary: Displays a shader using the LUI system"
"Module: LUI"
"MandatoryArg: <shader> : the shader material that will be displayed"
"OptionalArg: [x] : x position for the shader"
"OptionalArg: [y] : y position for the shader"
"OptionalArg: [width] : width for the shader"
"OptionalArg: [height] : height for the shader"
"OptionalArg: [alpha] : alpha for the shader"
"OptionalArg: [auto_clear] : automatically clear the shader on death, downed, or game end"
"Example: shader = player m_lui::show_shader( "specialty_fastreload_zombies", LUI_HUDELEM_ALIGNMENT_CENTER, 0, 320 );"
@/
function show_shader( shader, x = 0, y = 0, width = 128, height = 128, alpha = 1, auto_clear = true )
{
	self endon( "death" );
	self endon( "disconnect" );

	if ( IsString( shader ) && shader != "" )
	{
		data = SpawnStruct();
		
		data.hud = self OpenLUIMenu( "HudElementImage" );
		data.type = "image";
		data.idx = self.lui_hud["image"].size;

		self SetLUIMenuData( data.hud, "alignment", LUI_HUDELEM_ALIGNMENT_CENTER );
		self SetLUIMenuData( data.hud, "x", x );
		self SetLUIMenuData( data.hud, "y", y );
		self SetLUIMenuData( data.hud, "width", width );
		self SetLUIMenuData( data.hud, "height", height );
		self SetLUIMenuData( data.hud, "alpha", alpha );
		
		self SetLUIMenuData( data.hud, "material", shader );

		self.lui_hud["image"][ data.idx ] = data.hud;

		if ( auto_clear )
		{
			self thread clear_lui_menu_on_death_or_downed( data );
			self thread clear_lui_menu_on_end( data );
		}
	}

	return data;
}

/@
"Author: [TxM] WARDOG"
"Name: m_lui::show_shader_for_time( <shader>, <time>, [x], [y], [width], [height], [alpha], [auto_clear] )"
"Summary: Displays a shader for some time using the LUI system"
"Module: LUI"
"MandatoryArg: <shader> : the shader material that will be displayed"
"MandatoryArg: [time] : the total time to display the shader"
"OptionalArg: [x] : x position for the shader"
"OptionalArg: [y] : y position for the shader"
"OptionalArg: [width] : width for the shader"
"OptionalArg: [height] : height for the shader"
"OptionalArg: [alpha] : alpha for the shader"
"OptionalArg: [auto_clear] : automatically clear the shader on death, downed, or game end"
"Example: player m_lui::show_shader_for_time( "specialty_fastreload_zombies", 10, 0, 320 );"
@/
function show_shader_for_time( shader, time = 5, x = 0, y = 0, width = 128, height = 128, alpha = 1, auto_clear = true )
{
	self endon( "death" );
	self endon( "disconnect" );

	lui_data = self show_shader( shader, x, y, width, height, alpha, auto_clear );

	if ( isdefined( time ) && time > 0 )
	{
		wait time;
		self thread clear_lui_menu( lui_data );
	}
}

function clear_lui_menu_on_death_or_downed( lui_data )
{
	self endon( "disconnect" );
	self endon( "lui_menu_remove_" + lui_data.type + "_" + lui_data.idx );

	self util::waittill_either( "death", "player_downed" );

	self thread clear_lui_menu( lui_data );
}

function clear_lui_menu_on_end( lui_data )
{
	self endon( "disconnect" );
	self endon( "lui_menu_remove_" + lui_data.type + "_" + lui_data.idx );

	level util::waittill_either( "game_ended", "end_game" );

	self thread clear_lui_menu( lui_data );
}

function clear_lui_menu( lui_data )
{
	self endon( "disconnect" );

	if ( isdefined( lui_data ) )
	{
		self CloseLUIMenu( lui_data.hud );
		ArrayRemoveIndex( self.lui_hud[ lui_data.type ], lui_data.idx, true );

		self notify( "lui_menu_remove_" + lui_data.type + "_" + lui_data.idx );
	}
}