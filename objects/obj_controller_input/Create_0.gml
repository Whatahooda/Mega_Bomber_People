///	This Controller handles player input, including for multiple players

is_connecting_players = false;

active_players = 1;
player_is_connected = array_create(INPUT_MAX_PLAYERS, false);
player_is_connected[0] = true;

input_functions = array_create(INPUT_VERB.COUNT, function(){});

input_functions[INPUT_VERB.RIGHT] = function(_player){objWhataGUIController.UIGroupNavigate(0, _player)};
input_functions[INPUT_VERB.UP] = function(_player){objWhataGUIController.UIGroupNavigate(1, _player)};
input_functions[INPUT_VERB.LEFT] = function(_player){objWhataGUIController.UIGroupNavigate(2, _player)};
input_functions[INPUT_VERB.DOWN] = function(_player){objWhataGUIController.UIGroupNavigate(3, _player)};
input_functions[INPUT_VERB.ACCEPT] = function(_player){objWhataGUIController.UIGroupActivate(true, _player)};

player_setup_boxes = array_create(4, noone);

///	@function	SetConnectingPlayers(_is_connecting)
///	@param	{Bool}	_is_connecting
///	@desc	Description
function SetConnectingPlayers(_is_connecting)
{
	InputSetHotswap(false);
	is_connecting_players = _is_connecting;
}

///	@function	CheckForPlayersConnecting()
///	@desc	Description
function CheckForPlayersConnecting()
{
	//var _most_recent_device = InputDeviceGetNewActivity();
	var _most_recent_device = InputDeviceGetNewActivityOnVerb(INPUT_VERB.JOIN);
	if (is_undefined(_most_recent_device) || !InputDeviceIsGamepad(_most_recent_device)) return;
	
	// Check for a new device and connect it as a new player
	if (InputDeviceGetPlayer(_most_recent_device) == undefined)
	{
		ConnectDevice(_most_recent_device);
		obj_player_setup_finished.UpdateReadyState();
	}
	
	// Check for a player and device disconnecting
	else
	{
		
	}
}

///	@function	ConnectDevice(_device)
///	@param	{Type}	_param
///	@desc	Description
function ConnectDevice(_device)
{
	var _player_without_device = -1;
	for (var i = 1; i < INPUT_MAX_PLAYERS; i++)
	{
		if (!InputPlayerIsConnected(i))
		{
			_player_without_device = i;
			break;
		}
	}
	InputPlayerSetDevice(_device, _player_without_device);
	player_setup_boxes[_player_without_device].ConnectPlayer();
}

InputPlayerSetDevice(INPUT_KBM, 0); // Keyboard is always considered Player 1
//InputSetHotswap(false);