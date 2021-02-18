#region init脚本
//宏初始化
scr_macros()
//枚举初始化
scr_enums()
//音效设置等级容纳200
audio_channel_num(200)
audio_se_inti()
audio_dpl_inti()
audio_bgm_inti()
#endregion
#region ini变量初始化
#region 键盘
global.left_key =	vk_left
global.right_key =	vk_right
global.up_key =		vk_up
global.down_key =	vk_down
global.select_key =	vk_space
global.start_key =	vk_enter

global.A_key=ord("X")
global.B_key=ord("C")
global.L_key=ord("Z")
global.R_key=ord("A")
global.X_key=ord("S")
global.Y_key=ord("D")

global.jump_key =	global.B_key
global.att_key =	global.Y_key
global.dash_key =	global.L_key
global.sub_key =	global.R_key
global.trans_key =	global.X_key
global.true_key =	global.A_key
global.tformL_key =	ord("Q")
global.tformR_key =	ord("E")
//初始化记录存入
global.option_init_ary[1]=[
	"left_key", "right_key", "up_key", "down_key", "select_key", "start_key",
	"A_key", "B_key", "L_key", "R_key", "X_key", "Y_key",
	"jump_key", "att_key", "dash_key", "sub_key", "trans_key", "true_key", "tformL_key", "tformR_key",
]
#endregion
#region 手柄
global.joy=-4//当前手柄
global.jump_joy =	gp_b
global.true_joy =	gp_a
global.att_joy =	gp_y
global.trans_joy =	gp_x
global.dash_joy =	gp_l
global.sub_joy =	gp_r
global.tformL_joy =	gp_zl
global.tformR_joy =	gp_zr
global.select_joy =	gp_select
global.start_joy =	gp_start
//初始化记录存入
global.option_init_ary[2]=[
	"jump_joy", "att_joy", "dash_joy", "sub_joy", 
	"trans_joy", "true_joy", "tformL_joy", "tformR_joy",
]
#endregion
#region 动作
global.sub_type=0//0双键，1双按，2切换
global.dash_order=1//冲刺指令
global.glide_type=0//下落方式
global.swim_type=0//游泳方式
//初始化记录存入
global.option_init_ary[3]=[
	"sub_type", "dash_order", "glide_type", "swim_type",
]
#endregion
#region 显示读取
global.fps_display=0
global.texfilter=0
global.language=LANG.CHS
global.effect_enemy_boom=0
global.joy_button_style=0
global.pix_filter=0
//初始化记录存入
global.option_init_ary[4]=[
	"fps_display", "texfilter", "language", "effect_enemy_boom", "joy_button_style"
]
#endregion
#region 音量读取
global.volume_se=1
global.volume_bgm=1
global.volume_all=1
global.volume_menu=0.5//菜单音量
//初始化记录存入
global.option_init_ary[5]=[
	"volume_se", "volume_bgm", "volume_all",
]
#endregion
#region 设置初始化和上版本记录map
for(var i=1;i<array_length(global.option_init_ary);i++){
	global.option_init_map[i]=ds_map_create() //记录初始按键
	global.option_last_map[i]=ds_map_create() //记录上一次按键
	var ary = global.option_init_ary[i],
		map = global.option_init_map[i]
	for(var j=0;j<array_length(ary);j++){
		var key = ary[j], 
			val = variable_global_get(key)
		map[? key] = val
	}
}
#endregion
#endregion
#region ini读取
have_file_config = file_exists(FILE_CONFIG)
ini_open(FILE_CONFIG)
#region 键盘
global.left_key =	ini_read_real("key", "left",	global.left_key)
global.right_key =	ini_read_real("key", "right",global.right_key)
global.up_key =		ini_read_real("key", "up",	global.up_key)
global.down_key =	ini_read_real("key", "down",global.down_key)
global.select_key =	ini_read_real("key", "select",global.select_key)
global.start_key =	ini_read_real("key", "start", global.start_key)

global.A_key = ini_read_real("key", "A", global.A_key)
global.B_key = ini_read_real("key", "B", global.B_key)
global.L_key = ini_read_real("key", "L", global.L_key)
global.R_key = ini_read_real("key", "R", global.R_key)
global.X_key = ini_read_real("key", "X", global.X_key)
global.Y_key = ini_read_real("key", "Y", global.Y_key)

