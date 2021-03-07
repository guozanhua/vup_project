#region 初始化配置，可重复
#region 区别配置项
	hspd=1;
	vspd=9;
	lspd=3; //爬梯子速度
	cspd=2.5;
	walkspd=3;
	dashspd=6;
	G_noliq=GRAV; //非水下重力
	G_liq=GRAV/2; //水下重力
	G=G_noliq;
	vspmaxrate=20; //下落最大速度是G的多少倍
	A_up=0;
	H=1;
	V=1;
	grav=G-A_up;
	dash_can=1; //可以冲刺
	craw_can=1; //可以爬墙
	swim_can=1; //可以下水
	ice_free=0; //不打滑
	water_free=0; //水下速度自由
	lightrad=96; //黑暗中光圈直径
	bbox_ground_yup=0; //检测墙壁时冲刺特殊情况用
	
	enemylist=ds_list_create()
	bulletlist=ds_list_create()
	bosslist=ds_list_create()
	pricklist = ds_list_create()
	windlist = ds_list_create()
#endregion
#region 精灵
	var modelname
	if object_index==obj_player_hu modelname="hu"
	else if object_index==obj_player_armor modelname="armor"
	/*else if object_index==obj_player_xz modelname="x"
	else if object_index==obj_player_hz modelname="h"
	else if object_index==obj_player_lz modelname="l"
	else if object_index==obj_player_fz modelname="f"
	else if object_index==obj_player_pz modelname="p"
	else if object_index==obj_player_oz modelname="o"*/
	#region 基础动作
		SS_idle=asset_get_index(string_replace("spr_player_@_idle","@",modelname))
		SS_idle2=asset_get_index(string_replace("spr_player_@_idle2","@",modelname))
		SS_walk=asset_get_index(string_replace("spr_player_@_walk","@",modelname))
		SS_dash=asset_get_index(string_replace("spr_player_@_dash","@",modelname))
		SS_dashed=asset_get_index(string_replace("spr_player_@_dashed","@",modelname))
		SS_jump=asset_get_index(string_replace("spr_player_@_jump","@",modelname))
		SS_jumping=asset_get_index(string_replace("spr_player_@_jumping","@",modelname))
		SS_jumped=asset_get_index(string_replace("spr_player_@_jumped","@",modelname))
		SS_fall=asset_get_index(string_replace("spr_player_@_fall","@",modelname))
		SS_fallover=asset_get_index(string_replace("spr_player_@_fallover","@",modelname))
		SS_craw=asset_get_index(string_replace("spr_player_@_craw","@",modelname))
		SS_crawing=asset_get_index(string_replace("spr_player_@_crawing","@",modelname))
		SS_crawjump=asset_get_index(string_replace("spr_player_@_crawjump","@",modelname))
		//SS_ladupst=asset_get_index(string_replace("spr_player_@_ladupst","@",modelname))
		//SS_laddownst=asset_get_index(string_replace("spr_player_@_laddownst","@",modelname))
		//SS_lad=asset_get_index(string_replace("spr_player_@_lad","@",modelname))
		//SS_ladupover=asset_get_index(string_replace("spr_player_@_ladupover","@",modelname))
		//SS_laddownover=asset_get_index(string_replace("spr_player_@_laddownover","@",modelname))
		SS_injure_fall=asset_get_index(string_replace("spr_player_@_injure_fall","@",modelname))
		SS_injure1=asset_get_index(string_replace("spr_player_@_injure1","@",modelname))
		SS_injure2=asset_get_index(string_replace("spr_player_@_injure2","@",modelname))
		SS_death=asset_get_index(string_replace("spr_player_@_death","@",modelname))
		SS_talk=asset_get_index(string_replace("spr_player_@_talk","@",modelname))
		SS_talking=asset_get_index(string_replace("spr_player_@_talking","@",modelname))
		SS_talked=asset_get_index(string_replace("spr_player_@_talked","@",modelname))
		//SS_change=asset_get_index(string_replace("spr_player_@_change","@",modelname))
		//SS_changing=asset_get_index(string_replace("spr_player_@_changing","@",modelname))
		//SS_changing2=asset_get_index(string_replace("spr_$_changing2","$",charname))//用人形
		//SS_changed=asset_get_index(string_replace("spr_player_@_changed","@",modelname))
		//SS_change_air=asset_get_index(string_replace("spr_player_@_change_air","@",modelname))
		//SS_changing_air=asset_get_index(string_replace("spr_player_@_changing_air","@",modelname))
		//SS_changing2_air=asset_get_index(string_replace("spr_$_changing2_air","$",charname))//用人形
		//SS_changed_air=asset_get_index(string_replace("spr_player_@_changed_air","@",modelname))
		SS_doorup=asset_get_index(string_replace("spr_player_@_doorup","@",modelname))
		//SS_squat=asset_get_index(string_replace("spr_player_@_squat","@",modelname))
		//SS_squating=asset_get_index(string_replace("spr_player_@_squating","@",modelname))
		//SS_squating2=asset_get_index(string_replace("spr_player_@_squating2","@",modelname))
		//SS_squated=asset_get_index(string_replace("spr_player_@_squated","@",modelname))
		SS_trip=asset_get_index(string_replace("spr_player_@_trip","@",modelname))
		SS_climb=asset_get_index(string_replace("spr_player_@_climb","@",modelname))
		//SS_drop=asset_get_index(string_replace("spr_player_@_drop","@",modelname))
		//SS_droping=asset_get_index(string_replace("spr_player_@_droping","@",modelname))
		//SS_droped=asset_get_index(string_replace("spr_player_@_droped","@",modelname))
	#endregion
	#region 人类动作
		SS_creep=asset_get_index(string_replace("spr_player_@_creep","@",modelname))
		SS_creeping=asset_get_index(string_replace("spr_player_@_creeping","@",modelname))
		SS_creeped=asset_get_index(string_replace("spr_player_@_creeped","@",modelname))
		SS_float=asset_get_index(string_replace("spr_player_@_float","@",modelname))
		SS_swim=asset_get_index(string_replace("spr_player_@_swim","@",modelname))
		SS_swiming=asset_get_index(string_replace("spr_player_@_swiming","@",modelname))
		SS_injure3=asset_get_index(string_replace("spr_player_@_injure3","@",modelname))
		SS_lwalk=asset_get_index(string_replace("spr_player_@_lwalk","@",modelname))
	#endregion
	#region 枪击动作
		SS_idle_shoot=asset_get_index(string_replace("spr_player_@_idle_shoot","@",modelname))
		SS_idle_shoot2=asset_get_index(string_replace("spr_player_@_idle_shoot2","@",modelname))
		SS_walk_shoot=asset_get_index(string_replace("spr_player_@_walk_shoot","@",modelname))
		SS_walk_shoot1=asset_get_index(string_replace("spr_player_@_walk_shoot1","@",modelname))
		SS_walk_shoot2=asset_get_index(string_replace("spr_player_@_walk_shoot2","@",modelname))
		SS_dash_shoot=asset_get_index(string_replace("spr_player_@_dash_shoot","@",modelname))
		SS_jump_shoot=asset_get_index(string_replace("spr_player_@_jump_shoot","@",modelname))
		SS_fall_shoot=asset_get_index(string_replace("spr_player_@_fall_shoot","@",modelname))
		SS_craw_shoot=asset_get_index(string_replace("spr_player_@_craw_shoot","@",modelname))
		//SS_lad_shoot=asset_get_index(string_replace("spr_player_@_lad_shoot","@",modelname))
	#endregion
	#region
	#endregion
	scr_sprite_change(SS_idle,0,0.25)
