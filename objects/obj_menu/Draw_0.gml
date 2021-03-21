if view_current!=1 exit
#region 菜单页面
if global.menu=0.6 || global.menu=1 || global.menu=-0.5 {
	draw_sprite(spr_menu_bgs, 0, 0, 0)
	//切页
	var drawfuns = [
		scr_draw_menu_status,
		scr_draw_menu_item,
		scr_draw_menu_option,
		scr_draw_menu_mission,
		scr_draw_menu_skill
	],
		preinx = menu_page-1,
		nextinx = menu_page+1;
	if preinx<0 preinx=menu_page_count-1
	if nextinx>=menu_page_count nextinx=0
	var funnow = drawfuns[menu_page],
		funpre = drawfuns[preinx],
		funnext = drawfuns[nextinx];
	if menu_page_change==0 {
		funnow(0, 0)
	} else if menu_page_change==1 {
		funnow(VIEW_W_UI*(-1+menu_page_change_rate), 0)
		funnext(VIEW_W_UI*(0+menu_page_change_rate), 0)
	} else if menu_page_change==-1 {
		funnow(VIEW_W_UI*(1+menu_page_change_rate), 0)
		funpre(VIEW_W_UI*(0+menu_page_change_rate), 0)
	}
}
#endregion
#region 菜单光暗
if menu_open_action!=0
	scr_draw_rectangle_view(c_black, menu_open_rate ,view_current)
#endregion
#region 屏幕光暗
//if global.rockon_flash=1 || global.rockon_flash=2 || global.rockon_flash=3
//	scr_draw_rectangle_view(c_white,global.rockon_flash_rate,view_current)
if global.room_change>=1 && global.room_change<=2 {
	scr_draw_rectangle_view(c_black,global.room_change_rate[1],view_current)
}
if global.room_change>=3 && global.room_change<=4 {
	scr_draw_rectangle_view(c_white,global.room_change_rate[2],view_current)
}
#endregion