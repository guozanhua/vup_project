scr_menu_stop();
if(!scr_menu_trem()) exit;
scr_time_alarm();
scr_enemy_step();
#region 出视野刷新
//进入过视野
if(view==0) {
	if(auto_xscale==1) 
		image_xscale=sign_no0(obj_player.x-x);
	if(scr_in_view(view_edge) && view_edge>=0)
	|| view_edge<0 {
		view=1;
	}
}
//离开房间
if(!scr_in_roomall(view_edge)
&& view_edge>=0)
	event_user(0);
//如果死亡后复活(不复活的不考虑刷新)
if(death_repeat==1) {
    //出视野复活判断临时变量
    var init_disx=init_x-obj_player.x,
		init_disy=init_y-obj_player.y,
		deth_disx=x-obj_player.x,
		deth_disy=y-obj_player.y,
		dis_canrelife=true;
    //判读方位是否满足复活条件
    dis_canrelife = dis_canrelife && (init_disx*deth_disx>=0);
        
    //出视野刷新
    if(((view==1 && out_reflash==1) || injure_type==-1)//进入过视野或者已经死亡
    && !scr_in_view_arg(init_x,init_y,view_edge)//重生点不在范围内
    && !scr_in_view(destory_edge)//自身离开消灭范围
    && dis_canrelife) //坐标点满足位置条件
	{
    	new_self = instance_create_depth(init_x,init_y,init_depth,object_index);
		final_reflashSetVars();
		reflashSetVars();
    	instance_destroy();
    }
}
#endregion
#region 消灭
#region 其他死亡
if(hp<=0 && use_death_system==1) {
	gravity_direction=270;
	if(abs(vspeed)>=abs(gravity)*vspmaxn
	&& gravity!=0) {
		vspeed=gravity*vspmaxn;
		gravity=0;
	}
	if(death_type_use==0)  
		injure_type=ATK_TYPE.bullet;
	#region 死亡属性特效
	scr_enemy_element_death(injure_element);
	element_index=0;
	injure_element=ELEMENTS.none;
	#endregion
	#region 枪伤爆炸
	if(injure_type==ATK_TYPE.bullet) {
		if(!evuser2ed) {
			deathTrigger();
			evuser2ed=true;
		}
		scr_sprite_change(spr_none,0,0);
		if(death_xscale==1) 
			image_xscale=-inxscale;
		scr_enemy_boom_number();
		scr_enemy_boompart(SS_part);
		//道具
		if(item==0) {
			item=1;
			scr_enemy_create_item();
		}
		injure_type=-1;
		speed=0;
		gravity=0;
		x=xstart;
		y=ystart;
		if(variable_instance_exists(id,"death_repeat")) 
			if death_repeat=0 instance_destroy();
	}
	#endregion
	#region 切割
	else if(injure_type==ATK_TYPE.cut) {
		if(!evuser2ed) {
			deathTrigger();
			evuser2ed=true;
		}
		scr_sprite_change(SS_death,1,0);
		if(death_xscale==1)  
			image_xscale=-inxscale;
		if(death_boom==0) {
			wait_time=15;
			injure_type=1.1;
			//半身
			with(instance_create_depth(x,y,depth-1,obj_enemy_half)) {
				scr_sprite_change(other.SS_death,2,0);
				image_xscale=other.image_xscale;
				image_yscale=other.image_yscale;
				image_angle=other.image_angle;
				speed=other.speed;
				direction=other.direction;
				dis_dir=other.image_angle;
				fall=other.enemy_type;
				wait_time=other.wait_time;
				boom_number=other.boom_number;
				enemy=other.id;
				//悬浮敌人
				if(other.enemy_type==1) {
					other.hspeed=0.5*other.image_xscale;
					hspeed=-other.hspeed;
				}
				//半身动作
				if(other.half_action==1 || other.half_action==2) {
					fall=1;
					hspeed=3*sign(other.inxscale);
					vspeed=-4*image_yscale;
				}
				if(other.half_action==2) 
					dspeed=36;
			}
		}
		else {
			injure_type=ATK_TYPE.bullet;
			wait_time=0;
		}
		if(!place_meeting(x,y+4,obj_ground)
		&& !place_meeting(x,y+4,obj_sink)
		&& !collision_rectangle(bbox_right,bbox_bottom+4,bbox_left,bbox_bottom,obj_floor,1,1)
		&& grav>0)
			enemy_type=1;
		//喷血
		scr_enemy_blood();
	}
	#endregion
	#region 贯穿
	//else if(injure_type==ATK_TYPE.through) {
	//	if(!evuser2ed) {
	//		deathTrigger();
	//		evuser2ed=true;
	//	}
	//	scr_sprite_change(SS_death,3,0);
	//	if(death_xscale==1)  
	//		image_xscale=-inxscale;
	//	if(death_boom==0) {
	//		injure_type=3.1;
	//		wait_time=30;
	//	} else {
	//		injure_type=ATK_TYPE.bullet;
	//		wait_time=0;
	//	}
	//	if(SS_part!=spr_none) 
	//		scr_enemy_death_through();
	//}
	#endregion
	#region 切割中&贯穿中
	else if(injure_type==1.1
	|| injure_type==3.1) {
		#region 地上
		if(enemy_type==0) {
			if(wait_time>0) {
				wait_time-=1;
				//落空
				if(!place_meeting(x,y+4,obj_ground)
				&& !place_meeting(x,y+4,obj_sink)
				&& !collision_rectangle(bbox_right,bbox_bottom+4,bbox_left,bbox_bottom,obj_floor,1,1)
				&& grav>0) {
					enemy_type=1;
					gravity=grav;
				}
				//上坡
				else if((collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_bottom-8,obj_ground,1,1)
				&&!collision_rectangle(bbox_right,bbox_bottom-8,bbox_left,bbox_top,obj_ground,1,1))
				||(collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_bottom-8,obj_sink,1,1)
				&&!collision_rectangle(bbox_right,bbox_bottom-8,bbox_left,bbox_top,obj_sink,1,1))
				||(collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_bottom-8,obj_floor,1,1)
				&&!collision_rectangle(bbox_right,bbox_bottom-8,bbox_left,bbox_top,obj_floor,1,1))) {
					while(collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_bottom-8,obj_ground,1,1)
					|| collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_bottom-8,obj_sink,1,1)
					|| collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_bottom-8,obj_floor,1,1)) {
						y-=1;
					}
				}
				//撞墙
				else if(collision_rectangle(bbox_right,bbox_bottom-8,bbox_left,bbox_top,obj_ground,1,1)
				|| collision_rectangle(bbox_right,bbox_bottom-8,bbox_left,bbox_top,obj_sink,1,1)) {
					wait_time=0;
				}
			}
			else{
				injure_type=ATK_TYPE.bullet;
			}
		}
		#endregion
		#region 落下
		else if(enemy_type==1) {
			gravity=grav;
			if(place_meeting(x,y,obj_ground)
			|| place_meeting(x,y,obj_sink)
			|| collision_rectangle(bbox_right,bbox_bottom+1,bbox_left,bbox_bottom-1,obj_floor,1,1)
			|| death_boom==1) {
				injure_type=ATK_TYPE.bullet;
			}
		}
		#endregion
	}
	#endregion
}
#endregion
#endregion
#region 水中重力
var instwater = instance_place(x,y,obj_water);
if(instwater) {
	if(instwater.mucus) {
		if(speed>1) speed=1;
	}
	if(gravity=grav) 
		gravity=grav/(5/4);
}
else{
	if(gravity=grav/(5/4)) 
		gravity=grav;
}
#endregion