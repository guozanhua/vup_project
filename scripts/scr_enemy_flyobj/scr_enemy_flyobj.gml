function scr_enemy_flyobj() {
	if sprite_index==spr_boom exit
	if scr_menu_trem(){
		var flyobj1=collision_rectangle(bbox_right+2,bbox_bottom+4,bbox_left-2,bbox_top-2,obj_flyground,1,1),
			flyobj2=collision_rectangle(bbox_right-1,bbox_bottom+4,bbox_left+1,bbox_bottom-2,obj_floor,1,1)
		if flyobj1 flyobj=flyobj1
		else if flyobj2 flyobj=flyobj2
		else flyobj=noone
		if flyobj{
			var hs=0,vs=0
			if flyobj.speed!=0{
				hs=flyobj.hspeed
				vs=flyobj.vspeed
			} else if flyobj.path_speed!=0 {
				hs=lengthdir_x(flyobj.path_speed, flyobj.direction)
				vs=lengthdir_y(flyobj.path_speed, flyobj.direction)
			}
		
			x+=hs
			y+=vs
			while collision_rectangle(bbox_right,bbox_bottom-1,bbox_right-1,bbox_top+1,obj_ground,1,1)
				x-=1
			while collision_rectangle(bbox_left+1,bbox_bottom-1,bbox_left,bbox_top+1,obj_ground,1,1)
				x+=1
			while collision_rectangle(bbox_right-1,bbox_bottom-1,bbox_left+1,bbox_bottom,obj_ground,1,1)
				y-=1
			while collision_rectangle(bbox_right-1,bbox_top,bbox_left+1,bbox_top+1,obj_ground,1,1)
				y-=1
		}
	}
	/*while place_meeting(x,y,obj_ground)
		y-=image_yscale*/
}