#endregion
#region 能否蓄力
	uncharge[1]=true
	uncharge[2]=true
	sub_unuse=true
	charge_max=100//蓄力最大值，默认100，X150
#endregion
#region 身体替换颜色
	//base_cols=scr_color_mapping_get(0, 0)
	//需要替换的颜色，子对象具体设置
	//ex_cols=array_create(array_length(base_cols),$000000)
	//替换后的颜色
	//cols=noone
#endregion
#region 残影替换颜色
	//需要替换的颜色，子对象具体设置
	//after_ex_cols=array_copy_all(ex_cols)
	//替换出来的残影颜色，每种模式是不同的
	//after_cols=array_copy_all(ex_cols)
#endregion
#region 声音
	SE_dash=se_player_dash
	SE_jump=se_player_jump
	SE_crawjump=se_player_crawjump
	SE_injure1=se_player_injure1
	SE_injure2=se_player_injure2
	SE_death=se_player_death
	SE_transon=se_player_transon
#endregion
#region 快捷变身替换特殊精灵
	SS_EX_idle=[]
	SS_EX_walk=[]
	SS_EX_dash=[]
	SS_EX_jump=[]
	SS_EX_fall=[]
	SS_EX_craw=[]
	SS_EX_lad=[]
#endregion
//以下部分不可重复
if(variable_instance_exists(id, "initized")) exit;
initized=1;
#endregion
#region 基础属性
sprite_set_speed(sprite_index,0.25,spritespeed_framespergameframe);
scr_menu_var();
walk=0;
jump=0;
hsp=0;
vsp=0;
dash=0;
dash_time_l=0; //左冲刺指令
dash_time_r=0; //右冲刺指令
dash_time_t=0; //上冲刺指令
dash_time_b=0; //下冲刺指令
dash_order_time_H=0;
dash_order_time_V=0;
dash_order_alarm=15;
dash_boost_inst=noone; //冲刺环
w_j=0;
afterdash=8;
jump_dash=0;
jump_craw=0;
l_dash=0;
l_dashup=30;
meet_prick=noone; //碰到的尖刺
injure_level=0; //无敌等级
injure_t=0; //受伤计时
uninjure=0; //无敌状态
injure_ingrd=false; //受伤动作中落地
injure_element=ELEMENTS.none; //被特殊攻击效果，值为none，ice，push，absorb
element=ELEMENTS.none; //自身属性
ice_time=0; //被冰冻时间
ice_time_up=60*3;
wind_spd=0; //风速
wind_spd_i=0; //风速外控接口
//wind_up=0; //是否遇到上升气流
ice=0;
v_ice=0;
h_ice=0.1; //精度
f_ice=0.1; //摩擦力
x_last=x; 
y_last=y; 
imx_last=image_xscale; 
imy_last=image_yscale; 
dis_x=0; 
dis_y=0; 
water=0; //是否入水
flyobj=-1; //接触飞行物体
waterboost=0;
underwater=0;
trip_time=0; //摔倒时间计时
trip_time_up=90; //摔倒时间上限
craw_trip_time=0; //爬墙震倒计算时间
cliff_protect=false; //悬崖保护
cliff_protect_time=0; //悬崖保护时间
twining_time=0; //蛛网缠绕时间

cyber_death_action=0; //电子空间免死保护动作
cyber_death_time=0;

//上一帧的精灵
sprite_per=noone
sprite_part=noone
sprite_frtpart=noone
#endregion
#region 蓄力
//蓄力属性
charge[1]=0;
charge[2]=0;
charge_break[1]=0;
charge_break[2]=0;
charge_index[1]=0;
charge_index[2]=0;
#endregion
#region 残影
//残影位置
for(var i=8;i>=0;i-=1){
	px[i]=x;
	py[i]=y;
}
#endregion
#region 部分需要通用的变量
airdashed=0; //冲刺次数限制
#endregion
#region 事件
//清空子弹信息
clearBullets = function() {
	
}
//空中根据是否冲刺设置速度
dashHspeed = function(dir) {
	if(dash==0) hsp=dir*walkspd*hspd;
	else if(dash==1) hsp=dir*dashspd*hspd;
}
//根据是否滑冰设置速度，icestart为滑冰初速度过低条件
iceHspeed = function(icestart) {
	if(ice==0) {
		dashHspeed(1);
	} else if(ice==1) {
		if(icestart) 
			hsp=1*hspd;
		else
			hsp=image_xscale*dis_x*hspd;
	}
}
#endregion