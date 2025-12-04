// Inherit the parent event
event_inherited();

///	@function	ActorDeath()
///	@desc	Default death for actors
function ActorDeath()
{
	instance_create_layer(SnapToGrid(x, SNAP_TO.CENTER), SnapToGrid(y, SNAP_TO.CENTER), "Breakables", obj_breakable_destruction);
	instance_destroy(self);
}

TriggerActorDeath = ActorDeath;