// ==========================================================
// T7ScriptSuite
//
// Component: player
// Purpose: shared player code for all gamemodes
//
// Initial author: DidUknowiPwn
// Started: May 14, 2017
// ==========================================================

#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\shared\system_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\player_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace m_player;

/@
"Author: DidUknowiPwn"
"LastChange: 5/14/17"
"Name: m_player::lock( [stance] )"
"Summary: Player is locked from all movement mechanics."
"Module: Player"
"OptionalArg: [stance] : force a stance and lock the player to that one "
"Example: player m_player::lock( "crouch" );"
@/
function lock( stance = self GetStance() )
{
	// override player velocity to "completely" lock
	self SetVelocity( (0,0,0) );
	// stances -- Allow<> functions currently busted with MP
	self SetStance( stance );
	if ( stance != "crouch" )
		self AllowCrouch( false );
	if ( stance != "prone" ) 
		self AllowProne( false );
	if ( stance != "stand" ) 
		self AllowStand( false );
	// movements
	self AllowJump( false );
	self AllowMelee( false );
	self AllowSprint( false );
	self SetMoveSpeedScale( 0 );
	// weapons -- player weapons must be handled before locking them
	self DisableWeaponCycling(); 
	self DisableOffhandWeapons(); 
}

/@
"Author: DidUknowiPwn"
"LastChange: 5/14/17"
"Name: m_player::release()"
"Summary: Player is released from all stopping mechanics."
"Module: Player"
"Example: player m_player::release();"
@/
function release()
{
	// stances
	self AllowCrouch( true );
	self AllowProne( true );
	self AllowStand( true );
	// movements
	self AllowJump( true );
	self AllowMelee( true );
	self AllowSprint( true );
	self SetMoveSpeedScale( 1 );
	// weapons
	self EnableWeaponCycling(); 
	self EnableOffhandWeapons(); 
}