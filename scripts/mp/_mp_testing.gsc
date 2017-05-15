// ==========================================================
// T7ScriptSuite
//
// Component: mp_testing
// Purpose: a place to test code for MP specifically
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
#using scripts\m_shared\player_shared;

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

	while( !IS_TRUE( level.prematch_over ) )
		WAIT_SERVER_FRAME;

	self thread test_lock_release();
}
// testing lock & release
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