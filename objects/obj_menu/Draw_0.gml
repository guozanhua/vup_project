#region 屏幕光暗
//if global.rockon_flash=1 || global.rockon_flash=2 || global.rockon_flash=3
//	scr_draw_rectangle_view(c_white,global.rockon_flash_rate,view_current)
if global.room_change>=1 && global.room_change<=2
	scr_draw_rectangle_view(c_black,global.room_change_rate[1],view_current)
if global.room_change>=3 && global.room_change<=4
	scr_draw_rectangle_view(c_white,global.room_change_rate[2],view_current)
#endregion