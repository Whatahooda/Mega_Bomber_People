global.TILE_SIZE = 16;

gpu_set_tex_filter(false);


///	@function	PlayerDied(_player_id)
///	@param	{Real}	_player_id
///	@desc	Called when a player dies, checks for stage/map end
function PlayerDied(_player_id)
{
	
}

var _ts = time_source_create(time_source_game, 1, time_source_units_frames, function(){UIChangeMenu(UI_MENU.MAIN);});
time_source_start(_ts);
