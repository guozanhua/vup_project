/// @desc 音效时间设置
/// @arg snd
/// @arg time
/// @arg menu
function seTimeSet(snd, time, menu) constructor {
	if(menu) start = global.fps_currmenu;
	else start = global.fps_curr;
}

/// @desc 播放音效一次
/// @arg se
/// @arg time*
function scr_sound_play(se, time) {
	audio_stop_sound(se);
	var snd=audio_play_sound(se,20,0);
	ds_list_add(global.ds_sesnd_list,snd);
	audio_sound_gain(snd,audio_se_get_volume(),0);
	if(time) {
		ds_list_add(global.ds_sesnd_time_list,new seTimeSet(snd, time, false));
	}
	return snd;
}
/// @desc 播放音效循环
/// @arg se
/// @arg time*
function scr_sound_loop(se, time) {
	scr_sound_stop(se);
	var snd=audio_play_sound(se,10,1);
	ds_list_add(global.ds_sesnd_list,snd);
	audio_sound_gain(snd,audio_se_get_volume(),0);
	if(time) {
		ds_list_add(global.ds_sesnd_time_list,new seTimeSet(snd, time, false));
	}
	return snd;
}
/// @desc 菜单播放音效
/// @arg se
function scr_sound_menu_play(se, time) {
	audio_stop_sound(se);
	var snd=audio_play_sound(se,30,0);
	ds_list_add(global.ds_sesnd_list,snd);
	audio_sound_gain(snd,audio_se_get_volume(),0);
	if(time) {
		ds_list_add(global.ds_sesnd_time_list,new seTimeSet(snd, time, false));
	}
	return snd;
}
/// @desc 音效是否播放
/// @arg se
function scr_sound_isplay(se) {
	if audio_is_playing(se) return true;
	else return false;
}
/// @desc 停止音效
/// @arg se
function scr_sound_stop(se) {
	audio_stop_sound(se);
}
