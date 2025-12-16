#macro TEXT_BASE_PADDING 8
// Array<Id.Instance> of objWhataGUIBox
child_elements = array_create(0);

is_being_dragged = false;
drag_rx = 0;
drag_ry = 0;

// Text Variables
current_string = "";
text_font = fntArialDefault;
font_halign = fa_left;
font_valign = fa_middle;
text_color = c_white;
text_paddingx = 0;
text_paddingy = 0;

///	@function	UpdatePosition(_x, _y)
///	@param	{Real}	_x
///	@param	{Real}	_y
///	@desc	Updates our position, and all child positions
function UpdatePosition(_x, _y)
{
	x = _x + relative_x;
	y = _y + relative_y;
	
	for (var i = 0; i < array_length(child_elements); i++)
	{
		var _child = array_get(child_elements, i);
		if (instance_exists(_child)) _child.UpdatePosition(x, y);
		else array_delete(child_elements, i--, 1);
	}
}

///	@function	ChangeVisuals(_width, _height, _size_relative_scale, _sprite_index)
///	@param	{Real}	_width
///	@param	{Real}	_height
///	@param	{Bool}	_size_relative_scalew
///	@param	{Bool}	_size_relative_scaleh
///	@param	{Asset.GMSprite}	_sprite_index	High recommended to be a Nine-Splice sprite
///	@desc	Changes the size and sprite of the GUI
function ChangeVisuals(_width, _height, _size_relative_scalew,_size_relative_scaleh, _sprite_index = sprite_index)
{
	if (_size_relative_scalew) width = parent_element.width * _width;
	else width = _width;
	if (_size_relative_scaleh) height = parent_element.height * _height;
	else height = _height;
	
	sprite_index = _sprite_index;
	image_xscale = width / sprite_width;
	image_yscale = height / sprite_height;
	
	ChangeTextPosition(0, 0);
	AutoTextPosition();
}

///	@function	ChangeTextFormat(_font, _haligh, _valign, _text_color, _auto_position)
///	@param	{Asset.GMFont}	_font
///	@param	{Constant.HAlign}	_haligh	
///	@param	{Constant.VAlign}	_valign 
///	@param	{Constant.Color}	_text_color
///	@param	{Bool}	_auto_position	Set to true to automatically position text in GUI box, defaults to true
///	@desc	Changes how text looks in the text box
function ChangeTextFormat(_font, _haligh, _valign, _text_color, _auto_position = true)
{
	text_font = _font;
	text_color = _text_color;
	font_halign = _haligh;
	font_valign = _valign;
	if (_auto_position) AutoTextPosition();
}

///	@function	AutoTextPosition()
///	@desc	Description
function AutoTextPosition()
{
	switch (font_halign) {
		case fa_left:
		    text_paddingx = TEXT_BASE_PADDING;
		    break;
		case fa_center:
		    text_paddingx = width / 2;
		    break;
		case fa_right:
		    text_paddingx = bbox_right - TEXT_BASE_PADDING;
		    break;
		
		default:
		    show_error("Undefined Font Alignment Constant, defaulting to fa_left", false);
			font_halign = fa_left;
			text_paddingx = font_get_size(text_font);
		    break;
	}
	
	switch (font_valign) {
		case fa_top:
		    text_paddingy = TEXT_BASE_PADDING;
		    break;
		case fa_middle:
		    text_paddingy = height / 2;
		    break;
		case fa_bottom:
		    text_paddingy = bbox_bottom - TEXT_BASE_PADDING;
		    break;
		
		default:
		    show_error("Undefined Font Alignment Constant, defaulting to fa_top", false);
			font_valign = fa_top;
			text_paddingy = font_get_size(text_font);
		    break;
	}
}

///	@function	ChangeTextPosition(_rx, _ry, _pos_relative_scale)
///	@param	{Real}	_rx	Relative x to create the child, can be 0 - 1 for relative scaled positioning
///	@param	{Real}	_ry	Relative y to create the child, can be 0 - 1 for relative scaled positioning
///	@param	{Bool}	_pos_relative_scalex	Set to true to position based on width and height of current element
///	@param	{Bool}	_pos_relative_scaley	Set to true to position based on width and height of current element
function ChangeTextPosition(_rx, _ry, _pos_relative_scalex = false, _pos_relative_scaley = _pos_relative_scalex)
{
	if (_pos_relative_scalex) _rx = width * _rx;
	if (_pos_relative_scaley) _ry = height * _ry;
	text_paddingx = _rx;
	text_paddingy = _ry;
}

///	@function	CreateChildElement(_rx, _ry, _whatagui_element_obj, _width, _height, _pos_relative_scale, _size_relative_scale)
///	@param	{Real}	_rx	Relative x to create the child, can be 0 - 1 for relative scaled positioning
///	@param	{Real}	_ry	Relative y to create the child, can be 0 - 1 for relative scaled positioning
///	@param	{Asset.GMObject}	_whatagui_element_obj	A object the is a objWhataGuiBox or any Child of it
///	@param	{Bool}	_pos_relative_scalex	Set to true to position based on width and height of current element
///	@param	{Bool}	_pos_relative_scaley	Set to true to position based on width and height of current element
///	@return	{Id.Instance}
///	@desc	Creates a new element that is anchored/attatched to this element
function CreateChildElement(_rx, _ry, _whatagui_element_obj, _pos_relative_scalex = false, _pos_relative_scaley = _pos_relative_scalex)
{
	
	if (_pos_relative_scalex) _rx = width * _rx;
	if (_pos_relative_scaley) _ry = height * _ry;
	var _child =  instance_create_layer(x + _rx, y + _ry, layer, _whatagui_element_obj, {
		relative_x: _rx, relative_y: _ry, parent_element: self.id, can_be_dragged: false, depth: depth - 1
	});
	array_push(child_elements, _child);
	return _child;
}

ChangeVisuals(width, height, false, false);
ChangeTextFormat(text_font, fa_left, fa_middle, c_white);