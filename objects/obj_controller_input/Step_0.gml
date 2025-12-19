if (global.menu_current != UI_MENU.HIDE)
{
	for (var _input = 0; _input < INPUT_VERB.COUNT; _input++)
	{
		if (InputCheck(_input))
		{
			if (!input_pressed[_input]) input_functions[_input]();
			input_pressed[_input] = true;
		}
		else input_pressed[_input] = false;
	}
	/*
	if (InputCheck(INPUT_VERB.RIGHT))
	{
		if (!pressed_right) objWhataGUIController.UIGroupNavigate(0);
		pressed_right = true;
	}
	else pressed_right = false;
	if (InputCheck(INPUT_VERB.UP))
	{
		if (!pressed_up) objWhataGUIController.UIGroupNavigate(1);
		pressed_up = true;
	}
	else pressed_up = false;
	if (InputCheck(INPUT_VERB.LEFT))
	{
		if (!pressed_left) objWhataGUIController.UIGroupNavigate(2);
		pressed_left = true;
	}
	else pressed_left = false;
	if (InputCheck(INPUT_VERB.DOWN))
	{
		if (!pressed_down) objWhataGUIController.UIGroupNavigate(3);
		pressed_down = true;
	}
	else pressed_down = false;
	*/
}