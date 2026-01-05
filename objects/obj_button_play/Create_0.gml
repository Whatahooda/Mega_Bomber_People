// Inherit the parent event
event_inherited();

ButtonOnClick = function()
{
	UIChangeMenu(UI_MENU.PLAYERSETUP);
	obj_controller_input.SetConnectingPlayers(true);
}
