if(view_current!=0) exit;
var perx=x, pery=y;
x=round(x) 
y=round(y)
#region 残影
if(afterdash<8 && global.fps_30!=0) {
	for(var i=8;i>=0;i-=1){
		if(frac(i/4)==0) {
			//残影染色
			if(i mod 8 == 0) {
				//if(after_shader==shd_set_rendering) scr_shader_rendering(after_bow_color,C_AFIM[1]);
				//else if(after_shader==shd_color_exchange) scr_shader_color_exchange(after_ex_cols,after_bow_cols);
			}
			//保持普通
			//else if(bow_exchange) scr_shader_color_exchange(ex_cols,bow_colors);
			draw_sprite_ext(sprite_index,image_index,round(px[i]),round(py[i]),image_xscale,image_yscale,image_angle,aftercolor,image_alpha);
			//shader_reset();
		}
	}
}
#endregion
#region 本体
event_user(15);
#endregion
#region 受伤
if(uninjure==1) {
	var alpha=global.fps_15*0.25
	scr_draw_sprite_white(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_white,image_alpha*alpha);
}
#endregion
x=perx;
y=pery;