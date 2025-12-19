///	This Controller handles player input, including for multiple players

//InputPartySetParams(INPUT_VERB.PAUSE, 1, 4, false, undefined, undefined, false);
//InputPartySetJoin(true);

pressed_right = false;
pressed_left = false;
pressed_up = false;
pressed_down = false;

input_pressed = array_create(INPUT_VERB.COUNT, false);

input_functions = array_create(INPUT_VERB.COUNT, function(){});

input_functions[INPUT_VERB.RIGHT] = function(){objWhataGUIController.UIGroupNavigate(0)};
input_functions[INPUT_VERB.UP] = function(){objWhataGUIController.UIGroupNavigate(1)};
input_functions[INPUT_VERB.LEFT] = function(){objWhataGUIController.UIGroupNavigate(2)};
input_functions[INPUT_VERB.DOWN] = function(){objWhataGUIController.UIGroupNavigate(3)};
input_functions[INPUT_VERB.ACCEPT] = function(){objWhataGUIController.UIGroupActivate(true)};