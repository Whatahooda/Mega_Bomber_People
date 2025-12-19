enum UI_MENU
{
	MAIN,
	PLAYERSETUP,
	HIDE
}

global.UI_LAYERS = [
	"UIMenuMain",
	"UIMenuPlayerSetup"
]

global.menu_current = UI_MENU.HIDE;
global.menu_previous = UI_MENU.HIDE;

///	@function	UIChangeMenu(_ui_menu)
///	@param	{Enum.UI_MENU}	_ui_menu
///	@desc	Description
function UIChangeMenu(_ui_menu)
{
	if (_ui_menu < 0 || _ui_menu > UI_MENU.HIDE)
	{
		show_debug_message("WARNING	Undefined UI Menu type provided for menu chanage");
		return;
	}
	
	if (global.menu_current != UI_MENU.HIDE)
	{
		var _layer = layer_get_id(global.UI_LAYERS[global.menu_current]);
		if (debug_mode) show_debug_message("Hiding Layer: " + global.UI_LAYERS[global.menu_current] + " - " + string(_layer));
		layer_set_visible(_layer, false);
	}
	if (_ui_menu != UI_MENU.HIDE)
	{
		var _layer = layer_get_id(global.UI_LAYERS[_ui_menu]);
		if (debug_mode) show_debug_message("Showing Layer: " + global.UI_LAYERS[_ui_menu] + " - " + string(_layer));
		layer_set_visible(_layer, true);
	}
	
	objWhataGUIController.UIGroupLoad(_ui_menu);
	global.menu_previous = global.menu_current;
	global.menu_current = _ui_menu;
}
