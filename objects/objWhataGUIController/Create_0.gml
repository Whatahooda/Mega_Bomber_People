enum WhataGUIGroupInput
{
	RIGHT,
	UP,
	LEFT,
	DOWN
}

button_highlighted = noone;
button_group_loaded = [];

loaded_button_ui_group_id = -1;
loaded_default_button = noone;

ui_button_groups = ds_map_create();
ui_button_groups_default = ds_map_create();

button_currently_selected = noone;


///	@function	UIButtonNode(_button_instance, _ui_group)
///	@param	{Type}	_button_instance
///	@param	{Type}	_ui_group
///	@desc	A node to be represented in a button map for direction based input traversal
function UIButtonNode(_button_instance, _ui_group) constructor
{
	my_instance = _button_instance;
	pos_x = my_instance.x;
	pos_y = my_instance.y;
	ui_group = _ui_group;
	first_in_group = my_instance.first_in_group;
	
	// Each index represents the angle as: index * 90
	connections = array_create(4, self);
	
}



///	@function	CanIHighlight(_button, [_update_highlighted])
///	@param	{Id.Instance}	_button	Must be a objWhataGUIButton or child of such
///	@param	{Bool}	_update_highlighted
///	@desc	Mouse Only Function, returns false if there is another button "in front" of the provided button
///	@return	{Bool}
function CanIHighlight(_button, _update_highlighted = true)
{
	if (!instance_exists(_button)) return false;
	if (!instance_exists(button_highlighted) || _button.depth < button_highlighted.depth)
	{
		if (_update_highlighted) button_highlighted = _button;
		return true;
	}
	return false;
}

///	@function	NewButtonCreated(_button)
///	@param	{Id.Instance}	_button
///	@desc	Whenever a new button is created, process it
function NewButtonCreated(_button)
{
	// Don't worry about buttons not in a UI Group
	if (_button.ui_group == -1) return;
	
	if (!ds_map_exists(ui_button_groups, _button.ui_group)) ds_map_add(ui_button_groups, _button.ui_group, [_button]);
	else array_push(ds_map_find_value(ui_button_groups, _button.ui_group), _button);
	
	if (_button.first_in_group)
	{
		if (!ds_map_exists(ui_button_groups_default, _button.ui_group)) ds_map_add(ui_button_groups, _button.ui_group, _button);
		else ds_map_set(ui_button_groups_default, _button.ui_group, _button);
	}
}

///	@function	UIGroupShow(_ui_group, _visible)
///	@param	{Real}	_ui_group
///	@param	{Bool}	_visible
///	@desc	Description
function UIGroupShow(_ui_group, _visible)
{
	var _ui_group_array = ds_map_find_value(ui_button_groups, _ui_group);
	if (!ds_map_exists(ui_button_groups, _ui_group))
	{
		show_debug_message("WHATAGUI WARNING	Attempting to show an undefined UI Group: " + string(_ui_group));
		return;
	}
	
	for (var i = 0; i < array_length(_ui_group_array); i++)
	{
		var _button = _ui_group_array[i];
		_button.is_enabled = _visible;
		_button.visible = _visible;
	}
}


///	@function	UIGroupLoad(_ui_group)
///	@param	{Real}	_ui_group
///	@desc	Description
function UIGroupLoad(_ui_group)
{
	
	if (loaded_button_ui_group_id != -1) UIGroupShow(loaded_button_ui_group_id, false);
	if (_ui_group == -1)
	{
		loaded_button_ui_group_id = -1;
		loaded_default_button = undefined;
		return;
	}
	
	// Error check for non existent or empty group
	var _ui_group_exists = ds_map_exists(ui_button_groups, _ui_group);
	var _button_group = [];
	if (_ui_group_exists) _button_group = ds_map_find_value(ui_button_groups, _ui_group);
	if (!_ui_group_exists || array_length(_button_group) == 0)
	{
		show_debug_message("WHATAGUI WARNING	Attempting to load empty or undefined button group");
		return;
	}
	
	UIGroupShow(_ui_group, true);
	loaded_button_ui_group_id = _ui_group;
	button_group_loaded = _button_group;
	loaded_default_button = ds_map_find_value(ui_button_groups_default, _ui_group);
	if (!instance_exists(loaded_default_button)) loaded_default_button = button_group_loaded[0];
	show_debug_message("Loaded UI group " + string(_ui_group) + " with " + string(array_length(_button_group)) + " buttons");
}

///	@function	DefaultFunction(_param)
///	@param	{Type}	_param
///	@desc	Description
function UIGroupNavigate(_direction)
{
	show_debug_message("Navigating with " + string(_direction) + ", aka " + ["right", "up", "left", "down"][_direction]);
	
	
	if (!instance_exists(button_currently_selected)) button_currently_selected = loaded_default_button;
	else
	{
		var _options = [button_currently_selected.connection_right,
					button_currently_selected.connection_up,
					button_currently_selected.connection_left,
					button_currently_selected.connection_down];
		if (instance_exists( _options[_direction]))
		{
			// Un select previous button
			button_currently_selected.SetHighlight(false);
		
			// Pick new button
			// The Enum input represents the indexes here
			button_currently_selected = _options[_direction];
		}
	}
	
	// Highlight the button
	button_currently_selected.SetHighlight(true);
}

///	@function	UIGroupHoldButton()
///	@desc	Purely visual, starts to "hold down" the button
function UIGroupHoldButton()
{
	button_currently_selected.ButtonLeftPressed();
}


///	@function	UIGroupSelect()
///	@param	{Bool}	_is_held	If true will immediately activate the button, if false does the HELD DOWN highlight
///	@desc	Attempts to "click" the currently selected button
function UIGroupActivate(_activate_button)
{
	// If the current button isn't visibly selected, then re highlight it
	if (!button_currently_selected.is_highlighted) button_currently_selected.SetHighlight(true);
	else
	{
		button_currently_selected.button_held = true;
		button_currently_selected.ButtonLeftReleased(_activate_button);
	}
}

