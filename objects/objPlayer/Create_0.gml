event_inherited();

can_bomb = true;
my_id = 0;

function GetPlayerInput()
{
	var _direction = BinaryInputToVector(InputCheck(INPUT_VERB.UP), InputCheck(INPUT_VERB.DOWN), InputCheck(INPUT_VERB.LEFT), InputCheck(INPUT_VERB.RIGHT));
	return _direction;
}

GetMoveDirection = GetPlayerInput;

function ActorState()
{	
	var _move_direction = GetMoveDirection();
	if (_move_direction.magnitude != 0)
	{
		MoveEntity(_move_direction);
		// Snap to integer value position
		x = round(x);
		y = round(y);
	}
	
	if (can_bomb && InputCheck(INPUT_VERB.ACCEPT) && place_empty(SnapToGrid(x), SnapToGrid(y), obj_bomb))
	{
		can_bomb = false;
		var _ts = time_source_create(time_source_game, .5, time_source_units_seconds, function(){can_bomb = true;});
		time_source_start(_ts);
		
		SpawnItem(x, y, true, ITEM.BOMB, my_id, []);
	}
}

EntityState = ActorState;