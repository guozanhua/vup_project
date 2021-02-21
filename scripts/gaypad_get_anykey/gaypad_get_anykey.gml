/// @function gaypad_get_anykey(getpad)
/// @arg getpad 含有十字键
function gaypad_get_anykey(getpad) {
	//-4无手柄
	//-1无按键
	//其他为返回按键
	var gaypad=global.joy;
	if gaypad=-4 return -4;
	if gamepad_button_check_pressed(gaypad,gp_face1)
		return gp_face1
	else if gamepad_button_check_pressed(gaypad,gp_face2)
		return gp_face2
	else if gamepad_button_check_pressed(gaypad,gp_face3)
		return gp_face3
	else if gamepad_button_check_pressed(gaypad,gp_face4)
		return gp_face4
	else if gamepad_button_check_pressed(gaypad,gp_select)
		return gp_select
	else if gamepad_button_check_pressed(gaypad,gp_start)
		return gp_start
	else if gamepad_button_check_pressed(gaypad,gp_stickl)
		return gp_stickl
	else if gamepad_button_check_pressed(gaypad,gp_stickr)
		return gp_stickr
	else if gamepad_button_check_pressed(gaypad,gp_shoulderl)
		return gp_shoulderl
	else if gamepad_button_check_pressed(gaypad,gp_shoulderlb)
		return gp_shoulderlb
	else if gamepad_button_check_pressed(gaypad,gp_shoulderr)
		return gp_shoulderr
	else if gamepad_button_check_pressed(gaypad,gp_shoulderrb)
		return gp_shoulderrb
	else if getpad{
		if gamepad_button_check_pressed(gaypad,gp_padl)
			return gp_padl
		else if gamepad_button_check_pressed(gaypad,gp_padr)
			return gp_padr
		else if gamepad_button_check_pressed(gaypad,gp_padu)
			return gp_padu
		else if gamepad_button_check_pressed(gaypad,gp_padd)
			return gp_padd
	}
	else return -1
}
