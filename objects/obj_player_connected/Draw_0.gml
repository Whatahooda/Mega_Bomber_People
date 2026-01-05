draw_self();
if (!InputPlayerIsConnected(player_number)) draw_sprite_ext(spr_KDCPlayerSillouette, 0, x, y, 2, 2, 0, c_white, 1);
else draw_sprite_ext(GetPlayerSpriteIdle(my_player.player_sprite_number), 0, x, y, 2, 2, 0, c_white, 1);
