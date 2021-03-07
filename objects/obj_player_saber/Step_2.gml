x=obj_player.x;
y=obj_player.y;
image_xscale=abs(image_xscale)*sign(obj_player.image_xscale);
image_yscale=abs(image_yscale)*sign(obj_player.image_yscale);
event_inherited();
if(!scr_menu_trem()) exit;
#region 精灵帧数

#endregion