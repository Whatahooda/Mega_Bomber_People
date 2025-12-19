event_inherited();

can_bomb = true;
my_id = 0;

bomb_modifiers = new BombModifiers(my_id);

///	@function	PlayerDeath()
///	@desc	Called when a player dies
function PlayerDeath()
{
	obj_controller_game.PlayerDied(my_id);
	
	instance_create_layer(x, y, "Actors", obj_breakable_destruction, {sprite_index: spr_player_death, life_time: -0.05});
	instance_destroy(self);
}

TriggerActorDeath = PlayerDeath;


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
		MoveActor(_move_direction);
	}
	
	if (can_bomb && InputCheck(INPUT_VERB.ACCEPT) && place_empty(SnapToGrid(x), SnapToGrid(y), obj_bomb))
	{
		can_bomb = false;
		var _ts = time_source_create(time_source_game, .5, time_source_units_seconds, function(){can_bomb = true;});
		time_source_start(_ts);
		
		SpawnItem(x, y, SNAP_TO.CENTER, ITEM.BOMB, my_id, bomb_modifiers);
	}
}

EntityState = ActorState;