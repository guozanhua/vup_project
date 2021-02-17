/// @desc 多普勒音效箱实行中
function audio_dpl_inti() {
	global.ds_sesnd_dpl_list=ds_list_create() //播放实例
}
/// @desc 多普勒音效箱实行
function audio_dpl_working() {
	var list=global.ds_sesnd_dpl_list
	for(var i=0;i<ds_list_size(list);i++){
		var snd=list[|i],inx=audio_get_index(snd)
		if audio_sound_get_gain(snd)<=0 audio_stop_sound(inx)
		if !audio_is_playing(snd) ds_list_delete(list,i)
	}
}
/// @arg se
function scr_sound_isplay_dpl(se) {
	var list=global.ds_sesnd_dpl_list
	for(var i=0;i<ds_list_size(list);i++){
		var snd=list[|i],inx=audio_get_index(snd)
		if inx=se return true
	}
	return false
}
/// @arg se
function scr_sound_loop_dpl(se) {
	var snd=audio_play_sound(se,15,1)
	audio_sound_gain(snd,0.01,0)
	audio_sound_gain(snd,1,500)
	ds_list_add(global.ds_sesnd_dpl_list,snd)
}
/// @arg se
function scr_sound_play_dpl(se) {
	var snd=audio_play_sound(se,15,0)
	audio_sound_gain(snd,0.01,0)
	audio_sound_gain(snd,1,500)
	ds_list_add(global.ds_sesnd_dpl_list,snd)


}
/// @arg se
function scr_sound_stop_dpl(se) {
	var list=global.ds_sesnd_dpl_list
	for(var i=0;i<ds_list_size(list);i++){
		var snd=list[|i],inx=audio_get_index(snd)
		if inx==se audio_sound_gain(snd,0,500)
	}
}
function scr_sound_stopall_dpl() {
	var list=global.ds_sesnd_dpl_list
	for(var i=0;i<ds_list_size(list);i++){
		var snd=list[|i]
		audio_sound_gain(snd,0,50)
	}
}