// Inherit the parent event
event_inherited();

function GetPlayerInput()
{
	var _direction = BinaryInputToVector(InputCheck(INPUT_VERB.UP), InputCheck(INPUT_VERB.DOWN), InputCheck(INPUT_VERB.LEFT), InputCheck(INPUT_VERB.RIGHT));
	return _direction;
}

GetMoveDirection = GetPlayerInput;