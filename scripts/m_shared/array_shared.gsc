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
"Author: DidUknowiPwn"
"LastChange: 5/14/17"
"Name: m_array::search( <array>, <value>, [as_index] )"
"Summary: Searches given array for the value"
"Module: Utility"
"MandatoryArg: <array> : the array of items to search"
"MandatoryArg: <value> : the value to search for"
"OptionalArg: [as_index] : parameter 1 causes this to return an index instead of item"
"Example: item = m_array::search( level.players, player );"
@/
function search( array, value, as_index = false )
{
	if ( !IsArray( array ) )
		return undefined;

	for ( i = 0; i < array.size; i++ )
	{
		if ( array[i] == value )
			return ( as_index ? i : array[ i ] );
	}
}

/@
"Author: DidUknowiPwn"
"LastChange: 5/14/17"
"Name: m_array::randomize_return( <array> )"
"Summary: Select a random element from the array while randomizing the array"
"Module: Utility"
"MandatoryArg: <array> : the array of items to randomize and select from"
"Example: selection = m_array::randomize_return( level.players );"
@/
function randomize_return( array )
{
	return array::random( array::randomize( array ) );
}