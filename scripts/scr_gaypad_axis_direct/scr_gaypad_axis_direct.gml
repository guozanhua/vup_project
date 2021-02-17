/// @arg gaypad
/// @arg stick
function scr_gaypad_axis_direct(gaypad, stick) {
	var axish,axisv
	if stick = gp_stickl{
		axish = gp_axislh
		axisv = gp_axislv
	} else if stick = gp_stickr{
		axish = gp_axisrh
		axisv = gp_axisrv
	}
	var haxis=gamepad_axis_value(gaypad,axish),
		vaxis=gamepad_axis_value(gaypad,axisv),
		direct=point_direction(0,0,haxis,vaxis),
		position=point_distance(0,0,haxis,vaxis)
	if stick = gp_stickl{
		global.axisL_direct=direct
		global.axisL_position=position
	} else if stick = gp_stickr{
		global.axisR_direct=direct
		global.axisR_position=position
	}
}
