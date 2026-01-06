if (ready && layer_get_visible(layer) && InputPressed(INPUT_VERB.PAUSE))
{
	// Hide this UI Page
	UIChangeMenu(UI_MENU.HIDE);
	
	// Create Level
	obj_controller_game.LoadLevel(room_map_basic, ts_environment_dirt);
	
	// Initiate Game
}