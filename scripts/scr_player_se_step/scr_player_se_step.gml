function scr_player_se_step() {
	//if(water==1){
	//	scr_sound_play(se_step_water);
	//	return;
	//}
	scr_se_step();
}
function scr_se_step() {
	var sground=noone;
	if image_yscale=1 sground=collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY+4,bbox_left,bbox_bottom+GROUND_DRAWY,obj_ground,1,1)
	else if image_yscale=-1 sground=collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY,bbox_left,bbox_top-GROUND_DRAWY-4,obj_ground,1,1)
	if sground{
		if variable_instance_exists(sground,"SE_step")
		&& audio_exists(sground.SE_step)
			scr_sound_play(sground.SE_step)
	}

	var sfloor=noone;
	if image_yscale=1 sfloor=collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY+4,bbox_left,bbox_bottom+GROUND_DRAWY,obj_floor,1,1)
	else if image_yscale=-1 sfloor=collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY,bbox_left,bbox_top-GROUND_DRAWY-4,obj_floor,1,1)
	if sfloor{
		if variable_instance_exists(sfloor,"SE_step")
		&& audio_exists(sfloor.SE_step)
			scr_sound_play(sfloor.SE_step)
	}

	var ssink=noone;
	if image_yscale=1 ssink=collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY+4,bbox_left,bbox_top,obj_sink,1,1)
	else if image_yscale=-1 ssink=collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_top-GROUND_DRAWY-4,obj_sink,1,1)
	if ssink{
		if variable_instance_exists(ssink,"SE_step")
		&& audio_exists(ssink.SE_step)
			scr_sound_play(ssink.SE_step)
	}
}
