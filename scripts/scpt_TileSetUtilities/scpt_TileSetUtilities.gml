///	@function	DefaultFunction(_param)
///	@param	{Type}	_param
///	@desc	Description
function DrawSpriteFromTileSet(_tile_set, _sub_image, _tile_size, _row, _col, _pos_x, _pos_y, _scale_x = image_xscale, _scale_y = image_yscale, _color = image_blend, _alpha = image_alpha)
{
	draw_sprite_part_ext(_tile_set_sprite, _sub_image, _tile_size * _col, _tile_size * _row, _tile_size, _tile_size, _pos_x, _pos_y, _scale_x, _scale_y, _color, _alpha);
}