global.jump_key =	ini_read_real("key", "jump",	global.jump_key)
global.att_key =	ini_read_real("key", "att",		global.att_key)
global.dash_key =	ini_read_real("key", "dash",	global.dash_key)
global.sub_key =	ini_read_real("key", "sub",		global.sub_key)
global.trans_key =	ini_read_real("key", "trans",	global.trans_key)
global.true_key =	ini_read_real("key", "true",		global.true_key)
global.tformL_key =	ini_read_real("key", "tformL",	global.tformL_key)
global.tformR_key =	ini_read_real("key", "tformR",	global.tformR_key)
#endregion
#region 手柄
global.jump_joy =	ini_read_real("joy", "jump",	global.jump_joy)
global.true_joy =	ini_read_real("joy", "true",		global.true_joy)
global.att_joy =	ini_read_real("joy", "att",		global.att_joy)
global.trans_joy =	ini_read_real("joy", "trans",	global.trans_joy)
global.dash_joy =	ini_read_real("joy", "dash",	global.dash_joy)
global.sub_joy =	ini_read_real("joy", "sub",		global.sub_joy)
global.tformL_joy =	ini_read_real("joy", "tformL",	global.tformL_joy)
global.tformR_joy =	ini_read_real("joy", "tformR",	global.tformR_joy)
#endregion
#region 动作
global.sub_type =	ini_read_real("weapon", "sub",			global.sub_type)//0双键，1双按，2切换
global.dash_order =	ini_read_real("weapon", "dash_order",	global.dash_order)//冲刺指令
global.glide_type =	ini_read_real("weapon", "glide_type",	global.glide_type)//下落方式
global.swim_type =	ini_read_real("weapon", "swim_type",	global.swim_type)//游泳方式
#endregion
#region 显示读取
global.fps_display =	ini_read_real("display", "fps",			global.fps_display)
global.texfilter =		ini_read_real("display", "texfilter",		global.texfilter)
global.language =		ini_read_real("display", "language",		global.language)
global.effect_enemy_boom =	ini_read_real("display", "effect_enemy_boom",	global.effect_enemy_boom)
global.joy_button_style =	ini_read_real("display", "joy_button_style",	global.joy_button_style)
global.pix_filter =	ini_read_real("display", "pix_filter",	global.pix_filter)
#endregion
#region 音量读取
global.volume_se =	ini_read_real("volume", "se",	global.volume_se)
global.volume_bgm =	ini_read_real("volume", "bgm",	global.volume_bgm)
global.volume_all =	ini_read_real("volume", "all",	global.volume_all)
#endregion
ini_close()
#endregion
#region 键态区
//菜单按键
global.Left_state=0
global.Right_state=0
global.Up_state=0
global.Down_state=0
global.A_state=0
global.B_state=0
global.L_state=0
global.R_state=0
global.X_state=0
global.Y_state=0
global.Select_state=0
global.Start_state=0
global.pad_direct=-1 //根据方向键设定角度
global.axisL_direct=-1 //根据摇杆设定角度
global.axisR_direct=-1
global.axisL_position=0 //摇杆摆动幅度
global.axisR_position=0
global.Mleft_state=0
global.Mright_state=0
global.Mmiddle_state=0
global.Mwheel_state=0//-1up,1down
global.Mmouse_x=mouse_x
global.Mmouse_y=mouse_y
//玩家动作按键
global.left_state=0
global.right_state=0
global.up_state=0
global.down_state=0
global.jump_state=0
global.att_state=0
global.dash_state=0
global.sub_state=0
global.true_state=0
global.trans_state=0
global.select_state=0
global.start_state=0
global.tformL_state=0
global.tformR_state=0
//辅助按键
global.jump_cor=0
global.dash_cor=0
//程序自动按键(0代表没按下，1按下)
global.left=0
global.right=0
global.up=0
global.down=0
global.jump=0
global.att=0
global.dash=0
global.sub=0
global.true=0
global.trans=0
global.select=0
global.start=0
global.tformL=0
global.tformR=0
//按键状态集中/0-键盘，1-手柄
for(var i=0;i<2;i++){
	global.left_allstate[i]=0
	global.right_allstate[i]=0
	global.up_allstate[i]=0
	global.down_allstate[i]=0
	global.select_allstate[i]=0
	global.start_allstate[i]=0
		
	global.A_allstate[i]=0
	global.B_allstate[i]=0
	global.X_allstate[i]=0
	global.Y_allstate[i]=0
	global.L_allstate[i]=0
	global.R_allstate[i]=0
		
	global.att_allstate[i]=0
	global.jump_allstate[i]=0
	global.dash_allstate[i]=0
	global.sub_allstate[i]=0
	global.trans_allstate[i]=0
	global.true_allstate[i]=0
	global.tformL_allstate[i]=0
	global.tformR_allstate[i]=0
}
#endregion
#region 存档变量
global.game_start=0
data_save_variable_single()
data_save_variable_global()
#endregion
#region 其他变量
global.room_change=0
global.skip=0
global.boss_war=0
global.boss_hp=0
global.boss_logo=0
global.player_def=1//实际伤害百分比
global.prick_attack=6//尖刺伤害
global.player_reversed=0//上下倒立
global.floor_down_list=ds_list_create()//玩家半透板记录
player_death_re=0//重生控制变量
#endregion
#region 发射区
instance_create_depth(0, 0, -10000, obj_view)
instance_create_depth(0, 0, -20000, obj_menu)
global.player=instance_create_layer(x,y,"player",obj_player_hu)
#endregion
#region 重生区
global.re_x=obj_player.x
global.re_y=obj_player.y
global.re_xscale=obj_player.image_xscale
global.room_prev=room
#endregion
#region 计时区
global.fps_60=0
global.fps_30=0
global.fps_20=0
global.fps_15=0
global.fps_12=0
global.fps_10=0
global.fps_6=0
global.fps_5=0
global.fps_4=0
global.fps_3=0
global.fps_2=0
global.fps_1=0
global.fps_curr=0//运行开始到现在共多少帧
global.fps_currmenu=0//运行开始到现在活动状态
global.fps_roommenu=0//房间开始到现在活动状态
#endregion
#region 暂停区
global.operate=0//完全代码操纵
global.player_operate=0//仅关闭按键操纵，依然可用自带移动体系
global.stop=0//暂停游戏
//打击感
global.saber_pause=0
global.boss_pause=0
boss_pause_time=0
//传送房间中
global.transing=0
#endregion
#region 音乐区
global.music=-1//当前音乐
global.music_last=0//上一个音乐
global.music_now=noone
global.music_change=0//音乐变更
music_time=0//音乐更换计时
#endregion