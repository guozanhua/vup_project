function scr_physics_part() {
	if place_meeting(x,y+1,obj_ground)
	|| place_meeting(x,y+1,obj_sink)
	|| collision_rectangle(bbox_right,bbox_bottom+2,bbox_left,bbox_bottom-2,obj_floor,1,1){
		var hh,vv;
		hh=hspeed
		vv=vspeed

		if jump<=2{
			if collision_point(x,bbox_bottom,obj_ground,1,1)
			|| collision_point(x,bbox_bottom,obj_sink,1,1)
			|| collision_point(x,bbox_bottom,obj_floor,1,1)
			{
				hspeed=hspeed/2
				vspeed=-vspeed/2
			}
			if collision_line(bbox_left,y,bbox_right,y,obj_ground,1,1)
			|| collision_line(bbox_left,y,bbox_right,y,obj_sink,1,1)
			{
				hspeed=-hspeed/2
			}
		    dspeed=dspeed/2
		    jump+=1
		}
		else if jump=3{
		    vspeed=0
		    hspeed=0
		    gravity=0
		    dspeed=0
		    flash=30
		    jump=10
		}
		else if jump=10{
		
		}
	
		x=round(x)
		y=floor(y)
		while collision_rectangle(bbox_right,bbox_bottom+4,bbox_left,bbox_bottom-2,obj_floor,1,1)
			y-=image_yscale
		//move_outside_solid(direction+180,max(speed,4))
		if place_meeting(x,y,obj_ground)
		|| place_meeting(x,y,obj_sink){
			x-=hh
			y-=vv
		}
	}
}
