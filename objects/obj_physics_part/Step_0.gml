scr_menu_stop();
if(!scr_menu_trem()) exit;
scr_time_alarm();
if(!scr_in_view(view_edge)) instance_destroy();
if(gravity!=0) {
	var instwater = instance_place(x,y,obj_water);
	if(instwater) {
		gravity=G/(5/4);
		if(instwater.mucus) {
			if(speed>1) speed=1;
		} else {
			gravity=G/(5/4);
			if(vspeed>1) 
				vspeed=1;
		}
	}
	else
		gravity=G;
}
if(jump==10) {
	//
}
dis_angle+=dspeed;