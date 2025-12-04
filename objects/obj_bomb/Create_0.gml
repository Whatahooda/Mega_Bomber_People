life_time = image_number / sprite_get_speed(sprite_index);

var _ts = time_source_create(time_source_game, life_time, time_source_units_seconds, function(){BombTrigger();});
time_source_start(_ts);

///	@function	DefaultFunction(_param)
///	@param	{Type}	_param
///	@desc	Called when the bomb blows up
function BombTrigger()
{
	// Bomb explosions animation?
	// Create explosion tiles/entities
	GenerateBombExplosion(x, y, bomb_range);
	// Destroy bomb
	instance_destroy(self);
}