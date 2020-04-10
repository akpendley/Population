/// @description UI

// draw log window (WIP, want to make the width and height resizable in game)

// draw rectangle background
draw_set_color(c_white);
draw_rectangle(0, 0, room_width / 4, room_height, false);

if (ds_list_size(global.logList) > 0)
{
	var text = "";

	// put the 30 logs from our index (initially the end of the log list) in a string
	var index = ds_list_size(global.logList) - 1;
	var endIndex = clamp(index - 30, 0, index);

	if (index != endIndex)
	{
		for (var i = 0; i < ds_list_size(global.logList); i++)
		{
			var s = global.logList[| i];
			if (is_array(s))
			{
				show_debug_message(s[0]);
			}
			text += "\n" + global.logList[| i];
		}
	}

	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	draw_set_color(c_black);
	draw_text_ext(0, room_height, text, 50, room_width / 4);
}

// draw info right side

// simulation speed
draw_set_halign(fa_right);
draw_text(room_width, 15, "Years per Second: " + string(60 / simulateSpacer));
draw_text(room_width, 25, "Current Year: " + string(global.year));