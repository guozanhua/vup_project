function scr_player_outground() {
	while(collision_rectangle(bbox_right, y+GROUND_DRAWY, bbox_left, bbox_top, obj_ground, 1, 1) && image_yscale=1)
	|| (collision_rectangle(bbox_right, bbox_bottom, bbox_left, y-GROUND_DRAWY, obj_ground, 1, 1) && image_yscale=-1)
		y+=image_yscale
}
