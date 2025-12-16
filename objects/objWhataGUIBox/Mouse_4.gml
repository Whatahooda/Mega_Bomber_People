if (can_be_dragged)
{
	// Check to see if we are the front most
	var _closest_element = GetFrontInstance(mouse_x, mouse_y, objWhataGUIBox);

	// If we are the closest element, do stuff
	if (instance_exists(_closest_element) && _closest_element.id == self.id)
	{
		is_being_dragged = true;
		drag_rx = x - mouse_x;
		drag_ry = y - mouse_y;
	}
}