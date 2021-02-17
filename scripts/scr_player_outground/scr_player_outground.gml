function scr_player_outground() {
	while(collision_rectangle(bbox_right, y, bbox_left, bbox_top, obj_ground, 1, 1) && image_yscale=1)
	|| (collision_rectangle(bbox_right, bbox_bottom, bbox_left, y, obj_ground, 1, 1) && image_yscale=-1)
		y+=image_yscale
}
