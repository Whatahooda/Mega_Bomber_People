///	This object is the parent for Spawners.

//	spawn_obect
//	The object/instance to spawn at this location
//	*NOTE	The sprite should be 16x16 with a Centered origin

//	spawn_count
//	How many objects are spawned here

//	spawn_delay
//	The time before the initial and proceeding spawns
//	Set to -1 to prevent automatic spawning

//	start_on_create
//	When true, the spawner will start counting down to spawn when the room starts
//	When false, it must be started manually by calling SpawnCreateInstance()

//	destroy_old_spawns
//	If True, any spawned instance that still exists during the next spawn will be destroyed

last_instance = noone;
current_count = spawn_count;

///	@function	SpawnCreateInstance()
///	@return	{ID.Instance}
///	@desc	Overridable function in case of need for setting instance variables
function SpawnCreateInstance()
{
	return instance_create_layer(x, y, layer, spawn_object);
}

///	@function	SpawnFunction()
///	@desc	Callback for the Spawn Time Source
function SpawnFunction()
{
	if (destroy_old_spawns && instance_exists(last_instance)) instance_destroy(last_instance);
	last_instance = SpawnCreateInstance()
	current_count--;
	
	if (current_count > 0)
	{
		if (spawn_delay > 0) time_source_start(time_source_spawn);
		else SpawnFunction();
	}
}

time_source_spawn = undefined;
if (spawn_delay > 0) time_source_spawn = time_source_create(time_source_game, spawn_delay, time_source_units_seconds, SpawnFunction);
