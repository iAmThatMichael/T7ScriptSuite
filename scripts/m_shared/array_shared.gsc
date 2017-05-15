// ==========================================================
// T7ScriptSuite
//
// Component: array
// Purpose: shared array code for all gamemodes
//
// Initial author: DidUknowiPwn
// Started: May 14, 2017
// ==========================================================

#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;

#namespace m_array;

/@
"Name: m_array::search( <array>, <value>, [arg1] )"
"Summary: Searches given array for the value"
"Module: Utility"
"MandatoryArg: <array> : the array of items to search"
"MandatoryArg: <vallue> : the value to search for"
"OptionalArg: arg1 : parameter 1 causes this to return an index instead of item"
"Example: m_array::search( level.players, player );"
"SPMP: both"
@/
function search( array, value, arg1 = false )
{
	if ( !IsArray( array ) )
		return undefined;

	for( i = 0; i < array.size; i++ )
	{
		if ( array[i] == value )
			return ( arg1 ? i : array[ i ] );
	}
}

/@
"Name: m_array::randomize_return( <array> )"
"Summary: Select a random element from the array while randomizing the array"
"Module: Utility"
"MandatoryArg: <array> : the array of items to randomize and select from"
"Example: m_array::randomize_return( level.players );"
"SPMP: both"
@/
function randomize_return( array )
{
	return array::random( array::randomize( array ) );
}