// Inherit the parent event
event_inherited();

///	@function	SpawnCreateInstance()
///	@return	{ID.Instance}
///	@desc	Overridable function in case of need for setting instance variables
SpawnCreateInstance = function()
{
	return instance_create_layer(x, y, layer, spawn_object, {my_id: player_number});
}
