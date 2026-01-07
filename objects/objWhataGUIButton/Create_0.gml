event_inherited();

button_held = false;
is_highlighted = false;
default_sprite = sprite_index;

///	@function	SetHighlight(_is_highlighted)
///	@param	{Bool}	_is_highlighted
///	@desc	Highlights the button by changing the sprite or calling a custom function
function SetHighlight(_is_highlighted)
{
	if (!is_enabled) return;
	if (on_hover_sprite)
	{
		if (button_held) sprite_index = held_sprite;
		else if (_is_highlighted) sprite_index = highlighted_sprite;
		else sprite_index = default_sprite;
	}
	if (on_hover_custom) CustomHoverHighlight(_is_highlighted);
	is_highlighted = _is_highlighted;
}

CustomHoverHighlight = function(_is_highlighted){show_debug_message("WhataGUI: Custom highlight function not set for button.");};

///	@function	ButtonLeftPressed()
///	@desc	Function called when the button is about to be pressed
function ButtonLeftPressed()
{
	button_held = true;
	SetHighlight(true);
}


///	@function	ButtonLeftReleased()
///	@desc	Called when the button has been pressed and is then released
function ButtonLeftReleased(_activate_button)
{
	if (_activate_button && is_highlighted) ButtonOnClick();
	button_held = false;
	SetHighlight(is_highlighted);
}


// This function is called when the button is activated/clicked
ButtonOnClick = function() {show_debug_message("Button has been clicked.")};

ChangeTextFormat(text_font, fa_center, fa_middle, text_color);
objWhataGUIController.NewButtonCreated(self.id);
