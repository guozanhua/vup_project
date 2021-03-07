/// @arg enemy_ground*
/// @arg enemy_type*
/// @arg trans_spd*
/// @required hsp
/// @required vsp
/// @required grav
/// @required hfrict
/// @required vfrict
function scr_enemy_move_system(egd, etp, trans) {
	if!egd egd=enemy_ground
	if!etp etp=enemy_type
	if!trans trans=trans_spd
	//碰撞墙壁可行
	if egd=1{
		var tsp=0,hr
		if trans{//如果受到传送带影响
			if place_meeting(x,y+1,obj_ground) && vsp>=0{
				var insttrans=instance_place(x,y,obj_trans)
				if instance_exists(insttrans) tsp=insttrans.trans_hsp
			}
		} else tsp=0
		hr=hsp+tsp
		//横向移动
		if !place_meeting(x+hr, y, obj_ground)
		&& !collision_rectangle(bbox_right+hr, bbox_bottom+GROUND_DRAWY, bbox_left+hr, bbox_top, obj_floor, 1, 1) {
			x+=hr
		} else {
			repeat(abs(hr)*2){
				//速度正值
				if!((collision_rectangle(bbox_right+1,bbox_bottom+GROUND_DRAWY-4,bbox_left,bbox_top,obj_ground,1,1) && image_yscale=1)
				||(collision_rectangle(bbox_right+1,bbox_bottom,bbox_left,bbox_top-GROUND_DRAWY+4,obj_ground,1,1) && image_yscale=-1))
				&& sign(hr)=1
					x+=0.5*sign(hr)
				//速度负值
				if!((collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY-4,bbox_left-1,bbox_top,obj_ground,1,1) && image_yscale=1)
				||(collision_rectangle(bbox_right,bbox_bottom,bbox_left-1,bbox_top-GROUND_DRAWY+4,obj_ground,1,1) && image_yscale=-1))
				&& sign(hr)=-1
					x+=0.5*sign(hr)
				//斜坡上坡
				if image_yscale=1{
					while collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY,bbox_left,bbox_bottom+GROUND_DRAWY-4,obj_ground,1,1)
						&&!collision_rectangle(bbox_right,bbox_bottom-GROUND_DRAWY-4,bbox_left,bbox_top+4,obj_ground,1,1)
						y-=image_yscale
					
					if place_meeting(x,y+GROUND_DRAWY+2,obj_ground) && !place_meeting(x,y+GROUND_DRAWY+1,obj_ground)
						y+=image_yscale
					
					while collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY,bbox_left,bbox_bottom+GROUND_DRAWY-4,obj_floor,1,1)
						&&!collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY-4,bbox_left,bbox_bottom+GROUND_DRAWY-8,obj_floor,1,1)
						y-=image_yscale
					
					if collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY+2,bbox_left,bbox_bottom+GROUND_DRAWY+1,obj_floor,1,1)
					&&!collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY+1,bbox_left,bbox_bottom+GROUND_DRAWY,obj_floor,1,1)
						y+=image_yscale
				}
				else if image_yscale=-1{
					while collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY,bbox_left,bbox_top-GROUND_DRAWY+4,obj_ground,1,1)
						&&!collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY+4,bbox_left,bbox_bottom-4,obj_ground,1,1)
						y-=image_yscale
					
					if place_meeting(x,y-GROUND_DRAWY-2,obj_ground) && !place_meeting(x,y-GROUND_DRAWY-1,obj_ground)
						y+=image_yscale
					
					while collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY+4,bbox_left,bbox_top-GROUND_DRAWY,obj_floor,1,1)
						&&!collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY+8,bbox_left,bbox_top-GROUND_DRAWY+4,obj_floor,1,1)
						y-=image_yscale
					
					if collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY-1,bbox_left,bbox_top-GROUND_DRAWY-2,obj_floor,1,1)
					&&!collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY,bbox_left,bbox_top-GROUND_DRAWY-1,obj_floor,1,1)
						y+=image_yscale
				}
			}
		}
		//纵向移动
		var yoff = image_yscale*vsp,
			ground = place_meeting(x,y+GROUND_DRAWY+yoff,obj_ground),
			sink = place_meeting(x,y+GROUND_DRAWY,obj_sink),
			flor = (image_yscale=1 && collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY+yoff,bbox_left,bbox_bottom+GROUND_DRAWY,obj_floor,1,1) 
					&& !collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY-1,bbox_left,bbox_bottom+GROUND_DRAWY-2,obj_floor,1,1))
				|| (image_yscale=-1 && collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY,bbox_left,bbox_top-GROUND_DRAWY+yoff,obj_floor,1,1) 
					&& !collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY+2,bbox_left,bbox_top-GROUND_DRAWY+1,obj_floor,1,1))
		if !ground
		&& !sink
		&& !(flor && vsp>0) {
			y+=yoff
		} else {
			repeat(2*abs(vsp)){
				var rground = place_meeting(x,y+((vsp>0 ? GROUND_DRAWY : 0) + 0.5)*image_yscale*sign(vsp),obj_ground),
					rsink = place_meeting(x,y+GROUND_DRAWY,obj_sink),
					rflor = (image_yscale=1 && collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY+1,bbox_left,bbox_bottom+GROUND_DRAWY,obj_floor,1,1) 
							&& !collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY-1,bbox_left,bbox_bottom+GROUND_DRAWY-2,obj_floor,1,1))
						|| (image_yscale=-1 && collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY+2,bbox_left,bbox_top-GROUND_DRAWY-1,obj_floor,1,1) 
							&& !collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY+2,bbox_left,bbox_top-GROUND_DRAWY+1,obj_floor,1,1))
				if !rground
				&& !rsink
				&& !(rflor && vsp>0)
					y+=0.5*image_yscale*sign(vsp)
			}
		}
		//重力加速度
		if etp=0{
			var ground = place_meeting(x,y+((vsp>0 ? GROUND_DRAWY : 0) + 0.5)*image_yscale*sign(vsp),obj_ground),
				sink = place_meeting(x,y+GROUND_DRAWY,obj_sink),
				flor = (image_yscale=1 && collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY+1,bbox_left,bbox_bottom+GROUND_DRAWY,obj_floor,1,1) 
						&& !collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY-1,bbox_left,bbox_bottom+GROUND_DRAWY-2,obj_floor,1,1))
					|| (image_yscale=-1 && collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY+2,bbox_left,bbox_top-GROUND_DRAWY-1,obj_floor,1,1) 
						&& !collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY+2,bbox_left,bbox_top-GROUND_DRAWY+1,obj_floor,1,1))
			if !ground
			&& !sink 
			&& !(flor && vsp>0)
				vsp+=grav
			else vsp=0
		}
	}
	//无视墙壁
	else{
		x+=hsp
		y+=vsp
	}
	//摩擦力
	if abs(hsp)>0{
		var HSP=hsp
		hsp-=hfrict*sign(hsp)
		if sign(HSP)=-sign(hsp) hsp=0
	}
	/*if vsp>0{
		vsp-=vfrict*sign(vsp)
		if vsp<0 vsp=0
	}*/


}
/// @desc 击飞移动系统
function scr_enemy_push_move_system() {
	if speed=0 && gravity=0
		gravity=G
	var other_enemy=collision_rectangle(bbox_right+hspeed,bbox_bottom+vspeed,bbox_left+hspeed,bbox_top+vspeed,obj_enemy,1,1)
	if other_enemy && !instance_is_object(other_enemy,obj_enemy_bodypart){
		var otherpush=false//被撞到的敌人是否一起飞走
		with other_enemy{
			if hp>0 && injure_type!=ATK_TYPE.push{
				if(push_fly=0 ||(push_fly=1 && hp<=4) || push_fly=3)
				&& undm_push{
					if push_fly=0 hp=0
					//image_xscale=other.image_xscale
					inxscale=sign_no0(other.x-x)
					injure_type=ATK_TYPE.push
					speed=other.speed
					direction=other.direction
					gravity=other.gravity
					otherpush=true
				}
				else if undm=0{
					hp-=4
					final_selfInjure();
				}
			}
		}
		if !otherpush final_selfBoom();
	}
	if place_meeting(x+hspeed,y+GROUND_DRAWY+vspeed,obj_ground)
	||(collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY+vspeed,bbox_left,bbox_bottom+GROUND_DRAWY,obj_floor,1,1) && vspeed>=0)
	|| place_meeting(x+hspeed,y+GROUND_DRAWY+vspeed,obj_sink){
		injure_type=ATK_TYPE.bullet
		speed=0
		gravity=0
		if push_fly=3 && hp>0//落地不死亡
			pushFalloverSave();
		else{//落地死亡
			final_selfBoom();
		}
	}
}