player_connected = false;
player_ready = false;
my_player = undefined;

image_index = 2;

///	@function	ConnectPlayer()
///	@desc	Description
function ConnectPlayer()
{
	image_index = 0;
	player_connected = true;
	player_ready = false;
}


if (player_number == 0) ConnectPlayer();

obj_controller_input.player_setup_boxes[player_number] = self.id;
my_player = obj_controller_players.player_profiles[player_number];
