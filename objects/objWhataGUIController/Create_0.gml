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

//button_currently_selected = noone;
buttons_currently_selected = array_create(INPUT_MAX_PLAYERS, noone);
player_in_control = 0;


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

///	@function	UIGroupNavigate(_direction, _player)
///	@param	{Real}	_direction
///	@param	{Real}	_player
///	@desc	Description
function UIGroupNavigate(_direction, _player)
{	
	var _player_button = buttons_currently_selected[_player];
	if (!instance_exists(_player_button))
	{
		array_set(buttons_currently_selected, _player, loaded_default_button);
		_player_button = buttons_currently_selected[_player];
	}
	else
	{
		var _options = [_player_button.connection_right,
					_player_button.connection_up,
					_player_button.connection_left,
					_player_button.connection_down];
		if (instance_exists( _options[_direction]))
		{
			// Un select previous button
			_player_button.SetHighlight(false);
		
			// Pick new button
			// The Enum input represents the indexes here
			//button_currently_selected = _options[_direction];
			array_set(buttons_currently_selected, _player, _options[_direction]);
		}
	}
	
	// Highlight the button
	buttons_currently_selected[_player].SetHighlight(true);
}

///	@function	UIGroupHoldButton()
///	@desc	Purely visual, starts to "hold down" the button
function UIGroupHoldButton()
{
	button_currently_selected.ButtonLeftPressed();
}


///	@function	UIGroupSelect()
///	@param	{Bool}	_is_held	If true will immediately activate the button, if false does the HELD DOWN highlight
///	@param	{Real}	_player	Specifies which player is activating a button
///	@desc	Attempts to "click" the currently selected button
function UIGroupActivate(_activate_button, _player = -1)
{
	// If the current button isn't visibly selected, then re highlight it
	if (!instance_exists(buttons_currently_selected[_player]))
	{
		array_set(buttons_currently_selected, _player, loaded_default_button);
		return;
	}
	var _player_button = buttons_currently_selected[_player];

	if (!_player_button.is_highlighted) _player_button.SetHighlight(true);
	else
	{
		if (_player == -1 || _player == _player_button.player_specific) _activate_button = false;
		_player_button.button_held = true;
		_player_button.ButtonLeftReleased(_activate_button);
	}
}

