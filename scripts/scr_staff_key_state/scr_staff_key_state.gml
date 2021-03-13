function scr_staff_key_state() {
	//查看是否存在游戏把子
	global.joy=-4
	for(var i=0;i<gamepad_get_device_count();i+=1){
		if gamepad_is_connected(i){
			global.joy=i
			//gamepad_set_axis_deadzone(i, axis_min)
			break
		}
	}
#region 各种键状态集合
#region 键盘控制
	global.left_allstate[0]=scr_key_state(global.left_allstate[0],global.left_key)
	global.right_allstate[0]=scr_key_state(global.right_allstate[0],global.right_key)
	global.up_allstate[0]=scr_key_state(global.up_allstate[0],global.up_key)
	global.down_allstate[0]=scr_key_state(global.down_allstate[0],global.down_key)
	global.select_allstate[0]=scr_key_state(global.select_allstate[0],global.select_key)
	global.start_allstate[0]=scr_key_state(global.start_allstate[0],global.start_key)
	
	global.A_allstate[0]=scr_key_state(global.A_allstate[0],global.A_key)
	global.B_allstate[0]=scr_key_state(global.B_allstate[0],global.B_key)
	global.X_allstate[0]=scr_key_state(global.X_allstate[0],global.X_key)
	global.Y_allstate[0]=scr_key_state(global.Y_allstate[0],global.Y_key)
	global.L_allstate[0]=scr_key_state(global.L_allstate[0],global.L_key)
	global.R_allstate[0]=scr_key_state(global.R_allstate[0],global.R_key)
	
	global.att_allstate[0]=scr_key_state(global.att_allstate[0],global.att_key)
	global.jump_allstate[0]=scr_key_state(global.jump_allstate[0],global.jump_key)
	global.dash_allstate[0]=scr_key_state(global.dash_allstate[0],global.dash_key)
	global.sub_allstate[0]=scr_key_state(global.sub_allstate[0],global.sub_key)
	global.trans_allstate[0]=scr_key_state(global.trans_allstate[0],global.trans_key)
	global.true_allstate[0]=scr_key_state(global.true_allstate[0],global.true_key)
	global.tformL_allstate[0]=scr_key_state(global.tformL_allstate[0],global.tformL_key)
	global.tformR_allstate[0]=scr_key_state(global.tformR_allstate[0],global.tformR_key)
#endregion
#region 手柄操作
	if gaypad_exists(){
		var gaypad=global.joy
		//左摇杆
		scr_gaypad_axis_direct(gaypad, gp_stickl)
		//右摇杆
		scr_gaypad_axis_direct(gaypad, gp_stickr)
		//左摇杆&十字键控制方向
		scr_gaypad_direct_state(gaypad)
	
		global.select_allstate[1]=scr_gaypad_state(gaypad,global.select_allstate[1],gp_select)
		global.start_allstate[1]=scr_gaypad_state(gaypad,global.start_allstate[1],gp_start)
	
		global.A_allstate[1]=scr_gaypad_state(gaypad,global.A_allstate[1], gp_a)
		global.B_allstate[1]=scr_gaypad_state(gaypad,global.B_allstate[1], gp_b)
		global.X_allstate[1]=scr_gaypad_state(gaypad,global.X_allstate[1], gp_x)
		global.Y_allstate[1]=scr_gaypad_state(gaypad,global.Y_allstate[1], gp_y)
		global.L_allstate[1]=scr_gaypad_state(gaypad,global.L_allstate[1], [gp_l, gp_zl])
		global.R_allstate[1]=scr_gaypad_state(gaypad,global.R_allstate[1], [gp_r, gp_zr])
	
		global.att_allstate[1]=scr_gaypad_state(gaypad,global.att_allstate[1],global.att_joy)
		global.jump_allstate[1]=scr_gaypad_state(gaypad,global.jump_allstate[1],global.jump_joy)
		global.dash_allstate[1]=scr_gaypad_state(gaypad,global.dash_allstate[1],global.dash_joy)
		global.sub_allstate[1]=scr_gaypad_state(gaypad,global.sub_allstate[1],global.sub_joy)
		global.trans_allstate[1]=scr_gaypad_state(gaypad,global.trans_allstate[1],global.trans_joy)
		global.true_allstate[1]=scr_gaypad_state(gaypad,global.true_allstate[1],global.true_joy)
		global.tformL_allstate[1]=scr_gaypad_state(gaypad,global.tformL_allstate[1],global.tformL_joy)
		global.tformR_allstate[1]=scr_gaypad_state(gaypad,global.tformR_allstate[1],global.tformR_joy)
	} else {
		global.axisL_direct=-1
		global.axisR_direct=-1
		global.axisL_position=0
		global.axisR_position=0
	
		global.left_allstate[1]=0
		global.right_allstate[1]=0
		global.up_allstate[1]=0
		global.down_allstate[1]=0
		global.select_allstate[1]=0
		global.start_allstate[1]=0
	
		global.A_allstate[1]=0
		global.B_allstate[1]=0
		global.X_allstate[1]=0
		global.Y_allstate[1]=0
		global.L_allstate[1]=0
		global.R_allstate[1]=0
	
		global.att_allstate[1]=0
		global.jump_allstate[1]=0
		global.dash_allstate[1]=0
		global.sub_allstate[1]=0
		global.trans_allstate[1]=0
		global.true_allstate[1]=0
		global.tformL_allstate[1]=0
		global.tformR_allstate[1]=0
	}
#endregion
#endregion
	////////////////////////////////////////
#region 菜单操作
	global.Left_state = scr_allkey_state(global.left_allstate)
	global.Right_state = scr_allkey_state(global.right_allstate)
	global.Up_state = scr_allkey_state(global.up_allstate)
	global.Down_state = scr_allkey_state(global.down_allstate)
	global.Select_state = scr_allkey_state(global.select_allstate)
	global.Start_state = scr_allkey_state(global.start_allstate)
	
	global.A_state = scr_allkey_state(global.A_allstate)
	global.B_state = scr_allkey_state(global.B_allstate)
	global.X_state = scr_allkey_state(global.X_allstate)
	global.Y_state = scr_allkey_state(global.Y_allstate)
	global.L_state = scr_allkey_state(global.L_allstate)
	global.R_state = scr_allkey_state(global.R_allstate)
	
	//方向角度
	if keystate_check(global.Up_state){
		if keystate_check(global.Left_state) global.pad_direct=135
		else if keystate_check(global.Right_state) global.pad_direct=45
		else global.pad_direct=90
	} else if keystate_check(global.Down_state){
		if keystate_check(global.Left_state) global.pad_direct=225
		else if keystate_check(global.Right_state) global.pad_direct=315
		else global.pad_direct=270
	} else if keystate_check(global.Left_state) global.pad_direct=180
	else if keystate_check(global.Right_state) global.pad_direct=0
	else global.pad_direct=-1
	//鼠标状态
	global.Mleft_state=scr_mouse_state(global.Mleft_state,mb_left)
	global.Mright_state=scr_mouse_state(global.Mright_state,mb_right)
	global.Mmiddle_state=scr_mouse_state(global.Mmiddle_state,mb_middle)
	//滑轮状态
	if mouse_wheel_up() global.Mwheel_state=-1
	else if mouse_wheel_down() global.Mwheel_state=1
	else {
		//手柄右摇杆控制滑轮
		var gaypad = global.joy,
			axisrdir=global.axisR_direct,
			axisrpos=global.axisR_position;
		if gamepad_button_check(gaypad,gp_padu)
		|| (sin_de(axisrdir)>=sin_de(22.5) && axisrpos>=axis_min)
			global.Mwheel_state=1
		else if gamepad_button_check(gaypad,gp_padu)
		|| (sin_de(axisrdir)<=-sin_de(22.5) && axisrpos>=axis_min)
			global.Mwheel_state=-1
		else global.Mwheel_state=0
	}
	//鼠标坐标
	global.Mmouse_x=mouse_x
	global.Mmouse_y=mouse_y
#endregion
#region 玩家动作
#region 自由操作
	if global.operate==1
	&& global.player_operate==1{
		global.left_state = scr_allkey_state(global.left_allstate)
		global.right_state = scr_allkey_state(global.right_allstate)
		global.up_state = scr_allkey_state(global.up_allstate)
		global.down_state = scr_allkey_state(global.down_allstate)
		global.select_state = scr_allkey_state(global.select_allstate)
		global.start_state = scr_allkey_state(global.start_allstate)
	
		global.att_state = scr_allkey_state(global.att_allstate)
		global.jump_state = scr_allkey_state(global.jump_allstate)
		global.dash_state = scr_allkey_state(global.dash_allstate)
		global.sub_state = scr_allkey_state(global.sub_allstate)
		global.trans_state = scr_allkey_state(global.trans_allstate)
		global.true_state = scr_allkey_state(global.true_allstate)
		global.tformL_state = scr_allkey_state(global.tformL_allstate)
		global.tformR_state = scr_allkey_state(global.tformR_allstate)
		//自设按键恢复0
		global.left=0
		global.right=0
		global.up=0
		global.down=0
		global.jump=0
		global.att=0
		global.dash=0
		global.sub=0
		global.true=0
		global.trans=0
		global.select=0
		global.start=0
		global.tformL=0
		global.tformR=0
	}
#endregion
#region 脚本操纵
	else{
		global.left_state = scr_codekey_state(global.left_state, global.left)
		global.right_state = scr_codekey_state(global.right_state, global.right)
		global.up_state = scr_codekey_state(global.up_state, global.up)
		global.down_state = scr_codekey_state(global.down_state, global.down)
		global.jump_state = scr_codekey_state(global.jump_state, global.jump)
		global.att_state = scr_codekey_state(global.att_state, global.att)
		global.dash_state = scr_codekey_state(global.dash_state, global.dash)
		global.sub_state = scr_codekey_state(global.sub_state, global.sub)
		global.true_state = scr_codekey_state(global.true_state, global.true)
		global.trans_state = scr_codekey_state(global.trans_state, global.trans)
		global.select_state = scr_codekey_state(global.select_state, global.select)
		global.start_state = scr_codekey_state(global.start_state, global.start)
		global.tformL_state = scr_codekey_state(global.tformL_state, global.tformL)
		global.tformR_state = scr_codekey_state(global.tformR_state, global.tformR)
	}
#endregion
#region 按键判定延长
	if global.operate==1{
	#region 脚本操纵
		if global.player_operate==0{
			if keystate_check_pressed(global.jump_state) global.jump_cor=1
			else if keystate_check_direct(global.jump_state) global.jump_cor=5
			else if !keystate_check(global.jump_state) global.jump_cor=0
		
			if keystate_check_pressed(global.dash_state) global.dash_cor=1
			else if keystate_check_direct(global.dash_state) global.dash_cor=5
			else if !keystate_check(global.dash_state) global.dash_cor=0
		}
	#endregion
	#region 玩家操纵
		else if global.operate==1
		&& global.player_operate==1{
			//跳键
			if !keystate_check(global.jump_state)
				global.jump_cor=0
			else if keystate_check_pressed(global.jump_state)
				global.jump_cor=1
			else if keystate_check_direct(global.jump_state){
				if global.jump_cor<5 
					global.jump_cor++
			}
			//冲刺键
			if !keystate_check(global.dash_state)
				global.dash_cor=0
			else if keystate_check_pressed(global.dash_state)
				global.dash_cor=1
			else if keystate_check_direct(global.dash_state){
				if global.dash_cor<5 
					global.dash_cor++
			}
		}
	#endregion
	}
	else{
		global.jump_cor=0
		global.dash_cor=0
	}
	////////////////////////////////////////
#endregion
#endregion
#region 读取按键脚本
	//录像回放模式
	//if global.vedio_mode=1{
	//	//脚本记录非0的status变量，在这里将变量全部赋值出来
	//}
#endregion
#region 主副武器一键切换
	//if global.sub_type=2 
	//&& obj_player.sub_unuse=0{
	//	if keystate_check_pressed(global.sub_state)
	//	&& scr_player_stop_trem(){
	//		if global.sub_change[global.model]=0
	//			global.sub_change[global.model]=1
	//		else
	//			global.sub_change[global.model]=0
	//		scr_sound_menu_play(se_sub_change)
	//	}
	//}
	//else
	//	global.sub_change[global.model]=0
#endregion
}