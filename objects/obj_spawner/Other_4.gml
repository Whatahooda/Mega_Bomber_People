if (start_on_create)
{
	if (spawn_delay > 0) time_source_start(time_source_spawn);
	else SpawnFunction();
}
