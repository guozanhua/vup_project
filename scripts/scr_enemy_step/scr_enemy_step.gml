function scr_enemy_step(){
#region 残影
	if scr_menu_trem(){
		//当前激活残影数
		if afterimage 
			afimg_count_now=afimg_count
		else if afimg_count_now>0 afimg_count_now--
		//残影坐标
		for(var i=afimg_count;i>=0;i-=1){
			if i<=(afimg_count-afimg_count_now){
				afimg_x[i]=x
				afimg_y[i]=y-GROUND_DRAWY
			}
			else if i>0{
				afimg_x[i]=afimg_x[i-1]
				afimg_y[i]=afimg_y[i-1]
			}
		}
		if whiteimage whiteimage_time++
		else whiteimage_time=0
	}
#endregion
#region 判定恢复
	if(injure_unrepeat!=0 
	|| injure_unrepeat_undm!=0){
		var damage=collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_top,obj_player_attack,1,1),
			noplace=false;
		if(damage) {
			if(damage.attack<=0) {
				noplace=true;
			}
		} else{
			noplace=true;
		}
		if(noplace) {
			injure_unrepeat=0;
			injure_unrepeat_undm=0;
		}
	}
#endregion
#region 属性伤害计时
	//scr_enemy_element_recover()
#endregion
//以下内容为敌方目标
if !object_is_ancestor(object_index,obj_enemy)
&& !object_is_ancestor(object_index,obj_boss)
	exit
#region 运动系统
	if use_speed_system=1{
		//击飞运动系统
		if injure_type=ATK_TYPE.push {
			if instance_is_object(object_index,obj_enemy){
				scr_enemy_push_move_system()
			}
		} 
		//普通移动
		else if (hp>0 || death_use_speed_system)
		&& ((object_is_ancestor(object_index,obj_boss) &&(global.boss_war=1||global.player_hp<=0))
			||!object_is_ancestor(object_index,obj_boss)){
			scr_enemy_move_system()
		}
	}
#endregion
//以下内容为enemy单独使用
if !object_is_ancestor(object_index,obj_enemy) exit
#region 受伤击退
	if hp>0{
		element_ssinjure=0
		//元素僵硬
		if injure_element!=ELEMENTS.none//带属性
		&& injure_element!=ELEMENTS.fire//不是火属性
		&& injure_elementback=1//属性击退
		{
			scr_sprite_change(SS_injure,0,1/10)
			action=-1
			hsp=0
			element_ssinjure=1
			if injure_elementfall=0{
				if injure_type!=2 speed=0
			}
			else{
				if place_meeting(x,y+image_yscale,obj_ground)
				|| collision_rectangle(bbox_right,bbox_bottom+2,bbox_left,bbox_bottom-2,obj_floor,1,1)
				|| place_meeting(x,y+image_yscale,obj_sink){
					speed=0
					gravity=0
					while place_meeting(x,y,obj_ground)
					|| place_meeting(x,y,obj_sink)
					|| collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_bottom-2,obj_floor,1,1)
						y-=image_yscale
				}
				else
					gravity=grav
			}
		}
		//属性击退
		else{
			if injure_type!=ATK_TYPE.push && use_speed_system=1 
				gravity=0
			if flash=1
			&& injure_back=1{
				scr_sprite_change(SS_injure,0,1/10)
				action=-1
				if inxscale!=0 hsp=1*inxscale
				else hsp=-1*image_xscale
			}
		}
		//元素攻击中恢复
		if sprite_index=SS_injure
		&& element_ssinjure=1
		&& injure_elementback=1
		&& element_index=0{
			scr_sprite_change(SS_idle,0,1/60)
			hsp=0
			element_ssinjure=0
			action=0
			time=30
		}
	}
#endregion
#region 尖刺炸死
	if enemy_prick=1
	&& hp>0{
		if collision_rectangle(bbox_right+1,bbox_bottom+1,bbox_left-1,bbox_top-1,obj_prick,1,1)
		|| collision_rectangle(bbox_right+1,bbox_bottom+1,bbox_left-1,bbox_top-1,obj_flyground_prick,1,1){
			var prick1list=ds_list_create(),
				prick1listcnt=0,
				prick2list=ds_list_create(),
				prick2listcnt=0
			var prick1listcnt=collision_rectangle_list(bbox_right,bbox_bottom+1,bbox_left,bbox_top-1,obj_ground,1,1,prick1list,false), //上下
				prick2listcnt=collision_rectangle_list(bbox_right+1,bbox_bottom,bbox_left-1,bbox_top,obj_ground,1,1,prick2list,false) //上下
			var prick1=false, 
				prick2=false
			//横向撞击尖刺判定
			if prick1listcnt>0 prick1=true
			for(var i=0;i<prick1listcnt;i++){
				var prick=prick1list[| i]
				//冷却岩浆
				if instance_is_object(prick, obj_flyground_prick){
					if prick.damage<=0{
						prick1=false
						break
					}
				} 
				//普通墙壁
				else if!instance_is_object(prick, obj_prick){
					prick1=false
					break
				} 
			}
			//纵向撞击尖刺判定
			if prick2listcnt>0 prick2=true
			for(var i=0;i<prick2listcnt;i++){
				var prick=prick2list[| i]
				//冷却岩浆
				if instance_is_object(prick, obj_flyground_prick){
					if prick.damage<=0{
						prick2=false
						break
					}
				} 
				//普通墙壁
				else if!instance_is_object(prick, obj_prick){
					prick2=false
					break
				} 
			}
			if(prick1||prick2){
				final_selfBoom();
				if scr_in_view(view_edge) scr_sound_play(se_enemy_damage)
			}
		}
	}
#endregion
#region 挤压致死
	if hp>0
	&& enemy_or_bullet==1
	&& enemy_ground==1{
		var flyobj=collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_top,obj_flyground,1,1),
			block=collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_top,obj_ground_block_bullet,1,1)
		if(flyobj && flyobj.speed>0)
		||(block){
			final_selfBoom();
			if scr_in_view(view_edge) scr_sound_play(se_enemy_damage)
		}
	}
#endregion
}