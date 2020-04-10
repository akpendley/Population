/// @func Log( string )
/// @desc logs a debug message
/// @arg string to log

var s = argument0;
show_debug_message(s);

if (is_string(s))
{
	// good
	ds_list_add(global.logList, s);
}
else
{
	show_debug_message("Send me a string next time");
	//game_end()
}
