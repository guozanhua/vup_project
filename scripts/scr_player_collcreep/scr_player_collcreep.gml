function scr_player_collcreep() {
	if(image_yscale==1 && collision_rectangle(bbox_right,bbox_top,bbox_left,bbox_top-32,obj_ground,1,1))
	||(image_yscale==-1 && collision_rectangle(bbox_right,bbox_bottom+32,bbox_left,bbox_bottom,obj_ground,1,1))
		return true
	else
		return false
}
