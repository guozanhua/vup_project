#region 进入菜单
if global.operate==1 
&& global.player_operate==1
&& global.player_hp>0 {
	switch(global.menu) {
		case 0:{
			if global.stop==0
			&& keystate_check_pressed(global.start_state){
				global.menu=0.5
				global.stop=0.5
				menu_open_action=1
				menu_page=0
				menu_type=0
				menu_page_change=0
				menu_select[0,0]=1
			}
			break
		}
		case 0.5:{
			if menu_open_action==2
				global.menu=0.6
			break
		}
		case 0.6:{
			if menu_open_action==0
				global.menu=1
			break
		}
		case 1:{
			if(keystate_check_pressed(global.start_state)
			|| keystate_check_pressed(global.B_state))
			&& menu_type==0 {
				global.menu=-0.5
				menu_open_action=1
			}
			break
		}
		case -0.5:{
			if menu_open_action==2
				global.menu=-0.6
			break
		}
		case -0.6:{
			if menu_open_action==0{
				global.menu=0
				global.stop=-0.5
			}
			break
		}
	}
}
#endregion