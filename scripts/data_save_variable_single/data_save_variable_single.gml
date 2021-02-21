function data_save_variable_single(){
	global.start_current=0//存档开始时间
	global.second=0
	global.minute=0
	global.hour=0
	global.game_cleared=false//已通关
#region 玩家区
	global.mode=1//当前模式
	/////////////////////////
	global.re_x=0
	global.re_y=0
	global.re_xscale=0
	/////////////////////////
	global.player_hp=32
	global.player_hp_up=32
	global.player_hp_ex=0	//一次性扩展血条
	global.player_mp=32
	global.player_mp_up=32
	global.player_mp_ex=0	//一次性扩展能量
	global.player_support=0 //羁绊值
	global.player_life=2
	global.player_ec=0
	/////////////////////////
	for(var i=0;i<=30;i++){
		global.boss[i]=0
		for(var j=0;j<=8;j++){
			global.sub_bosses[i][j]=0
		}
	}
	/////////////////////////
	global.model=PLAYER_MODEL.HU
	global.model_get_number=1//获得模块数量
	global.model_number=11
	for(var i=0;i<global.model_number;i+=1){
		global.model_get[i]=0//模块获得
		global.main_sub_exchange[i]=0//模块武器切换
		global.sub_change[i]=0//模式三使用副武器
	}
	global.model_get[PLAYER_MODEL.HU]=1
#endregion
#region 剧情
	//各种剧情是否进行过（可跳过）
	for(var i=0;i<=500;i++){
		global.thread[i]=0
	}
#endregion
}