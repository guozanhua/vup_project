if(view_current!=0) exit;
var perx=x, pery=y;
x=round(x) y=round(y)
#region 本体
event_user(15);
#endregion
#region 受伤
if(uninjure==1) {
	if(global.fps_20==0) 
		scr_draw_sprite_white(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
}
#endregion
x=perx;
y=pery;