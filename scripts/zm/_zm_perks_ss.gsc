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

#namespace m_zm_perks;


function get_perk_alias( str_perk )
{
	Assert( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].alias ), "_zm_perks_ss::get_perk_alias undefined perk: " + str_perk );
	
	if ( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].alias ) )
		return level._custom_perks[ str_perk ].alias;
}

function get_perk_hash_id( str_perk )
{
	Assert( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].hash_id ), "_zm_perks_ss::get_perk_hash_id undefined perk: " + str_perk );
	
	if ( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].hash_id ) )
		return level._custom_perks[ str_perk ].hash_id;
}

function get_perk_cost( str_perk )
{
	Assert( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].cost ), "_zm_perks_ss::get_perk_cost undefined perk: " + str_perk );
	
	if ( isdefined( level._custom_perks[ str_perk ] )
	{
		if ( isdefined( level._custom_perks[ str_perk ].cost ) )
		{
			if ( IsInt( level._custom_perks[ str_perk ].cost ) )
				return level._custom_perks[ str_perk ].cost;
			else if ( IsFunctionPtr( level._custom_perks[ str_perk ].cost ) ) // we're assuming because of t7 having a different solution towards QR there may be a function pointer
				return [[ level._custom_perks[ str_perk ].cost ]]();
			else // not sure how we'd get here
				return undefined;
		}

	}
}

function get_perk_hint_string( str_perk )
{
	Assert( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].hint_string ), "_zm_perks_ss::get_perk_hint_string undefined perk: " + str_perk );

	if ( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].hint_string ) )
		return level._custom_perks[ str_perk ].hint_string;	
}

function get_perk_perk_bottle_weapon( str_perk )
{
	Assert( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].perk_bottle_weapon ), "_zm_perks_ss::get_perk_hint_string undefined perk: " + str_perk );

	if ( isdefined( level._custom_perks[ str_perk ] ) && isdefined( level._custom_perks[ str_perk ].perk_bottle_weapon ) )
		return level._custom_perks[ str_perk ].perk_bottle_weapon;
}