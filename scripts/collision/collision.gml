/// @function collision_double_rectangle(xr,yb,xl,yt,xr2,yb2,xl2,yt2)
/// @desc 检测两个矩形是否有碰撞（内含和相交）
/// @arg xr
/// @arg yb
/// @arg xl
/// @arg yt
/// @arg xr2
/// @arg yb2
/// @arg xl2
/// @arg yt2
function collision_double_rectangle(x1, y1, x2, y2, xx1,yy1,xx2,yy2) {
	return rectangle_in_rectangle(x1,y1,x2,y2,xx1,yy1,xx2,yy2)!=0
}
/// @function collision_rectangle_point(xr,yb,xl,yt,posx,posy)
/// @arg xr
/// @arg yb
/// @arg xl
/// @arg yt
/// @arg posx
/// @arg posy
function collision_rectangle_point(x1, x2, y1, y2, px, py) {
	if px>=x2 && px<=x1
	&& py>=y2 && py<=y1
	    return true
	else
	    return false
}
