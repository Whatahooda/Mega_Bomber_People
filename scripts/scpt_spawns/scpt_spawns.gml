enum ITEM
{
	BOMB
}

///	@function	SpawnItem(_x, _y, _snap_to_grid, _type, _owner, _modifiers)
///	@param	{Real}	_x
///	@param	{Real}	_y
///	@param	{Bool}	_snap_to_grid	Set to true to snap to the global grid
///	@param	{Real}	_type	Enum.ITEM
///	@param	{Real}	_owner
///	@param	{Array}	_modifiers
///	@desc	Creates an item at the specified location, returning the instance ID of the created object
///	@return	{Id.Instance}
function SpawnItem(_x, _y, _snap_to_grid, _type, _owner, _modifiers)
{
	var _spawn_x = _x;
	var _spawn_y = _y;
	if (_snap_to_grid)
	{
		_spawn_x = SnapToGrid(_x);
		_spawn_y = SnapToGrid(_y);
	}
	
	switch (_type) {
	    case ITEM.BOMB:
	        return SpawnBomb(_spawn_x, _spawn_y);
			
	    default:
	        return noone;
	}
}


///	@function	SpawnBomb(_x, _y)
///	@param	{Real}	_x
///	@param	{Real}	_y
///	@desc	Spawns a bomb
function SpawnBomb(_x, _y)
{
	return instance_create_layer(_x, _y, "Actors", obj_bomb);
}
