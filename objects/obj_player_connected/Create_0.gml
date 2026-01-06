player_connected = false;
player_ready = false;

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