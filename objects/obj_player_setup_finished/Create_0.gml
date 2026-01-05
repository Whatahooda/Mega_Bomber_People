draw_set_font(fnt_buttons);
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

text_not_ready = "All Players Need to be Ready";
text_ready = "Press Start to Continue";

text_not_ready_xscale = (string_width(text_not_ready) + 32) / sprite_get_width(sprite_index);
text_ready_xscale = (string_width(text_ready) + 32) / sprite_get_width(sprite_index);

ready = false;
image_xscale = text_not_ready_xscale;

///	@function	UpdateReadyState()
///	@desc	Description
function UpdateReadyState()
{
	var _players_connected = 0;
	var _players_ready = 0;
	
	var _player_slots = obj_controller_input.player_setup_boxes;
	for (var i = 0; i < array_length(_player_slots); i++)
	{
		var _slot = _player_slots[i];
		if (InputPlayerIsConnected(i)) _players_connected++;
		if (_slot.player_ready) _players_ready++;
	}
	
	ready = (_players_ready == _players_connected) && (_players_ready > 0);
	image_xscale = (ready) ? text_ready_xscale : text_not_ready_xscale;
	image_index = (ready) ? 1 : 0;
}