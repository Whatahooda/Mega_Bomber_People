if (life_time > 0)
{
	var _ts = time_source_create(time_source_game, life_time, time_source_units_seconds, function(){instance_destroy(self);});
	time_source_start(_ts);
}
else
{
	if (debug_mode) show_debug_message("Damage Box created with no life time.");
	instance_destroy();
}