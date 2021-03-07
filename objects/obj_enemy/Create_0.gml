scr_menu_var();
scr_sprite_change(-2,-2,0.25);
/////////////////////////////////
if(!variable_instance_exists(id,"attack")) 
	attack=0;
attack_org=attack;
action=0;
hp_up=hp;
undm=0;
xsign=x; //走路前定位
ysign=y; //漂浮前定位
xrange=128; //走路行动范围（单方向）
ytange=32; //漂浮行动范围（单方向）
shoot=0; //射击/动作
injure_type=ATK_TYPE.bullet;
injure_unrepeat=0; //防重复伤害
injure_unrepeat_undm=0; //防重复无伤
undm_injure_type=ATK_TYPE.bullet; //无敌被击中类型
injure_element=ELEMENTS.none; //属性伤害
last_in_element=ELEMENTS.none; //收到攻击前的受伤属性
now_in_element=ELEMENTS.none; //本次受到的属性，仅记录用
element=ELEMENTS.none;
DEF=1;
flash=0;
inxscale=0;
element_index=0; //属性伤害计时
view=0;
view_edge=64; //进入视野边界范围
destory_edge=128; //出视野消灭范围
half_action=0; //半身动作0无，1击飞
dis_dir=0; //修改显示角度
new_self=noone; //刷新创建的对象
hited=0; //此帧是否被击中，0未击中，1击中，-1无敌击中，次变量用于杂兵动作判定
hitedstp=0; //延迟一帧记录用，防止击中和动作step顺序不一致，直接固定为先动作再击中，此变量用在玩家子弹中
death_use_speed_system=false; //死亡时都能使用移动系统
element_ssinjure=0; //属性攻击中
elenemt_recover=0; //属性攻击恢复
element_fire_time=0; //灼烧时间计算
damage_level=0; //伤害等级
//动作变量
hsp=0;
vsp=0;
G=GRAV;
grav=G;
vspmaxn=28;
hfrict=0; //横向摩擦力,负值即为加速度
vfrict=0; //横向摩擦力
trans_spd=0; //传送带速度
can_dmg=true; //可以被攻击
have_dmg=true; //有伤害
//爆过道具/是否爆道具(1不爆)
item=0;
//切割等待时间
wait_time=0;
//飞行物体
flyobj=noone;
//飞行敌人回归轨道
fall_return=0;
round_t=0;
#region 残影
for(var i=12;i>=0;i--){
	afimg_x[i]=x;
	afimg_y[i]=y;
}
//当前还残留的残影数
afimg_count_now=0;
//灰度变色残影
afimg_shader_color=noone; //残影shader
afimg_shader_lumin=noone; //残影shader
//替换颜色残影
afimg_ex_cols=array_create(20,$000000);
afimg_cols=array_create(20,$000000);
afimg_shader=noone;
whiteimage_time=0; //白影时间
#endregion
#region 预设精灵配置
SS_idle=spr_none;
SP_idle=0.25;
SS_injure=spr_none;
SS_death=spr_none;
SS_part=spr_none;
#endregion
/////////////////////////////////
#region 初始化记录
init_attrs=false;
init_x=x;
init_y=y;
init_depth=depth;
init_xscale=image_xscale;
init_yscale=image_yscale;
init_angle=image_angle;
init_alpha=image_alpha;
init_blend=image_blend;
#endregion
evuser2ed=false; //死亡时是否执行过2事件
/////////////////////////////////
#region 配置项
/// @arg enemy_type=0
enemy_type=0; //0地上1浮空
/// @arg enemy_ground=1
enemy_ground=1; //0无视墙壁，1接触墙壁
/// @arg enemy_prick=1
enemy_prick=1; //0无视尖刺，1碰尖刺爆
/// @arg death_xscale=1
death_xscale=true; //是否使用受伤对准的死亡方向
/// @arg auto_xscale=1
auto_xscale=true; //镜头外自动朝向玩家
/// @arg push_fly=0
push_fly=0; //是否被击飞，0为击中即飞且空血，1为空血即飞，2为不飞，3为击中即飞但不空血
/// @arg injure_back=true
injure_back=true; //受伤是否被击退
/// @arg injure_elementback=true
injure_elementback=true; //属性是否被击退
/// @arg injure_elementfall=true
injure_elementfall=true; //飞行属性被属性击中是否下落
/// @arg undm_push=true
undm_push=true; //无敌状态下能被击飞
/// @arg death_boom=false
death_boom=false; //死亡是否立刻爆炸
/// @arg death_type_use=1
death_type_use=true; //死亡爆炸效果使用
/// @arg enemy_or_bullet=1
enemy_or_bullet=true; //是子弹还是敌人
/// @arg boom_number=1
boom_number=1; //死亡爆炸数
/// @parga boom_type=0
boom_type=0; //死亡爆炸类型0普通1伤害
/// @arg death_repeat=1
death_repeat=true; //死亡后复活
/// @arg out_reflash=1
out_reflash=true; //出镜头刷新
/// @parga afterimage=false
afterimage=false; //是否使用残影
/// @parga afterimageflash=false
afterimageflash=true; //残影闪动
/// @parga afimg_step=0
afimg_step=0; //间隔多少个残影绘制一次
/// @parga afimg_count=0
afimg_count=0; //残影数量
/// @parga whiteimage=false
whiteimage=false; //是否使用白影
whiteimagecol=c_white; //白影颜色
/// @arg use_speed_system=1
use_speed_system=true; //是否采用运动系统
/// @arg use_death_system=1
use_death_system=true; //是否采用死亡系统
/// @trans_spd=true
//trans_spd=true; //是否收到传送带影响
/// @fire_boom=true
//fire_boom=true; //碰到燃烧的火是否爆炸
/// @element_size=1
//element_size=1; //属性特效尺寸
#endregion
#region 附属部件
for(var i=0;i<2;i++){//0前景，1背景，j深度
	for(var j=0;j<5;j++){
		part_vis[i,j]=true;  	//显示
		part_spr[i,j]=noone;	//精灵
		part_inx[i,j]=0;		//帧数
		part_spd[i,j]=0.25;		//帧速
		part_xof[i,j]=0;		//x偏移
		part_yof[i,j]=0;		//y偏移
		part_xofix[i,j]=0;		//x偏移固定
		part_yofix[i,j]=0;		//y偏移固定
		part_xsc[i,j]=1;		//横向
		part_ysc[i,j]=1;		//纵向
		part_bed[i,j]=c_white;	//色彩
		part_agl[i,j]=0;		//角度
		part_aph[i,j]=1;		//透明度
		part_flash[i,j]=true;	//部件是否闪白
	}
}
#endregion
#region 事件
//原地爆炸
final_selfBoom = function(intype, inele) {
	hp=0;
	if(intype) injure_type=intype;
	else injure_type=ATK_TYPE.bullet;
	if(inele) injure_element=inele;
	else injure_element=ELEMENTS.none;
	speed=0;
	gravity=0;
	//image_xscale=1;
}
//原地受伤
final_selfInjure = function(intype, dmg) {
	if(intype) injure_type=intype;
	else injure_type=ATK_TYPE.bullet;
	if(dmg) hp-=dmg;
	flash=1;
	inxscale=image_xscale;
	//injure_element=ELEMENTS.none;
	if(scr_in_view(view_edge))
		scr_sound_play(se_enemy_damage);
}
//死亡时发生
deathTrigger = function() {}
//获取布置信息后的初始化
initAfter = function() {}
//受伤时执行
injureTrigger = function() {}
//刷新时变量传递
final_reflashSetVars = function() {
	with(new_self) {
		init_xscale=other.init_xscale;
		init_yscale=other.init_yscale;
		init_angle=other.init_angle;
		init_alpha=other.init_alpha;
		init_blend=other.init_blend;
		image_xscale=init_xscale;
		image_yscale=init_yscale;
		image_angle=init_angle;
		image_alpha=init_alpha;
		image_blend=init_blend;
	}
}
reflashSetVars = function() {}
//被击飞落地后存活
pushFalloverSave = function(){}
//出视野死亡操作
outViewDeath = function(){}
#endregion