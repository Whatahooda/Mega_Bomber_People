draw_self();

draw_set_font(fnt_buttons);
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (ready) draw_text(x, y, text_ready);
else draw_text(x, y, text_not_ready);