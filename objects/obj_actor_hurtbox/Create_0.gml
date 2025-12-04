if (!instance_exists(owner))
{
	show_debug_message("WARNING Actor Hurtbox created without owner instance/actor");
	instance_destroy(self);
}