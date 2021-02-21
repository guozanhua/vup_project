#region 镜头设置
//场景镜头
view={
	//显示尺寸
	width : 512,
	height : 288,
	//实际尺寸
	xport : 0,
	yport : 0,
	wport : 512,
	hport : 288,
}
ui={
	width : 2048,
	height : 1152,
	xport : 0,
	yport : 0,
	ports : [
		//{w:512, h:288},
		{w:1024, h:576},
		{w:1536, h:864},
		{w:1920, h:1080},
	],
}
view_visible[0]=true
camera_set_view_size(view_camera[0], view.width, view.height)
camera_set_view_border(view_camera[0], view.width/2, view.height/2)
camera_set_view_target(view_camera[0], self.id)
view_set_xport(0, view.xport)
view_set_yport(0, view.yport)
view_set_wport(0, view.wport)
view_set_hport(0, view.hport)
view0_surface_temp=noone
/*
由于要采用场景UI分开的方式绘制，使用方案如下：
游戏运行时镜头尺寸为512x288
PreDraw时变更为1920x1080
绘制时使用surface，获得实际场景图，然后只截取512x288的部分，拉伸为1920x1080
完成后，绘制UI
PostDraw后变回512x288
*/
view_visible[1]=true
camera_set_view_size(view_camera[1], ui.width, ui.height)
view_set_xport(1, ui.xport)
view_set_yport(1, ui.yport)
view_set_wport(1, ui.width)
view_set_hport(1, ui.height)

window_size=1
window_set_size(ui.ports[window_size].w, ui.ports[window_size].h)
#endregion
#region 小房间切分+镜头控制
global.room_xl=0
global.room_xr=room_width
global.room_yt=0
global.room_yb=room_height

global.view_control=0
global.view_shock=0

global.view_dx=0//镜头横向移速
global.view_dy=0//镜头纵向移速
global.view_xcen_shift=0//镜头中心偏移
global.view_ycen_shift=0//镜头中心偏移
prev_view_xcen_shift=0
prev_view_ycen_shift=0

view_oldx=view_xpos(0)
view_oldy=view_ypos(0)

view_shock_prex=view_xpos(0)
view_shock_prey=view_ypos(0)

lastroom_xl=0
lastroom_xr=0
lastroom_yt=0
lastroom_yb=0
global.room_change_xl=0
global.room_change_xr=0
global.room_change_yt=0
global.room_change_yb=0

global.view_hor=0
global.view_vor=0
_view_x=0
_view_y=0

global.player_dx=0
global.player_dy=0
player_x=0
player_y=0

_room_last=0

global.view_hsp=0
global.view_vsp=0
#endregion
#region 对话
global.talk=0//对话
#endregion
#region 房间存储
room_range_inst=noone //当前房间对应对象
room_range_sets=ds_map_create()
#endregion
#region 黑幕
black_surface=noone//黑幕surface
black_display=false//黑幕是否显示
black_alpha=1//黑幕百分比
black_alpha_step=0//增减幅度
black_inst=noone//黑幕操控实例
black_depth=30000//深度
//配置在黑幕中自动获得光源的Obj
map_inst_cleared=true//清理过了map中的实例
black_light_insts_set=ds_map_create() //map[? obj]=rad，rad=-1时按照精灵设置
//大于0为固定半径，0为没有，-1为自动设置
black_light_insts_set[? obj_player]="lightrad"
black_light_insts_set[? obj_player_bullet]=-1
black_light_insts_set[? obj_enemy]="lightrad"
black_light_insts_set[? obj_bullet]="lightrad"
black_light_followed_insts_list=ds_list_create() //跟踪对象的id集合
//跟踪玩家的光圈
black_light_player=noone
#endregion