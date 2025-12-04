// Inherit the parent event
event_inherited();

enum DANGER
{
	NOTHING,
	EXPLOSION,
	ACTOR_CONTACT
}

hurt_box = instance_create_layer(x, y, "Camera", obj_actor_hurtbox, {owner: self.id});

///	@function	ActorHurtDefault(_danger_type)
///	@param	{Real}	_danger_type Enum.DANGER
///	@desc	Triggers when the actor hurtbox collides with a danger
function ActorHurtDefault(_danger_type)
{
	if (_danger_type != DANGER.NOTHING) TriggerActorDeath();
}

ActorHurt = ActorHurtDefault;

///	@function	ActorDeath()
///	@desc	Default death for actors
function ActorDeath()
{
	instance_create_layer(x, y, "Breakables", obj_breakable_destruction);
	instance_destroy(self);
}

TriggerActorDeath = ActorDeath;

///	@function	MoveActor(_direction)
///	@param	{Struct.Vector2D}	_direction	Normalized 2D direction vector
///	@desc	Description
function MoveActor(_direction)
{
	MoveEntity(_direction);
	// Snap to integer value position
	x = round(x);
	y = round(y);
	hurt_box.x = x;
	hurt_box.y = y;
}

UpdateEntityMove = MoveActor;