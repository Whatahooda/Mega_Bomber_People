life_time += sprite_get_number(sprite_index) / sprite_get_speed(sprite_index);

var _ts = time_source_create(time_source_game, life_time, time_source_units_seconds, function(){instance_destroy(self);});
time_source_start(_ts);