/// @arg gaypad
function scr_gaypad_direct_state(gaypad) {
	var axisldir=global.axisL_direct,
		axislpos=global.axisL_position;
	///////////////////////////////////////////////
	if gamepad_button_check(gaypad,gp_padl)
	|| (cos_de(axisldir)<=-cos_de(67.5) && axislpos>=axis_min){
		if global.left_allstate[1]<=0 global.left_allstate[1]=1
		else if global.left_allstate[1]=1 global.left_allstate[1]=2
	}
	else{
		if global.left_allstate[1]>0 global.left_allstate[1]=-1
		else if global.left_allstate[1]=-1 global.left_allstate[1]=0
	}
	///////////////////////////////////////////////
	if gamepad_button_check(gaypad,gp_padr)
	|| (cos_de(axisldir)>=cos_de(67.5) && axislpos>=axis_min){
		if global.right_allstate[1]<=0 global.right_allstate[1]=1
		else if global.right_allstate[1]=1 global.right_allstate[1]=2
	}
	else{
		if global.right_allstate[1]>0 global.right_allstate[1]=-1
		else if global.right_allstate[1]=-1 global.right_allstate[1]=0
	}
	///////////////////////////////////////////////
	if gamepad_button_check(gaypad,gp_padu)
	|| (sin_de(axisldir)>=sin_de(22.5) && axislpos>=axis_min){
		if global.up_allstate[1]<=0 global.up_allstate[1]=1
		else if global.up_allstate[1]=1 global.up_allstate[1]=2
	}
	else{
		if global.up_allstate[1]>0 global.up_allstate[1]=-1
		else if global.up_allstate[1]=-1 global.up_allstate[1]=0
	}
	///////////////////////////////////////////////
	if gamepad_button_check(gaypad,gp_padd)
	|| (sin_de(axisldir)<=-sin_de(22.5) && axislpos>=axis_min){
		if global.down_allstate[1]<=0 global.down_allstate[1]=1
		else if global.down_allstate[1]=1 global.down_allstate[1]=2
	}
	else{
		if global.down_allstate[1]>0 global.down_allstate[1]=-1
		else if global.down_allstate[1]=-1 global.down_allstate[1]=0
	}
}