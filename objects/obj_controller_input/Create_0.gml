///	This Controller handles player input, including for multiple players

player_is_connected = array_create(INPUT_MAX_PLAYERS, false);

input_functions = array_create(INPUT_VERB.COUNT, function(){});

input_functions[INPUT_VERB.RIGHT] = function(_player){objWhataGUIController.UIGroupNavigate(0, _player)};
input_functions[INPUT_VERB.UP] = function(_player){objWhataGUIController.UIGroupNavigate(1, _player)};
input_functions[INPUT_VERB.LEFT] = function(_player){objWhataGUIController.UIGroupNavigate(2, _player)};
input_functions[INPUT_VERB.DOWN] = function(_player){objWhataGUIController.UIGroupNavigate(3, _player)};
input_functions[INPUT_VERB.ACCEPT] = function(_player){objWhataGUIController.UIGroupActivate(true, _player)};

player_setup_boxes = array_create(4, noone);

InputPlayerSetDevice(INPUT_KBM, 0); // Keyboard is always considered Player 1

InputPartySetParams(INPUT_VERB.JOIN, 1, 4, false, undefined, undefined, false);
InputPartySetJoin(false);
