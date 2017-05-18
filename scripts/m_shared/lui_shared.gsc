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

#insert scripts\shared\shared.gsh;

#namespace m_lui;

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

	/*
	WARDOG - Fix to use more universal function
		Original:

	self thread clear_msg_on_death();
	*/

	self thread clear_lui_menu_on_death( self.hud_et );

	if ( IsString( msg ) && msg != "" )
	{
		if ( !isdefined( self.hud_et ) )
		{
			self.hud_et = self OpenLUIMenu( "HudElementText" );
			self SetLUIMenuData( self.hud_et, "alignment", alignment );
			self SetLUIMenuData( self.hud_et, "x", x );
			self SetLUIMenuData( self.hud_et, "y", y );
			self SetLUIMenuData( self.hud_et, "width", width );
			self lui::set_color( self.hud_et, color );
		}
		
		self SetLUIMenuData( self.hud_et, "text", msg );
	}
}

/@
"Author: DidUknowiPwn"
"LastChange: 5/16/17"
"Name: m_lui::show_msg( <msg>, <time>, [alignment], [x], [y], [width], [color] )"
"Summary: Displays a message using the LUI system"
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
		/*
		WARDOG - Fix to use more universal function
			Original:

		self thread clear_msg();
		*/
		self thread clear_lui_menu( self.hud_et );
	}
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
		if ( !isdefined( self.lui_hud_image ) )
		{
			self.lui_hud_image = self OpenLUIMenu( "HudElementText" );
			self SetLUIMenuData( self.lui_hud_image, "alignment", alignment );
			self SetLUIMenuData( self.lui_hud_image, "x", x );
			self SetLUIMenuData( self.lui_hud_image, "y", y );
			self SetLUIMenuData( self.lui_hud_image, "width", width );
			self lui::set_color( self.lui_hud_image, color );
		}
		
		self SetLUIMenuData( self.lui_hud_image, "material", shader );
	}

	self thread clear_lui_menu_on_death( self.lui_hud_image );

	return self.lui_hud_image;
}

/@
"Author: [TxM] WARDOG"
"LastChange: 18/5/17"
"Name: m_lui::show_shader_for_time( <shader>, <time> [alignment], [x], [y], [width], [color] )"
"Summary: Displays a shader using the LUI system"
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

// WARDOG - Change to be more universal
function clear_lui_menu_on_death( lui_menu )
{
	self endon( "disconnect" );

	self waittill( "death" );

	/*
		Original:

	self thread clear_msg();
	*/

	self thread clear_lui_menu( lui_menu );
}

// WARDOG - Change to be more universal
function clear_lui_menu( lui_menu )
{
	self endon( "disconnect" );

	/*
		Original:

	if ( isdefined( self.hud_et ) )
	{
		self CloseLUIMenu( self.hud_et );
		self.hud_et = undefined;
	}	
	*/

	if ( isdefined( lui_menu ) )
		self CloseLUIMenu( lui_menu );
}