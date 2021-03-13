if blackbgs_alpha>0 {
	scr_draw_rectangle_view(c_black, blackbgs_alpha, 0)
}
//本体
draw_sprite_ext(sprite_index, image_index, round(x), round(y), 
				image_xscale, image_yscale,
				image_angle, image_blend, image_alpha)
//残影
if after_img_dir>0 {
	var sfx=0, sfy=0;
	if after_img_dir==1 sfx=after_img_dis
	else if after_img_dir==2 sfy=after_img_dis
	for(var i=-1;i<=1;i+=2) {
		draw_sprite_ext(sprite_index, image_index, round(x+i*sfx), round(y+i*sfy), 
						image_xscale, image_yscale,
						image_angle, image_blend, after_img_alpha)
	}
}
//闪白
if flash>0 {
	flash--
	scr_draw_sprite_white(sprite_index, image_index, round(x), round(y), 
						image_xscale, image_yscale,
						image_angle, image_blend, image_alpha)
}