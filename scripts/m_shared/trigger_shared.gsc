// ==========================================================
// T7ScriptSuite
//
// Component: trigger
// Purpose: shared trigger code for all gamemodes
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
#using scripts\shared\trigger_shared;

#insert scripts\shared\shared.gsh;

#namespace m_trigger;

/@
"Author: DidUknowiPwn"
"LastChange: 5/16/17"
"Name: m_trigger::create_trigger( [type], ... )"
"Summary: Create a trigger type with assigned properties."
"Module: Utility"
"MandatoryArg: <type> : the trigger type"
"MandatoryArg: <properties> : the properties to define the trigger"
"Example: WIP"
@/
function create_trigger( type )
{
	if( !trigger::_is_valid_trigger_type( type ) )
	{
		AssertMsg( "Unknown trigger type: " + type + " -- m_trigger::create_trigger_type" );
		return undefined;
	}


}

function retrieve_spawnflags( type )
{
	switch( type )
	{

	}
}