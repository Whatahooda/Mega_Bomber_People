///	@function	DrawSpriteFromTileSet(_tile_set_sprite, _tile_size, _row, _col, _pos_x, _pos_y, [_scale_x], [_scale_y], [_color], [_alpha])
///	@param	{Asset.GMSprite}	_tile_set_sprite
///	@param	{Real}	_tile_size
///	@param	{Real}	_row
///	@param	{Real}	_col
///	@param	{Real}	_pos_x
///	@param	{Real}	_pos_y
///	@param	{Real}	[_scale_x]
///	@param	{Real}	[_scale_y]
///	@param	{Type}	[_color]
///	@param	{Real}	[_alpha]
///	@desc	Description
function DrawSpriteFromTileSet(_tile_set_sprite, _tile_size, _row, _col, _pos_x, _pos_y, _scale_x = image_xscale, _scale_y = image_yscale, _color = image_blend, _alpha = image_alpha)
{
	draw_sprite_part_ext(_tile_set_sprite, 0, _tile_size * _col, _tile_size * _row, _tile_size, _tile_size, _pos_x, _pos_y, _scale_x, _scale_y, _color, _alpha);
}


///	@function	SnapToGrid(_position, [_grid_size])
///	@param	{Real}	_position
///	@param	{Real}	[_grid_size]
///	@desc	Takes the position, and returns the closest positions aligned with the grid size
function SnapToGrid(_position, _grid_size = global.TILE_SIZE)
{
	return GetGridPosition(_position, _grid_size) * _grid_size;
}

///	@function	GetGridPosition(_position)
///	@param	{Real}	_position
///	@param	{Real}	[_grid_size]
function GetGridPosition(_position, _grid_size = global.TILE_SIZE)
{
	return (_position + _grid_size / 2) div _grid_size;
}
