PLAYER_SPRITES_IDLE = [
	spr_KDCPlayer01,
	spr_KDCPlayer02,
	spr_KDCPlayer03,
	spr_KDCPlayer04,
	spr_KDCPlayer05,
	spr_KDCPlayer06,
	spr_KDCPlayer07,
	spr_KDCPlayer08,
	spr_KDCPlayer09,
	spr_KDCPlayer10,
	spr_KDCPlayer11,
];

PLAYER_SPRITES_COUNT = array_length(PLAYER_SPRITES_IDLE);

// Player information:
// device
players = array_create(0);
for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
{
	array_push(players, new PlayerProfile(0));
}

///	@function	PlayerProfile(_sprite)
///	@param	{Real}	_sprite_number	The number representing the players sprite
///	@desc	Represents a player, their customizations and progress
function PlayerProfile(_sprite_number) constructor
{
	player_sprite_number = _sprite_number
}