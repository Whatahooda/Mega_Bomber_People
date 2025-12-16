event_inherited();

if (is_selected && draw_cursor)
{
	draw_set_color(text_color);
	draw_set_font(text_font);
	draw_set_halign(font_halign);
	draw_set_valign(font_valign);
	draw_text(x + text_paddingx + string_width(current_string), y + text_paddingy, text_cursor_character);
	draw_set_color(c_white);
}
