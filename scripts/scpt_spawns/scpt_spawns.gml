enum ITEM
{
	BOMB
}

///	@function	SpawnItem(_x, _y, _snap_to_grid, _type, _owner, _modifiers)
///	@param	{Real}	_x
///	@param	{Real}	_y
///	@param	{Real}	_snap_to_grid	Enum.SNAP_TO, Snaps the position to the specified verb
///	@param	{Real}	_type	Enum.ITEM
///	@param	{Real}	_owner
///	@param	{Array}	_modifiers
///	@desc	Creates an item at the specified location, returning the instance ID of the created object
///	@return	{Id.Instance}
function SpawnItem(_x, _y, _snap_to_grid, _type, _owner, _modifiers)
{
	var _spawn_x = SnapToGrid(_x, _snap_to_grid);
	var _spawn_y = SnapToGrid(_y, _snap_to_grid);
	
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

///	@function	GenerateBombExplosion(_x, _y, _size)
///	@param	{Real}	_x
///	@param	{Real}	_y
///	@param	{Real}	_size	"radius" of the explosion horizontally and vertically, 0 is a single tile explosion
///	@desc	Creates an explosion in the pattern of a cross
function GenerateBombExplosion(_x, _y, _size)
{	
	// Create center tile
	SpawnExplosionTile(_x, _y, spr_explosion_center, 0);
	
	// Index 0 is 0 degrees, 1 is 90 degrees, etc
	var _direction_blocked = [false, false, false, false];
	
	// Keep generating explosions until we reach the radius, 
	for (var i = 1; i <= _size; i++)
	{
		var _sprite = spr_explosion_middle;
		if (i == _size) _sprite = spr_explosion_end;
		
		for (var _dir = 0; _dir < 4; _dir++)
		{
			// If we previously encountered a breakable, create no more explosions in that direction
			if (_direction_blocked[_dir]) continue;
			
			// TODO Trigger other bombs, don't create an explosion when one already exists on that tile
			var _explosion_x = _x + i * dcos(90 * _dir) * global.TILE_SIZE;
			var _explosion_y = _y + i * -dsin(90 * _dir) * global.TILE_SIZE;
			var _breakable_collision = instance_place(_explosion_x, _explosion_y, obj_breakable);
			var _is_direction_blocked = place_meeting(_explosion_x, _explosion_y, obj_solid);
			
			if (instance_exists(_breakable_collision))
			{
				_breakable_collision.BreakableDestroy();
				_is_direction_blocked = true;
			}
			if (_is_direction_blocked)
			{
				_direction_blocked[_dir] = true;
				continue;
			}
			
			SpawnExplosionTile(_explosion_x, _explosion_y, _sprite, _dir * 90);
		}
	}
}


///	@function	SpawnExplosionTile(_x, _y, _sprite, _rotation)
///	@param	{Real}	_x
///	@param	{Real}	_y
///	@param	{Asset.GMSprite}	_sprite		Explosion sprite: center, middle, end
///	@param	{Real}	_rotation
///	@desc	Creates a explosion tile at the specified position and other transformations
function SpawnExplosionTile(_x, _y, _sprite, _rotation)
{
	var _life_time = 0;
	if (sprite_exists(_sprite)) _life_time = sprite_get_number(_sprite) / sprite_get_speed(_sprite);
	instance_create_layer(_x, _y, "Dangers", obj_damage_box, {sprite_index: _sprite, image_angle: _rotation, life_time: _life_time});
}
