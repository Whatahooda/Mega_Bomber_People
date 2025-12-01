///	@description	Base Object


/// Variables

/// Functions
///	@function	MoveEntity(_direction)
///	@param	{Struct.Vector2D}	_direction	Normalized 2D direction vector
///	@desc	Default function that moves the entity
function MoveEntity(_direction)
{
	var _x_speed = entity_speed * _direction.x * GetDeltaTimeSeconds();
	var _y_speed = entity_speed * _direction.y * GetDeltaTimeSeconds();
	move_and_collide(_x_speed, _y_speed, colliders);
}

///	@function	UpdateEntityMove(_direction)
///	@param	{Struct.Vector2D}	_direction	Normalized 2D direction vector
///	@desc	Applies movement to the entity
UpdateEntityMove = function(){}

UpdateEntityMove = MoveEntity;
