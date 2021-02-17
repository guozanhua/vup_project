/// @arg sprite
/// @arg imsped
/// @arg inxbge=
/// @arg inxend
function scr_sprite_imspd(spr, spd, bg, ed) {
	if(image_speed==0) return;
	if(sprite_index==spr) {
		sprite_set_speed(spr,1,spritespeed_framespergameframe);
		if((image_index>=bg || bg==-1)
		&&(image_index<ed || ed==-1))
			image_speed=spd;//sprite_get_speed(spr)
	}
}
