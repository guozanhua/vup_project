/// @arg sprite
/// @arg subimg
/// @arg imsped
function scr_sprite_change(sprite, subimg, imsped) {
	if(sprite>-1) sprite_index=sprite;
	sprite_set_speed(sprite_index,1,spritespeed_framespergameframe);
	if(subimg>-1) image_index=subimg;
	if(imsped>=-1) image_speed=imsped;
}
