event_inherited();
if(!scr_menu_trem()) exit;
if(jump==10){
	with(instance_create_depth(x, y, depth-1, obj_animation_once)) {
		scr_sprite_change(spr_smoke,0,0.5);
	}
	instance_destroy();
}
if(jump==11)
	image_alpha=1;
else
	image_alpha=global.fps_30;
	
if(sprite_index==spr_smoke){
	if(place_meeting(x,y,obj_water))
		instance_destroy();
}