#region 记录玩家位移
global.player_dx=obj_player.x-player_x
global.player_dy=obj_player.y-player_y
player_x=obj_player.x
player_y=obj_player.y
#endregion
#region 镜头房间控制
//镜头偏移
if global.operate=1 && scr_menu_trem(){
	if(global.view_xcen_shift!=prev_view_xcen_shift){
		global.room_change_xl=1
		global.room_change_xr=1
	}
	if(global.view_ycen_shift!=prev_view_ycen_shift){
		global.room_change_yt=1
		global.room_change_yb=1
	}
	var posxy={
		x : obj_player.x+global.view_xcen_shift,
		y : obj_player.y+global.view_ycen_shift
	}
	scr_view_freedom(posxy,true,true)
	x=round(x)
	y=round(y)
	prev_view_xcen_shift=global.view_xcen_shift
	prev_view_ycen_shift=global.view_ycen_shift
}
//房间变换
if global.operate=1{
    if lastroom_xl>global.room_xl
        global.room_change_xl=1
    else if lastroom_xl<global.room_xl
        global.room_change_xr=1
    
    if lastroom_xr>global.room_xr
        global.room_change_xl=1
    else if lastroom_xr<global.room_xr
        global.room_change_xr=1

    if lastroom_yt>global.room_yt
        global.room_change_yt=1
    else if lastroom_yt<global.room_yt
        global.room_change_yb=1
    
    if lastroom_yb>global.room_yb
        global.room_change_yt=1
    else if lastroom_yb<global.room_yb
        global.room_change_yb=1
    
	if view_ypos(0)+view_hpos(0)/2<=y
		global.room_change_yt=0
	if view_ypos(0)+view_hpos(0)/2>=y
		global.room_change_yb=0
	if view_xpos(0)+view_wpos(0)/2<=x+4
	&& view_xpos(0)+view_wpos(0)/2>=x-4{
		global.room_change_xl=0
		global.room_change_xr=0
	}
}
else{
    global.room_change_xl=1
    global.room_change_xr=1
    global.room_change_yt=1
    global.room_change_yb=1
}
lastroom_xl=global.room_xl
lastroom_xr=global.room_xr
lastroom_yt=global.room_yt
lastroom_yb=global.room_yb
#endregion