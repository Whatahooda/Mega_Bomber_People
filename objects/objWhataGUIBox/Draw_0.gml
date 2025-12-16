draw_self();

draw_set_color(text_color);
draw_set_font(text_font);
draw_set_halign(font_halign);
draw_set_valign(font_valign);
draw_text(x + text_paddingx, y + text_paddingy, current_string);
draw_set_color(c_white);