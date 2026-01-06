global.playing_game = false;
global.TILE_SIZE = 16;
loaded_level = undefined;

gpu_set_tex_filter(false);

///	@function	PlayerDied(_player_id)
///	@param	{Real}	_player_id
///	@desc	Called when a player dies, checks for stage/map end
function PlayerDied(_player_id)
{
	
}

///	@function	LoadLevel(_room, _tileset, [_x], [_y])
///	@param	{Asset.GMRoom}	_room
///	@param	{Asset.GMTileSet}	_tileset
///	@desc	Description
function LoadLevel(_room, _tileset, _x = 0, _y = 0)
{
	if (!is_undefined(loaded_level)) show_error("Loading Level while another is still loaded", true);
	
	loaded_level = RoomLoader.Load(_room, _x, _y);
	
	var _tsmap_walls = loaded_level.GetTilemap("EnvironmentWalls");
	var _tsmap_floor = loaded_level.GetTilemap("EnvironmentFloor");
	
	tilemap_tileset(_tsmap_walls, _tileset);
	tilemap_tileset(_tsmap_floor, _tileset);
}

RoomLoader.DataInit(room_map_basic);
