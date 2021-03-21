if view_current!=1 exit
var cenx=VIEW_W_UI/2,
	ceny=VIEW_H_UI/2;
	
//shader_set_uniform_f(fstep, 0.00025)
var logox=x/VIEW_W*VIEW_W_UI, logoy=y/VIEW_H*VIEW_H_UI;
draw_sprite(spr_logo_bgs, 0, cenx, ceny)
draw_sprite(spr_logo_title, 0, logox, logoy)

//shader_set(shd_blur_gauss)
//var fstep = shader_get_uniform(shd_vague, "fstep");
//shader_set_uniform_f(fstep, 0.00024)
scr_draw_text_ext(c_black, 1, 0, font_puhui, 0.5, 0.5, "请按下ENTER键", 
					cenx, ceny+256, 1, 1, -1, -1, -1, 0)
//shader_reset()