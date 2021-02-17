/// @desc 音效集合
function audio_se_inti() {
	global.ds_sesnd_list=ds_list_create() //播放实例
	global.ds_sesnd_time_list=ds_list_create() //限时播放实例
	global.volume_se=1
	global.volume_all=1
	global.volume_menu=1
}
/// @desc 获得音量
function audio_se_get_volume() {
	return global.volume_se * global.volume_all * global.volume_menu *0.5
}
/// @desc 音效循环排除
/// @arg vol
function audio_se_boss_set_volume(vol) {
	var list=global.ds_sesnd_list
	for(var i=0;i<ds_list_size(list);i++){
		var snd=list[|i]
		if audio_is_playing(snd) audio_sound_gain(snd,vol,0)
	}
}
/// @desc 根据播放实例获得索引
/// @arg snd
function audio_get_index(snd) {
	var name=audio_get_name(snd)
	return asset_get_index(name)
}
/// @desc 停止播放
function audio_se_stop_all() {
	var list=global.ds_sesnd_list
	for(var i=0;i<ds_list_size(list);i++)
		audio_stop_sound(list[|i])
	ds_list_clear(list)
}
/// @desc 音效循环排除
function audio_se_working() {
	var list=global.ds_sesnd_list;
	for(var i=0;i<ds_list_size(list);i++){
		var snd=list[|i];
		if(!audio_is_playing(snd)) {
			ds_list_delete(list,i--);
		}
	}
	//限时播放
	list=global.ds_sesnd_time_list;
	for(var i=0;i<ds_list_size(list);i++){
		var sndstruct=list[|i],
			snd = sndstruct.snd,
			tset = sndstruct.time,
			tst = sndstruct.start,
			menu = sndstruct.menu,
			fpscur = global.fps_curr;
		if(menu) fpscur = global.fps_currmenu;
		if(!audio_is_playing(snd)) {
			ds_list_delete(list,i--);
			delete sndstruct;
		} else {
			if(fpscur - tst >= tset) {
				audio_stop_sound(snd);
				ds_list_delete(list,i--);
				delete sndstruct;
			}
		}
	}
}
