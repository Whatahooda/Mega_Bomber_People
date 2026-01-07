global.playing_game = false;
global.TILE_SIZE = 16;

global.loaded_level = undefined;
global.layer_actors = "Actors";
global.layer_breakables = "Breakables";
global.layer_danger = "Danger";

//	We need to manually save room dimensions, as gamemaker does not have a getter for non active rooms
room_dimensions = ds_map_create();
ds_map_add(room_dimensions, room_map_basic, [336, 208]);

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
	if (!is_undefined(global.loaded_level)) show_error("Loading Level while another is still loaded", true);
	
	global.loaded_level = RoomLoader.Load(_room, _x, _y);
	global.loaded_level.DepthAbove("Payloads");
	
	// Change Tilemap
	var _tsmap_walls = global.loaded_level.GetTilemap("EnvironmentWalls");
	var _tsmap_floor = global.loaded_level.GetTilemap("EnvironmentFloor");
	
	tilemap_tileset(_tsmap_walls, _tileset);
	tilemap_tileset(_tsmap_floor, _tileset);
	
	// Change Camera Center
	var _loaded_level_dimensions = ds_map_find_value(room_dimensions, _room);
	objCameraParent.target_x = _loaded_level_dimensions[0] / 2;
	objCameraParent.target_y = _loaded_level_dimensions[1] / 2;
	objCameraParent.true_x = _loaded_level_dimensions[0] / 2;
	objCameraParent.true_y = _loaded_level_dimensions[1] / 2;
	
	UpdateGlobalLayers(global.loaded_level);
	
	// Spawning
	var _actors_layer = global.loaded_level.GetLayer("Actors");
	var _elements = layer_get_all_elements(_actors_layer);
	
	for (var i = 0; i < array_length(_elements); i++) {
		var _element = _elements[i];
	    if (layer_get_element_type(_element) != layerelementtype_instance) continue;
		
		var _instance = layer_instance_get_instance(_element);
		if (_instance.object_index == obj_spawner_player && InputPlayerIsConnected(_instance.player_number))
		{
			_instance.SpawnFunction();
		}
	}
	
	var _test = 0;
}

///	@function	UpdateGlobalLayers(_level_payload)
///	@param	{Struct}	_level_payload
///	@desc	Description
function UpdateGlobalLayers(_level_payload)
{
	if (is_undefined(_level_payload))
	{
		global.layer_actors = "Actors";
		global.layer_breakables = "Breakables";
		global.layer_danger = "Dangers";
	}
	else
	{
		global.layer_actors = _level_payload.GetLayer("Actors");
		global.layer_breakables = _level_payload.GetLayer("Breakables");
		global.layer_danger = _level_payload.GetLayer("Dangers");
	}
}


RoomLoader.DataInit(room_map_basic);
