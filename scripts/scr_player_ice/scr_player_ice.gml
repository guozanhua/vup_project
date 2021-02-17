function scr_player_ice() {
	//if place_meeting(x,y,obj_ice)
	/*&&((collision_rectangle(bbox_right,bbox_bottom,bbox_right-1,bbox_top,obj_ice,1,1)
	&& collision_rectangle(bbox_left+1,bbox_bottom,bbox_left,bbox_top,obj_ice,1,1)
	&&(place_meeting(x,y+1,obj_ground)||place_meeting(x,y+1,obj_floor)))
	||(!place_meeting(x,y+1,obj_ground)&&!place_meeting(x,y+1,obj_floor)))*/
	//if(scr_player_debuff_is(DEBUFF.oil)) return true;
	var ground=instance_place(x, y+1, obj_ground),
		flor=instance_place(x, y+1, obj_floor);
	if((ground && ground.ice)
	||(flor && flor.ice)
	|| place_meeting(x,y,obj_ice) )
		return true;
	else
		return false;
}
