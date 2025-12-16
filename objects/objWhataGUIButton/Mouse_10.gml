// Search for all GUI elements that might be infront of us
var _found_instances = ds_list_create();
var _instance_count = instance_position_list(mouse_x, mouse_y, objWhataGUIBox, _found_instances, false);

var _front_most_instance = noone;

for (var i = 0; i < _instance_count; i++)
{
	var _instance = ds_list_find_value(_found_instances, i);
	if (!instance_exists(_front_most_instance) || _instance.depth < _front_most_instance.depth)
	{
		if (instance_exists(_front_most_instance) && (_front_most_instance.object_index == objWhataGUIButton || object_is_ancestor(_front_most_instance.object_index, objWhataGUIButton))) _front_most_instance.SetHighlight(false);
		if (_instance.object_index == objWhataGUIButton || object_is_ancestor(_instance.object_index, objWhataGUIButton)) _instance.SetHighlight(true);
		_front_most_instance = _instance;
	}
}
