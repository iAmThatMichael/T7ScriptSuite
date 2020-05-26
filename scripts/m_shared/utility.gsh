#define T7_SCRIPT_SUITE_INCLUDES \
	#using scripts\m_shared\array_shared; \
	#using scripts\m_shared\lui_shared; \
	#using scripts\m_shared\player_shared; \
	#using scripts\m_shared\trigger_shared; \
	#using scripts\m_shared\util_shared;


#define WAS_BUTTON_PRESSED(button) \
	( isdefined(button) && IsFunctionPtr(button) && self [[button]]() )

#define COLOR_BLACK 	0
#define COLOR_RED 		1
#define COLOR_GREEN 	2
#define COLOR_YELLOW 	3
#define COLOR_BLUE 		4
#define COLOR_CYAN 		5
#define COLOR_MAGENTA 	6
#define COLOR_WHITE 	7
#define COLOR_MYTEAM 	8
#define COLOR_ENEMYTEAM	9

// in order of severity
#define S_ERROR 	COLOR_RED
#define S_WARNING 	COLOR_YELLOW
#define S_INFO 		COLOR_GREEN
#define S_DEBUG 	COLOR_CYAN
#define S_TRACE 	COLOR_WHITE
