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
"Name: m_trigger::create_trigger( <type>, <origin>, <radius>, <height>, [SPAWNFLAGS] = 0 )"
"Summary: Create a trigger type with assigned properties."
"Module: Utility"
"MandatoryArg: <type> : type of the trigger"
"MandatoryArg: <origin> : origin of the trigger"
"MandatoryArg: <radius> : radius of the trigger"
"MandatoryArg: <height> : height of the trigger"
"OptionalArg: [SPAWNFLAGS] : spawnflags -- shouldn't be touching unless know what to do"
"Example: trig = m_trigger::create_trigger( "radius", (0,0,0), 32, 32 );"
@/
function create_trigger( type, origin, radius, height, SPAWNFLAGS = 0 )
{
	if ( !isdefined( type ) )
	{
		Assert( isdefined( type ), "missing type of trigger in m_trigger::create_trigger" );
		return undefined;
	}

	if ( StrTok( type, "radius" ) || StrTok( type, "use" ) )
	{
		AssertMsg( "only supports radius or use trigger's in m_trigger::create_trigger -- " + type );
		return undefined;
	}

	name = "trigger_" + type;
	ent = Spawn( name, origin, SPAWNFLAGS, radius, height );
	return ent;
}

/@
"Author: DidUknowiPwn"
"Name: m_trigger::exec_trigger_loop( <validation>, <callback> )"
"Summary: Run logic through the trigger for both validation & callback."
"Module: Utility"
"MandatoryArg: <validation> : function that handles the validation for callback"
"MandatoryArg: <callback> : function that runs after validation"
"Example: trig m_trigger::exec_trigger_loop( &dummy_validate, &dummy_callback );"
@/
function exec_trigger_loop( validation, callback )
{
	self endon( "delete" );
	self endon( "passed" );

	while( true )
	{
		self waittill( "trigger", ent ); // any other parameters?

		self [[ validation ]]( ent, callback );
	}
	// keeping cleanup separate in case other work is needed on this trigger
}

function exec_trigger_once( validation, callback )
{
	self endon( "delete" );
	self endon( "passed" );

	self waittill( "trigger", ent ); // any other parameters?

	self [[ validation ]]( ent, callback );
}