/// @description face

if (sprite_index == -1)
{
	// if the face hasn't been set yet do it now to avoid drawing a non-existing sprite (fatal error)
	sprite_index = GetAgedFace(face, age);
}
else
{
	draw_self();
}

if (!dragging && point_distance(mouse_x, mouse_y, x + sprite_width / 2, y + sprite_height / 2) <= sprite_width / 2)
{
	// hovering
	draw_set_color(c_black);
	draw_set_font(fBembo);
	draw_set_halign(fa_center);
	draw_text(x + sprite_width / 2, y - 10, name);
}