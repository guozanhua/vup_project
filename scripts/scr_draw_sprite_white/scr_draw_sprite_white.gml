/// @arg sprite
/// @arg subimg
/// @arg x
/// @arg y
/// @arg xscale
/// @arg yscale
/// @arg rot
/// @arg col
/// @arg alpha
function scr_draw_sprite_white(spr,inx,xx,yy,xscale,yscale,rot,col,alpha) {
	//设置边界范围
	var x1,x2,y1,y2;
	x1=xx+sprite_get_width(spr)*abs(xscale)
	x2=xx-sprite_get_width(spr)*abs(xscale)
	y1=yy+sprite_get_height(spr)*abs(yscale)
	y2=yy-sprite_get_height(spr)*abs(yscale)
	var invcol=rgb(255-color_get_red(col), 255-color_get_green(col), 255-color_get_blue(col))
	//设置正确的绘制颜色和alpha
	draw_set_color_alpha(c_white, 1)
	//设置绘制方式为翻转背景颜色，绘制方块
	gpu_set_blendmode_ext(bm_inv_dest_color, bm_zero)
	draw_rectangle(x1,y1,x2,y2,false)
	//设置绘制方式为前景全黑，绘制精灵
	gpu_set_blendmode_ext(bm_zero, bm_inv_src_alpha)
	draw_sprite_ext(spr,inx,xx,yy,xscale,yscale,rot,invcol,alpha)
	//设置绘制方式为翻转背景颜色，绘制方块
	gpu_set_blendmode_ext(bm_inv_dest_color, bm_zero)
	draw_rectangle(x1,y1,x2,y2,false)
	//恢复正常绘制方式
	gpu_set_blendmode(bm_normal)
	draw_set_color_alpha_init()
}
/// @desc 除了精灵外完全相同
/// @arg sprite
function scr_draw_only_sprite(spr){
	draw_sprite_ext(spr, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
}