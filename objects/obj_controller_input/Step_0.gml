if (global.menu_current != UI_MENU.HIDE)
{
	for (var _player = 0; _player < INPUT_MAX_PLAYERS; _player++)
	{
		for (var _input = 0; _input < INPUT_VERB.COUNT; _input++)
		{
			if (InputPressed(_input, _player))
			{
				show_debug_message("Player " + string(_player) + " input");
				input_functions[_input](_player);
			}
		}
	}
}

// Connect devices to players
if (is_connecting_players)
{
	CheckForPlayersConnecting();
}