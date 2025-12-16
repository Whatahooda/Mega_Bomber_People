event_inherited();

draw_set_colour(c_red);
if (instance_exists(connection_right)) draw_arrow(x + 16, y + 16, connection_right.x, connection_right.y, 16);
if (instance_exists(connection_left)) draw_arrow(x + 16, y + 16, connection_left.x, connection_left.y, 16);
if (instance_exists(connection_up)) draw_arrow(x + 16, y + 16, connection_up.x, connection_up.y, 16);
if (instance_exists(connection_down)) draw_arrow(x + 16, y + 16, connection_down.x, connection_down.y, 16);