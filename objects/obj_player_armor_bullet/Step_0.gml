event_inherited();
if(!scr_menu_trem()) exit;
if place_meeting(x, y, obj_ground) {
	with instance_create_depth(x, y, depth, obj_animation_once) {
		scr_sprite_change(spr_player_bullet_hit, 0, 0.25)
		image_xscale=other.image_xscale
		image_yscale=other.image_yscale
	}
	instance_destroy()
} else if hit>0 {
	instance_destroy()
} else if hit==-1 {
	with instance_create_depth(x, y, depth, obj_animation_once) {
		scr_sprite_change(spr_player_bullet_invalid, 0, 0.5)
		image_xscale=other.image_xscale
		image_yscale=other.image_yscale
	}
	instance_destroy()
}