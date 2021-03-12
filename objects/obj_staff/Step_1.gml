x=obj_player.x
y=obj_player.y

////////////////////////////////////////
///////////////按键控制//////////////////
////////////////////////////////////////
scr_staff_key_state()
#region 自带计帧
if scr_menu_trem(){
	global.fps_currmenu++
	global.fps_roommenu++
}
global.fps_curr++
global.fps_60+=1
global.fps_30+=1
global.fps_20+=1
global.fps_15+=1
global.fps_12+=1
global.fps_10+=1
global.fps_6+=1
global.fps_5+=1
global.fps_4+=1
global.fps_3+=1
global.fps_2+=1
global.fps_1+=1
////////////////////////////////////////
if global.fps_60>=1 global.fps_60=0
if global.fps_30>=2 global.fps_30=0
if global.fps_20>=3 global.fps_20=0
if global.fps_15>=4 global.fps_15=0
if global.fps_12>=5 global.fps_12=0
if global.fps_10>=6 global.fps_10=0
if global.fps_6>=10 global.fps_6=0
if global.fps_5>=12 global.fps_5=0
if global.fps_4>=15 global.fps_4=0
if global.fps_3>=20 global.fps_3=0
if global.fps_2>=30 global.fps_2=0
if global.fps_1>=60{
	global.fps_1=0
	global.second++
}
if global.second>=60{
	global.second=0
	global.minute++
}
if global.minute>=60{
	global.minute=0
	global.hour++
}
global.hour=global.hour mod 100
#endregion
#region 根据道具数核对hpmp上限
//var oldmap=global.player_mp_up
//global.player_hp_up=16+4*scr_item_hpup_count()
//global.player_mp_up=16+4*scr_item_mpup_count()
#endregion
#region 玩家数值控制
if global.player_hp>global.player_hp_up
	global.player_hp=global.player_hp_up
else if global.player_hp<0
	global.player_hp=0
	
if global.player_hp_aft<global.player_hp
	global.player_hp_aft=global.player_hp
else if global.player_hp_aft>global.player_hp {
	global.player_hp_aft-=1/5
}

if global.player_mp>global.player_mp_up
	global.player_mp=global.player_mp_up
else if global.player_mp<0
	global.player_mp=0
#endregion
#region 游戏暂停
switch(global.stop){
	case 0.5:{
		global.stop=1
		break
	}
	case -0.5:{
		global.stop=0
		break
	}
}
#endregion