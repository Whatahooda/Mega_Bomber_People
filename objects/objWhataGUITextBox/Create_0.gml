event_inherited();

is_selected = false;
draw_cursor = false;
text_cursor_character = "|";

ts_cursor_method = function(){draw_cursor = !draw_cursor;};
time_source_cursor_flash = time_source_create(time_source_game, 1, time_source_units_seconds, ts_cursor_method, [], -1);

///	@function	GetTextBoxString()
///	@desc	Returns the current string held inside the text box
function GetTextBoxString()
{
	return current_string;
}
