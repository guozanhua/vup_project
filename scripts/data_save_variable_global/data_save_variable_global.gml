function data_save_variable_global(){
	//困难模式开启
	global.hard_mode=0
	//各种剧情是否进行过（可跳过）
	for(var i=0;i<array_length(global.thread);i++){
		global.threaded[i]=0
	}
	//成就
	for(var i=0;i<100;i++){
		global.achievement[i]=0
	}
	global.achievement_getcount=0//获得成就数，此变量不保存
}