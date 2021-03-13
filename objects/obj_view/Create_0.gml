#region 镜头设置
//场景镜头
view={
	//显示尺寸
	width : VIEW_W,
	height : VIEW_H,
	//实际尺寸
	xport : 0,
	yport : 0,
	wport : VIEW_W,
	hport : VIEW_H,
}
ui={
	width : VIEW_W_UI,
	height : VIEW_H_UI,
	xport : 0,
	yport : 0,
	ports : [
		//{w:VIEW_W_UI/4, h:VIEW_H_UI/4},
		{w: VIEW_W_UI/4*2, h: VIEW_H_UI/4*2},
		{w: VIEW_W_UI/4*3, h: VIEW_H_UI/4*3},
		{w: 1920, h: 1080},
	],
}
view0_surface_temp=noone
/*
由于要采用场景UI分开的方式绘制，使用方案如下：
游戏运行时镜头尺寸为512x288
PreDraw时变更为1920x1080
绘制时使用surface，获得实际场景图，然后只截取512x288的部分，拉伸为1920x1080
完成后，绘制UI
PostDraw后变回512x288
*/
window_size=0
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
#region 绘制函数
//血条
draw_hp = function(hp, hplenmax) {
	var hpw=sprite_get_width(spr_ui_grd_hp),
		hph=sprite_get_height(spr_ui_grd_hp),
		hplen=(hp/global.player_hp_up)*hplenmax,
		hpsurf=surface_create(hplenmax, hph);
	surface_set_target(hpsurf)
	draw_clear_alpha(c_white, 0)
	draw_sprite(spr_ui_grd_hp, 0, 0, 0)
	draw_sprite_ext(spr_ui_grd_hp, 1, hpw, 0, hplenmax/hpw, 1, 0, c_white, 1)
	gpu_set_blendmode_ext(bm_src_alpha, bm_zero)
	draw_set_alpha(0)
	draw_primitive_begin(pr_trianglestrip)
	draw_vertex(hplenmax, 0)
	draw_vertex(hplenmax, hph)
	draw_vertex(hplen-hph, hph)
	draw_vertex(hplen, 0)
	draw_vertex(hplenmax, 0)
	draw_primitive_end()
	draw_set_color_alpha_init()
	gpu_set_blendmode(bm_normal)
	surface_reset_target()
	return hpsurf
}
//能量条
draw_mp = function(mp, mplenmax) {
	var mpw=sprite_get_width(spr_ui_grd_mp),
		mph=sprite_get_height(spr_ui_grd_mp),
		mplen=(mp/global.player_mp_up)*mplenmax,
		mpsurf=surface_create(mplenmax, mph);
	surface_set_target(mpsurf)
	draw_clear_alpha(c_white, 0)
	draw_sprite(spr_ui_grd_mp, 0, 0, 0)
	draw_sprite_ext(spr_ui_grd_mp, 1, mpw, 0, mplenmax/mpw, 1, 0, c_white, 1)
	gpu_set_blendmode_ext(bm_src_alpha, bm_zero)
	draw_set_alpha(0)
	draw_primitive_begin(pr_trianglestrip)
	draw_vertex(mplenmax, 0)
	draw_vertex(mplenmax, mph)
	draw_vertex(mplen-mph, mph)
	draw_vertex(mplen, 0)
	draw_vertex(mplenmax, 0)
	draw_primitive_end()
	draw_set_color_alpha_init()
	gpu_set_blendmode(bm_normal)
	surface_reset_target()
	return mpsurf
}
#endregion
event_perform(ev_other, ev_room_start)