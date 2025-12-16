var _closest_element = GetFrontInstance(mouse_x, mouse_y, objWhataGUIBox);

// If we are the closest element, do stuff
if (instance_exists(_closest_element) && _closest_element.id == self.id)
{
	is_selected = true;
	draw_cursor = true;
	keyboard_string = current_string;
	time_source_start(time_source_cursor_flash);
}
else
{
	is_selected = false;
	time_source_stop(time_source_cursor_flash);
}