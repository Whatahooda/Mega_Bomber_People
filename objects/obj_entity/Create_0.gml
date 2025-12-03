///	@description	Base Object


/// Variables


/// Functions

///	@function	GetMoveDirection()
///	@desc	Returns the direction for the actor to move in
///	@return	{Struct.Vector2D}
GetMoveDirection = function(){return new Vector2D(0, 0);}

///	@function	MoveEntity(_direction)
///	@param	{Struct.Vector2D}	_direction	Normalized 2D direction vector
///	@desc	Default function that moves the entity
function MoveEntity(_direction)
{
	var _x_speed = entity_speed * _direction.vx * GetDeltaTimeSeconds();
	var _y_speed = entity_speed * _direction.vy * GetDeltaTimeSeconds();
	var _collisions = move_and_collide(_x_speed, _y_speed, colliders);
}

///	@function	UpdateEntityMove(_direction)
///	@param	{Struct.Vector2D}	_direction	Normalized 2D direction vector
///	@desc	Applies movement to the entity
UpdateEntityMove = function(){}

UpdateEntityMove = MoveEntity;


///	@function	EntityDefaultState()
///	@param	{Struct.Vector2D}	_direction	Normalized 2D direction vector
///	@desc	Default function that moves the entity
function EntityDefaultState()
{
	var _move_direction = GetMoveDirection();
	if (_move_direction.magnitude != 0)
	{
		MoveEntity(_move_direction);
	}
}


EntityState = EntityDefaultState;

