/// @desc 获得相机x坐标
/// @arg view
function view_xpos(view) {
	return camera_get_view_x(view_camera[view])
}
/// @desc 获得相机y坐标
/// @arg view
function view_ypos(view) {
	return camera_get_view_y(view_camera[view])
}
/// @desc 获得相机宽度
/// @arg view
function view_wpos(view) {
	return camera_get_view_width(view_camera[view])
}
/// @desc 获得相机高度
/// @arg view
function view_hpos(view) {
	return camera_get_view_height(view_camera[view])
}
/// @desc 相机x坐标增减
/// @arg view
/// @arg addx
function view_addx(addx) {
	obj_view.x+=addx
}
/// @desc 相机y坐标增减
/// @arg view
/// @arg addy
function view_addy(addy) {
	obj_view.y+=addy
}
/// @desc 相机x坐标设置
/// @arg view
/// @arg x
function view_setx(setx) {
	obj_view.x=setx+view_wpos(0)/2
}
/// @desc 相机y坐标设置
/// @arg view
/// @arg y
function view_sety(sety) {
	obj_view.y=sety+view_hpos(0)/2
}
