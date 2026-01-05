if (layer_get_visible(layer))
{
	if (InputPressed(INPUT_VERB.RIGHT, player_number))
	{
		my_player.player_sprite_number++;
		if (my_player.player_sprite_number >= obj_controller_players.PLAYER_SPRITES_COUNT) my_player.player_sprite_number = 0;
	}
	
	if (InputPressed(INPUT_VERB.LEFT, player_number))
	{
		my_player.player_sprite_number--;
		if (my_player.player_sprite_number < 0) my_player.player_sprite_number = obj_controller_players.PLAYER_SPRITES_COUNT - 1;
	}
	
	if (InputPressed(INPUT_VERB.ACCEPT, player_number))
	{
		player_ready = !player_ready;
		image_index = (player_ready) ? (1) : (0);
		obj_player_setup_finished.UpdateReadyState();
	}
}