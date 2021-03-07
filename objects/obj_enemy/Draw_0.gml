if(view_current!=0) exit;
var perx=x, pery=y;
x=round(x) 
y=round(y)
var fsh=flash,bgk=0;
#region 白影
if(whiteimage) {
	//var scale=0.2+0.15*sin(pi/90*whiteimage_time)+0.05*sin(pi/2);
	var scale=0.15+0.1*sin(pi/60*whiteimage_time)+0.05*cos(pi/2*whiteimage_time);
	scr_shader_blend(whiteimagecol);
	draw_sprite_ext(sprite_index,image_index,round(x),round(y),image_xscale+abs(scale)*sign(image_xscale),image_yscale+abs(scale)*sign(image_yscale),image_angle,image_blend,1);
	shader_reset();
}
#endregion
#region 残影
if(afimg_count_now>0) {
	//if(afimg_shader==shd_set_rendering) scr_shader_rendering(afimg_shader_color,afimg_shader_lumin);
	//else if(afimg_shader==shd_color_exchange) scr_shader_color_exchange(afimg_ex_cols,afimg_cols);
	var alpha=((afterimageflash && global.fps_30!=0)||!afterimageflash) ? 1 : 0;
	for(var i=afimg_count;i>0;i-=1){
		if((i mod afimg_step)==0) 
			draw_sprite_ext(sprite_index,image_index,afimg_x[i],afimg_y[i],image_xscale,image_yscale,image_angle,image_blend,image_alpha*alpha);
	}
	//if(afimg_shader!=noone) shader_reset();
}
#endregion
#region 本体
//背景
bgk=1
for(var j=array_length(part_spr[bgk])-1;j>=0;j--){
	if(!sprite_exists(part_spr[bgk,j]) 
	|| !part_vis[bgk,j]
	|| sprite_index==spr_boom
	|| sprite_index==spr_none)
		continue;
	var shiftxy=shift_xy_angle(part_xof[bgk,j]*abs(part_xsc[bgk,j]), part_yof[bgk,j]*abs(part_ysc[bgk,j]), part_agl[bgk,j]);
	draw_sprite_ext(part_spr[bgk,j],part_inx[bgk,j],round(x)+shiftxy[0]+part_xofix[bgk,j],round(y)+shiftxy[1]+part_yofix[bgk,j],
			part_xsc[bgk,j],part_ysc[bgk,j],part_agl[bgk,j],part_bed[bgk,j],part_aph[bgk,j]);
	if(fsh=1) 
		scr_draw_sprite_white(part_spr[bgk,j],part_inx[bgk,j],round(x)+shiftxy[0]+part_xofix[bgk,j],round(y)+shiftxy[1]+part_yofix[bgk,j],
			part_xsc[bgk,j],part_ysc[bgk,j],part_agl[bgk,j],part_bed[bgk,j],part_aph[bgk,j]);
}
//本体
draw_self();
//无敌闪
if(flash==1) {
	flash=0;
	scr_draw_sprite_white(sprite_index,image_index,round(x),round(y),image_xscale,image_yscale,image_angle,c_white,image_alpha);
}
//前景
bgk=0
for(var j=array_length(part_spr[bgk])-1;j>=0;j--){
	if(!sprite_exists(part_spr[bgk,j])
	|| !part_vis[bgk,j]
	|| sprite_index==spr_boom
	|| sprite_index==spr_none)
		continue;
	var shiftxy=shift_xy_angle(part_xof[bgk,j]*abs(part_xsc[bgk,j]), part_yof[bgk,j]*abs(part_ysc[bgk,j]), part_agl[bgk,j]);
	draw_sprite_ext(part_spr[bgk,j],part_inx[bgk,j],round(x)+shiftxy[0]+part_xofix[bgk,j],round(y)+shiftxy[1]+part_yofix[bgk,j],
			part_xsc[bgk,j],part_ysc[bgk,j],part_agl[bgk,j],part_bed[bgk,j],part_aph[bgk,j]);
	if(fsh=1) 
		scr_draw_sprite_white(part_spr[bgk,j],part_inx[bgk,j],round(x)+shiftxy[0]+part_xofix[bgk,j],round(y)+shiftxy[1]+part_yofix[bgk,j],
			part_xsc[bgk,j],part_ysc[bgk,j],part_agl[bgk,j],part_bed[bgk,j],part_aph[bgk,j]);
}
#endregion
#region 属性效果
//var spr_elem1 = spr_enemy_element1,
//	spr_elem2 = spr_enemy_element2,
//	spr_elem3 = spr_enemy_element3;
//if(element_size==2) {
//	spr_elem1 = spr_boss_element1
//	spr_elem2 = spr_boss_element2
//	spr_elem3 = spr_boss_element3;
//}
//if(injure_element==ELEMENTS.fire) 
//	draw_sprite(spr_elem1, element_index, x, y);
//else if(injure_element==ELEMENTS.ice) 
//	draw_sprite(spr_elem2, element_index, x, y);
//else if(injure_element==ELEMENTS.elec) 
//	draw_sprite(spr_elem3, element_index, x, y);
#endregion
x=perx;
y=pery;