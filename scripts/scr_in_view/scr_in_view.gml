/// @arg edge
function scr_in_view(edge) {
	var _xl=min(bbox_left,x),_xr=max(bbox_right,x),_yt=min(bbox_top,y),_yb=max(bbox_bottom,y)
	if bbox_left=bbox_right
	|| bbox_top=bbox_bottom{
		_xl=x
		_xr=x
		_yt=y
		_yb=y
	}
	if _xl>=view_xpos(0)-edge && _xr<=view_xpos(0)+view_wpos(0)+edge
	&& _yt>=view_ypos(0)-edge && _yb<=view_ypos(0)+view_hpos(0)+edge
		return true
	else
		return false
}
/// @arg x
/// @arg y
/// @arg edge
function scr_in_view_arg(xx, yy, edge) {
	if xx>=view_xpos(0)-edge && xx<=view_xpos(0)+view_wpos(0)+edge
	&& yy>=view_ypos(0)-edge && yy<=view_ypos(0)+view_hpos(0)+edge
		return true
	else
		return false
}
function scr_full_in_view(view, xoff, yoff) {
	var vl,vr,vt,vb;
	vl=view_xpos(view)-xoff
	vr=view_xpos(view)+view_wpos(view)+xoff
	vt=view_ypos(view)-yoff
	vb=view_ypos(view)+view_hpos(view)+yoff

	var 
	xl=x+image_xscale*(-sprite_xoffset),
	xr=x+image_xscale*(-sprite_xoffset+sprite_width),
	yt=y+image_yscale*(-sprite_yoffset),
	yb=y+image_yscale*(-sprite_yoffset+sprite_height)

	if collision_double_rectangle(xr,yb,xl,yt,vr,vb,vl,vt)
		return true
	else
		return false
}
