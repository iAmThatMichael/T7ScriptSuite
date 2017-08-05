// ==========================================================
// T7ScriptSuite
//
// Component: math
// Purpose: shared math code for all gamemodes
//
// Initial author: DidUknowiPwn
// Started: July 29, 2017
// ==========================================================

#using scripts\shared\math_shared;

// T7 Script Suite - Include everything
#insert scripts\m_shared\utility.gsh;
T7_SCRIPT_SUITE_INCLUDES
#insert scripts\m_shared\lui.gsh;
#insert scripts\m_shared\bits.gsh;

#namespace m_math;

/@
"Author: DidUknowiPwn"
"Name: m_util::in_between( <lowest>, <greatest>, <comparison> )"
"Summary: Gets the total of players in a team"
"Module: Utility"
"MandatoryArg: <lowest> : lowest value to compare"
"MandatoryArg: <greatest> : largest value to compare"
"MandatoryArg: <comparison> : value to test"
"Example: num = m_util::in_between( 6, 10, 8 );"
@/
function in_between( lowest, greatest, comparison )
{
	//greatest = ( val_a > val_b ? val_a : val_b );
	//lowest = ( greatest == val_a ? val_a : val_b );

	return ( comparison >= lowest && comparison <= greatest );
}