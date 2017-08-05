// ==========================================================
// T7ScriptSuite
//
// Component: zm perks
// Purpose: zm perks mechanics
//
// Initial author: DidUknowiPwn
// Started: June 1, 2017
// ==========================================================

#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;

// T7 Script Suite - Include everything
#insert scripts\m_shared\utility.gsh;
T7_SCRIPT_SUITE_INCLUDES

#namespace m_zm_perks;

/@
"Author: DidUknowiPwn"
"Name: m_zm_perks::get_perk_alias( <str_perk> )"
"Summary: Returns the perks alias string"
"Module: Zombiemode - Perks"
"MandatoryArg: <str_perk> : The perks 'specialty_' name"
"Example: alias = m_zm_perks::get_perk_alias( "specialty_vultureaid" );"
@/
function get_perk_alias( str_perk )
{
	Assert( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].alias ), "_zm_perks_ss::get_perk_alias undefined perk: " + str_perk );
	
	if ( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].alias ) )
		return level._custom_perks[ str_perk ].alias;
	return str_perk; // return the 'specialty_' by default name as thats what the function in _zm_perks does
}

/@
"Author: DidUknowiPwn"
"Name: m_zm_perks::get_perk_hash_id( <str_perk> )"
"Summary: Returns the perks hash id"
"Module: Zombiemode - Perks"
"MandatoryArg: <str_perk> : The perks 'specialty_' name"
"Example: hash_id = m_zm_perks::get_perk_hash_id( "specialty_vultureaid" );"
@/
function get_perk_hash_id( str_perk )
{
	Assert( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].hash_id ), "_zm_perks_ss::get_perk_hash_id undefined perk: " + str_perk );
	
	if ( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].hash_id ) )
		return level._custom_perks[ str_perk ].hash_id;
	return -1; // return -1 by default
}

/@
"Author: DidUknowiPwn"
"Name: m_zm_perks::get_perk_cost( <str_perk> )"
"Summary: Returns the perks cost"
"Module: Zombiemode - Perks"
"MandatoryArg: <str_perk> : The perks 'specialty_' name"
"Example: cost = m_zm_perks::get_perk_cost( "specialty_vultureaid" );"
@/
function get_perk_cost( str_perk )
{
	Assert( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].cost ), "_zm_perks_ss::get_perk_cost undefined perk: " + str_perk );
	
	cost = 2000; // default perk cost

	// default perk cost from zombie_vars array
	if( isdefined( level.zombie_vars ) && isdefined( level.zombie_vars[ "zombie_perk_cost" ] ) )
		cost = level.zombie_vars[ "zombie_perk_cost" ];

	if ( isdefined( level._custom_perks[ str_perk ] ) )
	{
		if ( isdefined( level._custom_perks[ str_perk ].cost ) )
		{
			if ( IsInt( level._custom_perks[ str_perk ].cost ) )
				cost = level._custom_perks[ str_perk ].cost;
			else if ( IsFunctionPtr( level._custom_perks[ str_perk ].cost ) ) // we're assuming because of t7 having a different solution towards QR there may be a function pointer
				cost = [[ level._custom_perks[ str_perk ].cost ]]();
		}
	}
	return cost;
}

/@
"Author: DidUknowiPwn"
"Name: m_zm_perks::get_perk_hint_string( <str_perk> )"
"Summary: Returns the perks hint string"
"Module: Zombiemode - Perks"
"MandatoryArg: <str_perk> : The perks 'specialty_' name"
"Example: hint_string = m_zm_perks::get_perk_hint_string( "specialty_vultureaid" );"
@/
function get_perk_hint_string( str_perk )
{
	Assert( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].hint_string ), "_zm_perks_ss::get_perk_hint_string undefined perk: " + str_perk );

	if ( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].hint_string ) )
		return level._custom_perks[ str_perk ].hint_string;
	return "Press ^3[{+activate}]^7 to buy perk [Cost: &&1]"; // return default hint string
}

/@
"Author: DidUknowiPwn"
"Name: m_zm_perks::get_perk_bottle_weapon( <str_perk> )"
"Summary: Returns the perks bottle weapon"
"Module: Zombiemode - Perks"
"MandatoryArg: <str_perk> : The perks 'specialty_' name"
"Example: perk_bottle_weapon = m_zm_perks::get_perk_bottle_weapon( "specialty_vultureaid" );"
@/
function get_perk_bottle_weapon( str_perk )
{
	Assert( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].perk_bottle_weapon ), "_zm_perks_ss::get_perk_hint_string undefined perk: " + str_perk );

	if ( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].perk_bottle_weapon ) )
		return level._custom_perks[ str_perk ].perk_bottle_weapon;
	// the perk bottle is also stored in machine assets array
	if( isdefined( level.machine_assets ) && isdefined( level.machine_assets[ str_perk ] ) && isdefined( level.machine_assets[ str_perk ].weapon ) )
		return level.machine_assets[ str_perk ].weapon;
	return level.weaponNone; // return some weapon by default
}

/@
"Author: [TxM] WARDOG"
"Name: m_zm_perks::include_perk_in_random_rotation( <str_perk> )"
"Summary: Includes this perk as part of the random perks rotation cycle"
"Module: Zombiemode - Perks"
"MandatoryArg: <str_perk> : The perks 'specialty_' name"
"Example: m_zm_perks::include_perk_in_random_rotation( "specialty_vultureaid" );"
@/
function include_perk_in_random_rotation( str_perk )
{
	MAKE_ARRAY ( level._random_perk_machine_perk_list )

	if ( IsInArray ( level._random_perk_machine_perk_list, str_perk ) )
		return;

	level._random_perk_machine_perk_list [ level._random_perk_machine_perk_list.size ] = str_perk;
}

/@
"Author: [TxM] WARDOG"
"Name: m_zm_perks::remove_perk_from_random_rotation( <str_perk> )"
"Summary: Removes this perk from the random perks rotation cycle"
"Module: Zombiemode - Perks"
"MandatoryArg: <str_perk> : The perks 'specialty_' name"
"Example: m_zm_perks::remove_perk_from_random_rotation( "specialty_vultureaid" );"
@/
function remove_perk_from_random_rotation( str_perk )
{
	MAKE_ARRAY( level._random_perk_machine_perk_list )

	if( !IsInArray( level._random_perk_machine_perk_list, str_perk ) )
		return;

	ArrayRemoveValue( level._random_perk_machine_perk_list, str_perk, false );
}

/@
"Author: [TxM] WARDOG"
"Name: m_zm_perks::get_weighted_random_perk( <player> )"
"Summary: Gets a weighted random perk from the random perks rotation cycle"
"Module: Zombiemode - Perks"
"MandatoryArg: <player> : Player to pick random perk for"
"Example: weighted_random_perk = m_zm_perks::get_weighted_random_perk( player );"
@/
function get_weighted_random_perk( player )
{
	keys = array::randomize( GetArrayKeys( level._random_perk_machine_perk_list ) );

	if( isdefined( level.custom_random_perk_weights ) )
		keys = player [[ level.custom_random_perk_weights ]]();

	foreach ( perk in keys )
	{
		if ( player HasPerk ( level._random_perk_machine_perk_list[ perk ] ) )
			continue;
		if ( player zm_perks::has_perk_paused ( level._random_perk_machine_perk_list[ perk ] ) )
			continue;
		return level._random_perk_machine_perk_list [ perk ] ;
	}
	return level._random_perk_machine_perk_list [ keys[ 0 ] ];
}
