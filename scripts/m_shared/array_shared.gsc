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
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;

#namespace m_array;

/@
"Author: DidUknowiPwn"
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
	if ( !IsArray( array ) || !IsInArray( array, value ) )
		return undefined;

	for ( i = 0; i < array.size; i++ )
	{
		if ( array[i] == value )
			return ( as_index ? i : array[ i ] );
	}
}

/@
"Author: DidUknowiPwn"
"Name: m_array::select_random( <array> )"
"Summary: Select a random element from the array while randomizing the array"
"Module: Utility"
"MandatoryArg: <array> : the array of items to randomize and select from"
"Example: selection = m_array::select_random( level.players );"
@/
function select_random( array )
{
	return array::random( array::randomize( array ) );
}

/@
"Author: DidUknowiPwn"
"Name: m_array::create_from( <array>, <n_s_index>, [n_e_index], [b_reversed] )"
"Summary: Return a new array from supplied array but start from given index"
"Module: Utility"
"MandatoryArg: <array> : the array to work from"
"MandatoryArg: <n_s_index> : the index to start the new array"
"OptionalArg: [n_e_index] : the index to end the new array"
"OptionalArg: [b_reversed] : reverse the order of the array"
"Example: a_new_items = m_array::create_from( array, 3 );"
@/
function create_from( array, n_s_index, n_e_index, b_reversed = false )
{
	a_ret = [];
	n_max_index = ( isdefined( n_e_index ) && n_e_index > 0 ? n_e_index : array.size );
	n_max_index = math::clamp( n_max_index, 0, array.size );

	for( i = n_s_index; i < n_max_index; i++ )
		a_ret[ i ] = array[ i ];

	return ( b_reversed ? array::reverse( a_ret ) : a_ret );
}