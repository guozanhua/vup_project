/// @desc 初始化脚本
function audio_bgm_inti() {
	global.__bgm_name=noone//音乐名
	global.__bgm_lastname=noone//上次停播前的音乐名
	global.__bgm_snd=noone//播放实例
	global.__bgm_loop=false//是否循环
	global.__bgm_stream=noone//文件流
	global.__bgm_loopbeg=0//循环开始时间
	global.__bgm_loopend=0//循环结束时间
	global.__bgm_change=0//切换音乐进度
	global.__bgm_change_time=0//切换进度时候计时
	global.__bgm_transtime=30//切换音乐淡入淡出的时间(淡入/淡出一次)
	//BGM循环信息配置
	audio_bgm_loop_config()
}
/// @desc 添加音源
/// @arg filename
function audio_bgm_add(name) {
	var group=string_copy(name,0,1),//分组
		temp=working_directory+"snd\\"+group+"\\",//路径
		file=temp+name+".ogg"//文件名
	return audio_create_stream(file)
}
/// @desc 释放音源
/// @arg stream
function audio_bgm_free(stream) {
	audio_destroy_stream(stream)
	global.__bgm_stream=noone
}
/// @desc 立刻进入切换
/// @arg bgm
function audio_bgm_change(bgm) {
	//刚开始播放
	if global.__bgm_name==noone{
		global.__bgm_change=1.5
		global.__bgm_change_time=0
	}
	//有之前的音乐
	else audio_bgm_stop()
	global.__bgm_name=bgm
	global.music_now=global.__bgm_name
}
/// @desc 进入切换
/// @arg bgm
function audio_bgm_change_imm(bgm) {
	//刚开始播放
	if global.__bgm_name==noone{
		global.__bgm_change=1.5
		global.__bgm_change_time=0
	}
	//有之前的音乐
	else audio_bgm_stop_imm()
	global.__bgm_name=bgm
	global.music_now=global.__bgm_name
}
/// @desc 停止播放
/// @arg snd
function audio_bgm_stop() {
	if global.__bgm_name!=noone{
		global.__bgm_change=1//音乐淡出
		global.__bgm_lastname=global.__bgm_name//名字换为上一个
		global.__bgm_name=noone//清空当前名字
	}
}
/// @desc 立刻停止音乐
/// @arg snd
function audio_bgm_stop_imm() {
	global.__bgm_change=1.5//音乐淡出
	global.__bgm_lastname=global.__bgm_name//名字换为上一个
	global.__bgm_name=noone//清空当前名字
}
/// @desc 获得设置的bgm音量
function audio_bgm_get_volume() {
	return global.volume_bgm * global.volume_all * global.volume_menu * 0.5
}
/// @desc 设置音量
/// @arg vol
function audio_bgm_set_volume(vol) {
	audio_sound_gain(global.__bgm_snd,vol,0)
}
/// @desc 正式切换
function audio_bgm_inchange() {
	//淡出
	if global.__bgm_change==1{
		global.__bgm_change_time=global.__bgm_transtime
		global.__bgm_change=1.5
	}
	//淡出中
	if global.__bgm_change==1.5{
		global.__bgm_change_time--
		if global.__bgm_lastname!=noone
			audio_bgm_set_volume(audio_sound_get_gain(global.__bgm_snd)*(global.__bgm_change_time/global.__bgm_transtime))
		if global.__bgm_change_time<=0{
			//卸载流
			if global.__bgm_lastname!=noone{
				audio_stop_sound(global.__bgm_snd)//停止播放
				global.__bgm_stream=noone//卸载流
				//audio_bgm_free(global.__bgm_stream)//卸载流
				global.__bgm_snd=noone
			}
			//如果没有下一首
			if global.__bgm_name==noone{
				global.__bgm_change=0
			}
			//如果有下一首
			else{
				//有上一首，淡入
				if global.__bgm_lastname!=noone
					global.__bgm_change=2
				//没有，直接原音量播放
				else {
					global.__bgm_change=0
				}
				global.__bgm_stream=global.__bgm_name
				audio_bgm_setting()//根据配置设置音乐循环参数
				global.__bgm_snd=audio_play_sound(global.__bgm_stream,0,global.__bgm_loop)
			}
		}
	}
	//淡入
	if global.__bgm_change==2{
		global.__bgm_change_time=global.__bgm_transtime
		global.__bgm_change=2.5
	}
	//淡入中
	if global.__bgm_change==2.5{
		global.__bgm_change_time--
		audio_bgm_set_volume(audio_sound_get_gain(global.__bgm_snd)*(global.__bgm_transtime-global.__bgm_change_time)/global.__bgm_transtime)
		if global.__bgm_change_time<=0
			global.__bgm_change=0
	}
}
/// @desc 进入循环
function audio_bgm_inloop() {
	if global.__bgm_loop
	&& global.__bgm_loopbeg!=0
	&& global.__bgm_snd!=noone{
		//进入循环部分
		if audio_sound_get_track_position(global.__bgm_snd)>=global.__bgm_loopend{
			var st = audio_sound_get_track_position(global.__bgm_snd) - global.__bgm_loopend
			audio_sound_set_track_position(global.__bgm_snd, global.__bgm_loopbeg+st)
		}
	}
}
/// @desc 各个音乐的循环参数，需要先执行audio_bgm_loop_config方法
function audio_bgm_setting() {
	var bgm=global.__bgm_name,
		map = global.bgm_loop_cfgmap,//循环配置表
		bg=0,//循环开始时间
		ed=audio_sound_length(global.__bgm_stream),
		loop=true//是否循环
	loop = !is_undefined(map[? bgm])
	if loop{
		var ary = map[? bgm]
		if is_array(ary){
			bg = ary[0]
			ed = ary[1]
		}
	}
	global.__bgm_loop=loop //是否循环
	global.__bgm_loopbeg=bg //循环开始时间
	global.__bgm_loopend=ed //循环开始时间
}