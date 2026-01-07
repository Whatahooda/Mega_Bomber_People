event_inherited();

can_bomb = true;

bomb_modifiers = new BombModifiers(my_id);
player_profile = obj_controller_players.player_profiles[my_id];
sprite_index = GetPlayerSpriteIdle(player_profile.player_sprite_number);

///	@function	PlayerDeath()
///	@desc	Called when a player dies
function PlayerDeath()
{
	obj_controller_game.PlayerDied(my_id);
	
	instance_create_layer(x, y, layer, obj_breakable_destruction, {sprite_index: spr_player_death, life_time: -0.05});
	instance_destroy(self);
}

TriggerActorDeath = PlayerDeath;


function GetPlayerInput()
{
	var _direction = BinaryInputToVector(InputCheck(INPUT_VERB.UP, my_id), InputCheck(INPUT_VERB.DOWN, my_id), InputCheck(INPUT_VERB.LEFT, my_id), InputCheck(INPUT_VERB.RIGHT, my_id));
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
	
	if (can_bomb && InputCheck(INPUT_VERB.ACCEPT, my_id) && place_empty(SnapToGrid(x), SnapToGrid(y), obj_bomb))
	{
		can_bomb = false;
		var _ts = time_source_create(time_source_game, .5, time_source_units_seconds, function(){can_bomb = true;});
		time_source_start(_ts);
		
		SpawnItem(x, y, SNAP_TO.CENTER, ITEM.BOMB, my_id, bomb_modifiers);
	}
}

EntityState = ActorState;