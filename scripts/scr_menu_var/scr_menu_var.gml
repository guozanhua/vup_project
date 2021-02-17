///@desc 暂停需要的变量
function scr_menu_var() {
	menu_imspd=0
	/*menu_hspd=0
	menu_vspd=0*/
	menu_spd=0
	menu_grav=0
	menu_phspd=0
	menu_frict=0
	time=0
	scr_sprite_change(-2,-2,0.25)
}
//是否非暂停
function scr_menu_trem() {
	if global.stop=0
	|| global.stop=-0.5
		return true
	else
		return false
}
//进出暂停
function scr_menu_stop() {
	//进入暂停
	if global.stop=0.5{
		menu_spd=speed
		speed=0
		menu_grav=gravity
		gravity=0
		menu_phspd=path_speed
		path_speed=0
		menu_frict=friction
		friction=0
		menu_imspd=image_speed
		//主角变身相关
		image_speed=0
	}
	//恢复游戏
	else if global.stop=-0.5{
		speed=menu_spd
		gravity=menu_grav
		path_speed=menu_phspd
		friction=menu_frict
		//主角变身相关
		image_speed=menu_imspd
	}
}

