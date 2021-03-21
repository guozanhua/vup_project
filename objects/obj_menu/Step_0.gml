if scr_menu_trem() scr_time_alarm()
if menutime>0 menutime--
else menutime=0
#region 屏幕光暗
////变身
//if global.rockon_flash=1{//变白
//	if global.rockon_flash_rate<1
//		global.rockon_flash_rate+=0.25
//	else
//		global.rockon_flash=2
//}
//else if global.rockon_flash=2{//持续
//	if global.rockon_flash_rate<2.5
//		global.rockon_flash_rate+=0.25
//	else
//		global.rockon_flash=3
//}
//else if global.rockon_flash=3{//恢复
//	if global.rockon_flash_rate>0
//		global.rockon_flash_rate-=0.25
//	else
//		global.rockon_flash=0
//}
//变黑
if global.room_change==1{
	if global.room_change_rate[1]<1
		global.room_change_rate[1]+=0.05
	else {
		global.room_change=2
		global.room_change_rate[1]=1
	}
}
else if global.room_change==2{
	if global.room_change_rate[1]>0
		global.room_change_rate[1]-=0.05
	else {
		global.room_change=0
		global.room_change_rate[1]=0
	}
}
//变白
if global.room_change==3{
	if global.room_change_rate[2]<1
		global.room_change_rate[2]+=0.05
	else {
		global.room_change=4
		global.room_change_rate[2]=1
	}
}
else if global.room_change==4{
	if global.room_change_rate[2]>0
		global.room_change_rate[2]-=0.05
	else {
		global.room_change=0
		global.room_change_rate[2]=0
	}
}
#endregion
#region 菜单开闭
//变黑
if menu_open_action==1{
	if menu_open_rate<1
		menu_open_rate+=0.05
	else {
		menu_open_action=2
		menu_open_rate=1
	}
}
else if menu_open_action==2{
	if menu_open_rate>0
		menu_open_rate-=0.05
	else {
		menu_open_action=0
		menu_open_rate=0
	}
}
#endregion
#region 菜单切页
//变黑
if menu_page_change==1{
	if menu_page_change_rate<1
		menu_page_change_rate+=0.05
	else {
		menu_page_change=0
		menu_page_change_rate=0
	}
}
else if menu_page_change==-1{
	if menu_page_change_rate>-1
		menu_page_change_rate-=0.05
	else {
		menu_page_change=0
		menu_page_change_rate=0
	}
}
#endregion
#region 菜单操作
if global.menu==1 {
	//切页
	if menu_type==0 && menu_page_change==0 {
		if keystate_check_pressed(global.L_state) {
			menu_page_change=1
			menu_page-=1
			scr_sound_play(se_menu_change)
		} else if keystate_check_pressed(global.R_state) {
			menu_page_change=-1
			menu_page+=1
			scr_sound_play(se_menu_change)
		}
		if menu_page<0 
			menu_page=menu_page_count-1
		else if menu_page>=menu_page_count 
			menu_page=0
	}
}
#endregion