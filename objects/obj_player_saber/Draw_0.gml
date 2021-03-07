if(view_current!=0) exit;
x=obj_player.x;
y=obj_player.y;
image_xscale=abs(image_xscale)*sign(obj_player.image_xscale);
image_yscale=abs(image_yscale)*sign(obj_player.image_yscale);
image_angle=obj_player.image_angle;

draw_self()