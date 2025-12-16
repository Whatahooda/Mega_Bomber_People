///	@function	DefaultFunction(_param)
///	@param	{Real}	_x
///	@param	{Real}	_y
///	@param	{Asset.GMObject}	_obj_check	The obj to check instances for, can be any
///	@desc	Checks the exact position provided and returns the instance with the lowest depth(closest to the camera)
function GetFrontInstance(_x, _y, _obj_check)
{
	var _found_instances = ds_list_create();
	var _instance_count = instance_position_list(_x, _y, _obj_check, _found_instances, false);

	var _front_most_instance = noone;

	for (var i = 0; i < _instance_count; i++)
	{
		var _instance = ds_list_find_value(_found_instances, i);
		if (!instance_exists(_front_most_instance) || _instance.depth < _front_most_instance.depth) _front_most_instance = _instance;
	}
	
	return _front_most_instance;
}