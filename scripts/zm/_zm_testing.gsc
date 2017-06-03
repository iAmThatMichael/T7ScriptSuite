// ==========================================================
// T7ScriptSuite
//
// Component: mp_testing
// Purpose: a place to test code for ZM specifically
//
// Initial author: DidUknowiPwn
// Started: May 14, 2017
// ==========================================================

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\player_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;

// T7ScriptSuite scripts
#using scripts\m_shared\array_shared;
#using scripts\m_shared\lui_shared;
#using scripts\m_shared\player_shared;
// #using scripts\m_shared\trigger_shared;
#using scripts\m_shared\util_shared;

#precache( "material", "t7_hud_zm_powerup_deathmachine" );

function autoexec init()
{
	callback::on_connect( &on_player_connect );
	callback::on_disconnect( &on_player_disconnect );
	callback::on_spawned( &on_player_spawned );
}

function on_player_connect()
{

}

function on_player_disconnect()
{

}

function on_player_spawned()
{
	self endon( "death" );
	self endon( "disconnect" );

	while( !IS_TRUE( level.passed_introscreen ) )
		WAIT_SERVER_FRAME;

	self thread test_player();
	self thread test_lui();
	self thread test_util();
}

function test_player()
{
	// self thread test_lock_release();
}

function test_lui()
{
	self thread test_lui_msg();
	self thread test_lui_shader();
}

function test_util()
{
	// self thread test_get_team_count();
}

// ---------------
// PLAYER CODE 
// ---------------

function test_lock_release()
{
	self endon( "death" );
	self endon( "disconnect" );

	stances = array( "stand", "crouch", "prone" );
	self IPrintLn( "Testing Lock & Release" );
	foreach( stance in stances )
	{
		wait 1;
		self IPrintLn( "Locked to " + stance );
		self m_player::lock( stance );
		wait 3;
		self IPrintLn( "Released" );
		self m_player::release();
	}
}

// ---------------
// LUI CODE 
// ---------------

function test_lui_msg()
{
	// self thread m_lui::show_msg_for_time( "COOKIES!", 5, LUI_HUDELEM_ALIGNMENT_CENTER, 0, 320, RED );
}

function test_lui_shader()
{
	// self thread m_lui::show_shader_for_time( "t7_hud_zm_powerup_deathmachine", 5, LUI_HUDELEM_ALIGNMENT_CENTER, 0, 320, 256, 256 );
	// self thread m_lui::show_shader_for_time( "t7_hud_zm_powerup_deathmachine", 5, LUI_HUDELEM_ALIGNMENT_CENTER, 100, 320, 128, 128 );
}

// ---------------
// UTIL CODE 
// ---------------

function test_get_team_count()
{
	IPrintLn( "Total players in: " + self.team + " " + m_util::get_team_count( self.team ) );
}