function scr_se_boom() {
	if collision_point(x,y,obj_water,1,1)
		scr_sound_play(se_boom_underwater)
	else
		scr_sound_play(se_boom_part)
}
