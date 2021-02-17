function scr_player_flyobj_move() {
	var ground1=collision_rectangle(bbox_right,bbox_bottom+4,bbox_left,bbox_top,obj_flyground,1,1),		//全身+足下
		ground2=collision_rectangle(bbox_right,bbox_top,bbox_left,bbox_top-16,obj_flyground,1,1),		//头上PZ
		ground3=collision_rectangle(bbox_right+2,bbox_bottom,bbox_left-2,bbox_top,obj_flyground,1,1),	//左右
		ground4=collision_rectangle(bbox_right,bbox_top,bbox_left,bbox_top-1,obj_flyground,1,1),		//头上
		floor1=collision_rectangle(bbox_right,bbox_bottom+4,bbox_left,bbox_bottom,obj_flyfloor,1,1),	//足下
		floor2=collision_rectangle(bbox_right,bbox_top,bbox_left,bbox_top-24,obj_flyfloor,1,1),			//头上
		floor3=collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_top-24,obj_flyfloor,1,1),		//全身+头上
		//line=collision_rectangle(bbox_right,bbox_top,bbox_left,bbox_top-16,obj_flyline,1,1),			//头上
		pre_flyobj=flyobj, //上一帧接触的飞行物
		upfloor = false //是否踩在半透板上
	if ground1 && jump<=0		flyobj=ground1	//脚下
	else if ground3				flyobj=ground3	//左右
	else if ground4 && jump>0	flyobj=ground4	//头顶
	else if floor1 && jump<=0{
		flyobj=floor1	//脚下
		upfloor = true
	} else flyobj=noone

	//移动挤压
	if instance_exists(flyobj){
		var hsp=0,vsp=0
		if flyobj.speed!=0{
			hsp=flyobj.hspeed
			vsp=flyobj.vspeed
		} else if flyobj.path_speed!=0 {
			hsp=lengthdir_x(flyobj.path_speed, flyobj.direction)
			vsp=lengthdir_y(flyobj.path_speed, flyobj.direction)
		}
		//直球运行
		x+=hsp
		y+=vsp
		//横向矫正
		if abs(hsp)>0{
			//飞行物是墙壁，考虑挤压
			if instance_is_object(flyobj, obj_flyground){
				if !place_meeting(x-hsp,y,flyobj){//被推动
					var grd = noone
					do{
						grd = collision_rectangle(bbox_right+min(sign(hsp),0),bbox_bottom-1,bbox_left+max(sign(hsp),0),bbox_top+1,obj_ground,1,1)
						if instance_exists(grd) && grd!=flyobj x-=sign(hsp)
						else grd = noone
					}until !(instance_exists(grd) && grd!=flyobj)
				} //else while place_meeting(x,y,flyobj) x+=sign(hsp)
			}
			//线或者板子，碰到墙壁强制挤压出来
			else{
				while collision_rectangle(bbox_right+max(sign(hsp),0),bbox_bottom-1,bbox_left+min(sign(hsp),0),bbox_top+1,obj_ground,1,1)
					x-=sign(hsp)
				//while collision_rectangle(bbox_right,bbox_bottom-1,bbox_right-1,bbox_top+1,obj_ground,1,1)
				//&& !collision_rectangle(bbox_left+1,bbox_bottom-1,bbox_left,bbox_top+1,obj_ground,1,1)
				//	x-=1
				//while collision_rectangle(bbox_left+1,bbox_bottom-1,bbox_left,bbox_top+1,obj_ground,1,1)
				//&& !collision_rectangle(bbox_right,bbox_bottom-1,bbox_right-1,bbox_top+1,obj_ground,1,1)
				//	x+=1
			}
		}
		//纵向矫正
		if abs(vsp)>0{
			//飞行物是墙壁，考虑挤压
			if instance_is_object(flyobj, obj_flyground){
				if !place_meeting(x,y-vsp,flyobj){//被推动抬上或者压下
					var grd = noone
					do{
						grd = collision_rectangle(bbox_right,bbox_bottom+min(sign(vsp),0),bbox_left,bbox_top+max(sign(vsp),0),obj_ground,1,1)
						if instance_exists(grd) && grd!=flyobj y-=sign(vsp)
						else grd = noone
					}until !(instance_exists(grd) && grd!=flyobj)
				} //else while place_meeting(x,y,flyobj) y+=sign(vsp)
			}
			//线或者板子，碰到墙壁强制挤压出来
			else{
				if!(vsp<0 && upfloor){
					while collision_rectangle(bbox_right,bbox_bottom+max(sign(vsp),0),bbox_left,bbox_top+min(sign(vsp),0),obj_ground,1,1)
						y-=sign(vsp)
				}
				//while collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_bottom-1,obj_ground,1,1)
				//&& !collision_rectangle(bbox_right,bbox_top+1,bbox_left,bbox_top,obj_ground,1,1)
				//	y-=1
				//while collision_rectangle(bbox_right,bbox_top+1,bbox_left,bbox_top,obj_ground,1,1)
				//&& !collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_bottom-1,obj_ground,1,1)
				//	y+=1
			}
		}
		//如果是这一帧才接触，则强制坐标小数位校准
		if !instance_exists(pre_flyobj){
			if flyobj.hspeed>0 && in(flyobj, [ground3]){
				x=floor(x)
				if x<flyobj.bbox_left x+=frac(flyobj.bbox_left)
				else if x>flyobj.bbox_right x+=frac(flyobj.bbox_right)
				while place_meeting(x,y,flyobj) 
					x+=sign(flyobj.hspeed)
			}
			if flyobj.vspeed>0 && in(flyobj, [ground1, ground4]){
				y=floor(y)
				if y<flyobj.bbox_top y+=frac(flyobj.bbox_top)
				else if y>flyobj.bbox_bottom y+=frac(flyobj.bbox_bottom)
				while place_meeting(x,y,flyobj) 
					y+=sign(flyobj.vspeed)
			}
		}
	}
}
