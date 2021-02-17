/// @arg color
/// @arg alpha
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
/// @arg outline
function scr_draw_rectangle(color, alpha, x1, y1, x2, y2, outline) {
	draw_set_alpha(alpha)
	draw_set_color(color)
	draw_rectangle(x1,y1,x2,y2,outline)
	draw_set_alpha(1)
	draw_set_color(c_white)
}
/// @arg color
/// @arg alpha
/// @arg view
function scr_draw_rectangle_view(color, alpha, view) {
	draw_set_alpha(alpha)
	draw_set_color(color)
	draw_rectangle(view_xpos(view)+view_wpos(view)*2,view_ypos(view)+view_hpos(view)*2,view_xpos(view)-view_wpos(view),view_ypos(view)-view_hpos(view),false)
	draw_set_alpha(1)
	draw_set_color(c_white)
}
