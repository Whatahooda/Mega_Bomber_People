// Inherit the parent event
event_inherited();
up_pressed = 0;
down_pressed = 0;
right_pressed = 0;
left_pressed = 0;

function GetPlayerInput()
{
	var _direction = BinaryInputToVector(up_pressed, down_pressed, left_pressed, right_pressed);
	return _direction;
}

