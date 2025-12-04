

///	@function	DefaultFunction(_param)
///	@param	{Type}	_param
///	@desc	Description
function BreakableDestroy()
{
	instance_create_layer(SnapToGrid(x, SNAP_TO.CENTER), SnapToGrid(y, SNAP_TO.CENTER), "Breakables", obj_breakable_destruction);
	instance_destroy(self);
}
