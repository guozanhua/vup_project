/// @arg edge
function scr_in_room(edge) {
	if x>=global.room_xl-edge && x<=global.room_xr+edge
	&& y>=global.room_yt-edge && y<=global.room_yb+edge
		return true
	else
		return false
}
/// @arg x
/// @arg y
/// @arg edge
function scr_in_room_arg(xx, yy, edge) {
	if xx>=global.room_xl-edge && xx<=global.room_xr+edge
	&& yy>=global.room_yt-edge && yy<=global.room_yb+edge
		return true
	else
		return false
}
/// @arg edge
function scr_in_roomall(edge) {
	if x>=0-edge && x<=room_width+edge
	&& y>=0-edge && y<=room_height+edge
		return true
	else
		return false
}
/// @arg x
/// @arg y
/// @arg edge
function scr_in_roomall_arg(xx, yy, edge) {
	if xx>=0-edge && xx<=room_width+edge
	&& yy>=0-edge && yy<=room_height+edge
		return true
	else
		return false
}
