scr_menu_stop();
if(global.operate!=1 || global.player_operate!=1) {
	//if(!scr_player_debuff_is(DEBUFF.none)) {
	//	scr_player_debuff_clear();
	//}
	//injure_element=ELEMENTS.none;
}
if walk<0 || jump<0
|| global.operate!=1{
	clearBullets();
}
if(!scr_menu_trem()) exit;
scr_time_alarm();
#region 数据处理
	#region 残影设定
	if(dash==1) 
		afterdash=0;
	else if(dash==0) {
		if(afterdash<8) 
			afterdash+=1;
		l_dash=0;
	}
	if(walk!=2) 
		l_dash=0;
	for(var i=8;i>=0;i-=1){
		if(i<=afterdash) {
			px[i]=x;
			py[i]=y;
		}
		else if(i>0) {
			px[i]=px[i-1];
			py[i]=py[i-1];
		}
	}
	#endregion
	#region 爬墙跳初始化
	if(jump!=4) 
		jump_craw=0;
	#endregion
	#region 冲刺指令
	if(dash_time_l>0) dash_time_l-=1;
	if(dash_time_r>0) dash_time_r-=1;
	if(dash_time_t>0) dash_time_t-=1;
	if(dash_time_b>0) dash_time_b-=1;
	if(dash_order_time_H>0) dash_order_time_H-=1;
	if(dash_order_time_V>0) dash_order_time_V-=1;
	//横向冲刺使用中
	if(walk!=2 //地面冲刺
	&& jump!=9 //空中冲刺
	&& jump!=13)//水中冲刺
	{
		if(dash_order_time_H==-1) 
			dash_order_time_H=0;
	}
	//纵向冲刺使用中
	if(jump!=13 //水中冲刺
	&& jump!=10 //对空冲刺
	&& jump!=21)//向下冲刺
	{
		if(dash_order_time_V==-1)
			dash_order_time_V=0;
	}
	//冲刺指令转换
	if(dash_can==1 
	&& global.dash_order==1) {
		//横向
		if(keystate_check_pressed(global.left_state)) {
			dash_time_r=0;
			if(dash_time_l==0) 
				dash_time_l=dash_order_alarm;
			else if(dash_time_l>0) {
				dash_time_l=0;
				dash_order_time_H=dash_order_alarm;
			}
		}
		else if(keystate_check_pressed(global.right_state)) {
			dash_time_l=0;
			if(dash_time_r==0) 
				dash_time_r=dash_order_alarm;
			else if(dash_time_r>0) {
				dash_time_r=0;
				dash_order_time_H=dash_order_alarm;
			}
		}
		//纵向
		if(keystate_check_pressed(global.up_state)) {
			dash_time_b=0;
			if(dash_time_t==0) 
				dash_time_t=dash_order_alarm;
			else if dash_time_t>0{
				dash_time_t=0;
				dash_order_time_V=dash_order_alarm;
			}
		}
		else if(keystate_check_pressed(global.down_state)) {
			dash_time_t=0;
			if(dash_time_b==0) 
				dash_time_b=dash_order_alarm;
			else if(dash_time_b>0) {
				dash_time_b=0;
				dash_order_time_V=dash_order_alarm;
			}
		}
	}
	#endregion
	#region 超级冲刺
	//if(scr_itemb_isrun(ITEMB.super_dash)) l_dashup=floor(30*1.5);
	//else 
		l_dashup=30;
	#endregion
	#region 蓄力动画帧数
	//if(global.main_sub_exchange[global.model]==0) {
	//	uncharge[1]=obj_staff.player_uncharge[model][1];
	//	uncharge[2]=obj_staff.player_uncharge[model][2];
	//}
	//else if(global.main_sub_exchange[global.model]==1) {
	//	uncharge[1]=obj_staff.player_uncharge[model][2];
	//	uncharge[2]=obj_staff.player_uncharge[model][1];
	//}
	for(var i=1;i<=2;i+=1){
		if(charge[i]>=30 || charge_break[i]==4) {
			charge_index[i]+=0.25;
			charge_index[i]=charge_index[i] mod 24;
		}
		else charge_index[i]=0;
	}
	#endregion
#endregion
if(!scr_player_stop_trem()) exit;
#region 蓄力
for(var i=1;i<=2;i+=1){
	if(uncharge[i]==0) {
		if(charge_break[i]==3) charge_break[i]=4;
		if(charge_break[i]==4) {
			//放出
			if((scr_player_charge_mainkey_status()==1 && i==1)
			||(scr_player_charge_subkey_status()==1 && i==2)) {
				scr_player_charge_release(i);
			}
		}
		else{
			//取消
			if(charge_break[i]!=0) {
				charge[i]=0;
				charge_break[i]=0;
			}
			//蓄力
			if((scr_player_charge_mainkey_status()>1 && i==1)
			||(scr_player_charge_subkey_status()>1 && i==2)) {
				if(charge[i]<30) charge[i]+=0.5;
				else if(charge[i]<charge_max) {
					charge[i]+=1;
				}
				else charge[i]=charge_max;
			}
			//释放
			else if(((scr_player_charge_mainkey_status()<=1 && i==1)
				||(scr_player_charge_subkey_status()<=1 && i==2))
			&& global.player_operate==1)
				scr_player_charge_release(i);
		}
	}
	else{
		charge[i]=0;
		charge_break[i]=0;
	}
}
//if(scr_is_talking()) scr_player_charge_clear();
#endregion
#region 动作
	#region 地上
	if(jump==0) {
		#region 半踏板挤压
		while(collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_bottom-1,obj_floor,1,1))
			y-=image_yscale;
		#endregion
		#region 站立待机
		if(walk==0) {
		    //普通站立动作（仅与受伤站立切换）
			if(sprite_index==SS_idle
			&& global.player_hp<=3) 
				scr_sprite_change(SS_idle2,-2,-2);
			//受伤站立动作（仅与普通站立切换）
			else if(sprite_index==SS_idle2
			&& global.player_hp>3) 
				scr_sprite_change(SS_idle,-2,-2);
		    //左右走路
			if(keystate_check(global.left_state) || keystate_check(global.right_state)) {
				scr_sprite_change(SS_walk,0,0.25);
				walk=1;
				hsp=walkspd*hspd;
				if(keystate_check(global.left_state)) 
					image_xscale=-1;
				else if(keystate_check(global.right_state)) 
					image_xscale=1;
			}
		}
		#endregion
		#region 走路
		if(walk==1) {
			if(keystate_check(global.left_state)) 
				image_xscale=-1;
			else if(keystate_check(global.right_state)) 
				image_xscale=1;
			else{
				scr_sprite_change(SS_idle,0,0.25);
				walk=0;
				hsp=0;
			}
		}
		#endregion
		#region 冲刺
		if(walk==2) {
			if(keystate_check(global.left_state)) 
				image_xscale=-1;
			else if(keystate_check(global.right_state)) 
				image_xscale=1;
			if(l_dash>=5
			&&((dash_order_time_H>=0 && !keystate_check(global.dash_state))
			|| (dash_order_time_H=-1 && !keystate_check(global.left_state) && !keystate_check(global.right_state))
			|| (l_dash>=l_dashup))) {
				scr_sprite_change(SS_dashed,0,0.25);
				dash=0;
				walk=0;
				hsp=0;
				dash_time_l=0;
				dash_time_r=0;
				dash_order_time_H=0;
			}
			if(l_dash<l_dashup) 
				l_dash+=1;
		}
		#endregion
		#region 斩击动作
		if(walk==4) {
			hsp=0
		}
		#endregion
		#region 进入冲刺
		if((walk==0 || walk==1)
		&& dash_can==1){
			if(dash_order_time_H>0
			|| scr_player_dash_cor()) {
				scr_sprite_change(SS_dash,0,0.25);
				//如果不是左右两侧被包围
				/*if(!collision_rectangle(bbox_right+8,bbox_bottom-8,bbox_right,bbox_top,obj_ground,1,1)
				||!collision_rectangle(bbox_left,bbox_bottom-8,bbox_left-8,bbox_top,obj_ground,1,1)) {
					//出墙处理
					while(collision_rectangle(bbox_right+8,bbox_bottom-8,bbox_right,bbox_top,obj_ground,1,1) && image_xscale==1) x-=1;
					while(collision_rectangle(bbox_left,bbox_bottom-8,bbox_left-8,bbox_top,obj_ground,1,1) && image_xscale==-1) x+=1;
				}*/
				dash=1;
				walk=2;
				hsp=dashspd*hspd;
				if(dash_order_time_H>0) dash_order_time_H=-1;
				//发射烟雾
				if(!place_meeting(x,y,obj_water)) {
					with(instance_create_depth(x,y+32*image_yscale,depth-1,obj_animation_once)) {
						scr_sprite_change(spr_player_dash_somke,0,0.25);
						image_xscale=other.image_xscale//*1.5;
						image_yscale=other.image_yscale//*1.5;
						if(place_meeting(x,y,obj_water)) instance_destroy();
					}
				}
				//发射爆圈
				dash_boost_inst=instance_create_depth(x,y,depth-1,obj_animation_once);
				with(dash_boost_inst) {
					scr_sprite_change(spr_player_dash_boost,0,0.5);
					image_xscale=other.image_xscale;
					image_yscale=other.image_yscale;
				}
				scr_sound_play(se_player_dash);
			}
		}
		#endregion
		#region 落下半透板
		var flordown = collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY+1,bbox_left,bbox_bottom+GROUND_DRAWY,obj_floor,1,1);
		if(image_yscale==-1)  
			flordown = collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY,bbox_left,bbox_top-GROUND_DRAWY-1,obj_floor,1,1);
		if((flordown
		&&!collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY+1,bbox_left,bbox_bottom+GROUND_DRAWY,obj_ground,1,1)
		&& image_yscale==1)
		||(flordown
		&&!collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY,bbox_left,bbox_top-GROUND_DRAWY-1,obj_ground,1,1)
		&& image_yscale==-1)) {
			if(((image_yscale==1 && keystate_check(global.down_state))
			||(image_yscale==-1 && keystate_check(global.up_state)))
			&& keystate_check_pressed(global.jump_state)) {
				//y+=5*image_yscale;
				while(place_meeting(x,y+GROUND_DRAWY,obj_ground)) y-=image_yscale;
				scr_sprite_change(SS_jumped,0,0.25);
				if(walk==8 || walk==2)
					scr_player_outground();
				jump=2;
				walk=0;
				if(ice==0) {
					dashHspeed(1);
				}
				else if(ice==1) {
					if(abs(dis_x)<1*hspd) 
						hsp=1*hspd;
					else
						hsp=image_xscale*dis_x*hspd;
				}
				scr_player_floordown_set(flordown);
			}
		}
		#endregion
		#region 落空
		var leftshf = ((image_xscale==-1) ? 1 : 0), rightshf = ((image_xscale==1) ? 1 : 0);
		var topshf = ((image_yscale==-1) ? 1 : 0), bottomshf = ((image_yscale==1) ? 1 : 0);
		var dashbox=((walk==2||walk==5) ? 1 : 0)*8,
			dleft=dashbox*rightshf*-1,
			dright=dashbox*leftshf*1;//冲刺的多余部分
		var flordown = collision_rectangle(bbox_right+dright,bbox_bottom+GROUND_DRAWY+2,bbox_left+dleft,bbox_bottom+GROUND_DRAWY,obj_floor,1,1);
		if(image_yscale==-1) 
			flordown = collision_rectangle(bbox_right+dright,bbox_top-GROUND_DRAWY,bbox_left+dleft,bbox_top-GROUND_DRAWY-2,obj_floor,1,1);
		//记录的半透板
		if(scr_player_floordown_exists(flordown)) flordown=noone;
		if(!collision_rectangle(bbox_right+dright,bbox_bottom+GROUND_DRAWY+2*bottomshf,bbox_left+dleft,bbox_top-2*topshf,obj_ground,1,1)
		&&!((image_yscale==1 && collision_rectangle(bbox_right+dright,bbox_bottom+GROUND_DRAWY+1,bbox_left+dleft,bbox_top,obj_sink,1,1))
		|| (image_yscale==-1 && collision_rectangle(bbox_right+dright,bbox_bottom,bbox_left+dleft,bbox_top-GROUND_DRAWY-1,obj_sink,1,1)))
		&&!((image_yscale==1
		&& flordown
		&&!collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY-1,bbox_left,bbox_bottom+GROUND_DRAWY-2,obj_floor,1,1))
		|| (image_yscale==-1
		&& flordown
		&&!collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY+2,bbox_left,bbox_top-GROUND_DRAWY+1,obj_floor,1,1)))) {
			scr_sprite_change(SS_jumped,0,0.25);
			if(in(walk, [2, 8]))
				scr_player_outground();
			jump=2;
			walk=0;
			if(ice==0) {
				dashHspeed(1);
			}
			else if(ice==1) {
				if(abs(dis_x)<1*hspd) 
					hsp=1*hspd;
				else
					hsp=image_xscale*dis_x*hspd;
			}
		}
		#endregion
		#region 跳跃
		if((walk==0 || walk==1 || walk==2
		 ||(walk==8 && !scr_player_collcreep()))
		&& jump==0) {
			if(keystate_check_pressed(global.jump_state)) {
				scr_sprite_change(SS_jump,0,0.25);
				walk=0;
				jump=1;
				vsp=-vspd;
				scr_sound_play(SE_jump);
				if(ice==0) {
					dashHspeed(1);
				}
				else if(ice==1) {
					if(image_xscale*dis_x<1*hspd) 
						hsp=1*hspd;
					else
						hsp=image_xscale*dis_x*hspd;
				}
			}
		}
		#endregion
		#region 摔倒
		if walk=9{
			
		}
		#endregion
	}
	#endregion
	#region 空中
	else{
		#region 空中动作集体调整
		//空中转向
		if(in(jump, [1, 23])
		|| in(jump, [2, 8])) {
			if(keystate_check(global.left_state) || keystate_check(global.right_state)) {
				var old_xscale=image_xscale;
				if(keystate_check(global.left_state))  image_xscale=-1;
				else if(keystate_check(global.right_state)) image_xscale=1;
				w_j=1;
				if(dash==0){
					if(hsp>=walkspd*hspd) 
						hsp=walkspd*hspd;
					else if(hsp<0) 
						hsp*=-1;
				} else if(dash==1) {
					if(hsp>=dashspd*hspd) 
						hsp=dashspd*hspd;
					else if(hsp<0) 
						hsp*=-1;
				}
				if(sprite_index==SS_crawjump && old_xscale!=image_xscale) 
					scr_sprite_change(SS_jumping,0,0.25);
			}
			else{
				if(sprite_index==SS_crawjump) 
					scr_sprite_change(SS_jumping,0,0.25);
				w_j=0;
			}
		}
		//冲刺辅助消除
		if(jump!=1) jump_dash=0;
		#endregion
		#region 跳起
		if(in(jump, [1, 23])) {
			//辅助跳跃
			if(jump_dash<6) {
				jump_dash+=1;
				if(scr_player_dash_cor()
				&& dash_can==1) {
					dash=1;
					hsp=dashspd*hspd;
				}
			}
			//撞顶
			if(place_meeting(x,y,obj_sink)) vsp=0;
			var colltop=place_meeting(x,y-1*image_yscale,obj_ground),
				jumptop=(vsp*image_yscale>=0),
				jump_released=(!keystate_check(global.jump_state) && jump==1);
			if(colltop
			|| jumptop
			|| jump_released) {
				if(vsp<0) vsp=0;
				if(in(sprite_index, [SS_jump, SS_jumping, SS_crawjump]))
					scr_sprite_change(SS_jumped,0,0.25);
				jump=2;
			}
		}
		#endregion
		#region 爬墙下滑
		if(jump==3) {
			vsp=cspd;
			//下滑速度0时不播放头发动画
			if(vsp==0 && sprite_index==SS_crawing) 
				scr_sprite_change(-2, 0, 0);
			var craw_ground=collision_rectangle(bbox_right-1*image_xscale,
												bbox_bottom-2,
												bbox_left-1*image_xscale,
												bbox_top+2, obj_ground_untrg,1,1);
			//反向松开按键
			if((!keystate_check(global.left_state) && !keystate_check(global.right_state))
			||(keystate_check(global.right_state) && !keystate_check(global.left_state) && image_xscale==1)
			||(keystate_check(global.left_state) && !keystate_check(global.right_state) && image_xscale==-1)
			|| sign(wind_spd)==image_xscale) {
				var precoll=place_meeting(x,y,obj_ground);
				if(sprite_index==SS_craw) 
					image_xscale*=-1;
				while(!precoll && place_meeting(x,y,obj_ground)) 
					x-=image_xscale;
				scr_sprite_change(SS_jumped,0,0.25);
				jump=2;
				vsp=0;
				//清空半透板记录
				scr_player_floordown_clear();
			}
			//落地
			else if(scr_player_Is_fallover(1,1,1,1)) {
				scr_sprite_change(SS_fallover,0,0.25);
				jump=0;
				walk=0;
				dash=0;
				hsp=0;
				vsp=0;
				scr_player_se_step();
				scr_player_fallover_adjust();
			}
			//滑到没墙、滑到冰墙、沾油
			else if(!craw_ground || craw_ground.ice==1) {
				scr_sprite_change(SS_jumped,0,0.25);
				jump=2;
				vsp=0;
			}
			//爬墙跳
			else if(keystate_check_pressed(global.jump_state)) {
				scr_sprite_change(SS_crawjump,0,0.25);
				jump=4;
				image_xscale*=-1;
				vsp=-vspd;
				if(keystate_check(global.dash_state)
				|| dash_order_time_H>0) 
					dash=1;
				
				dashHspeed(-1);
				jump_craw=0;
				scr_sound_play(SE_crawjump);
				with(instance_create_depth(x+16*image_xscale,y+24*image_yscale,depth-1,obj_animation_once)) {
					scr_sprite_change(spr_player_craw_light,0,0.25);
					image_xscale=other.image_xscale;
					image_yscale=other.image_yscale;
				}
				//清空半透板记录
				scr_player_floordown_clear();
			}
		}
		#endregion
		#region 下落中
		if(in(jump, [2, 8, 14])) {
			//三角跳用变量
			var dd=keystate_check(global.dash_state) ? 1 : 0,
				craw_ground=collision_rectangle(bbox_right+1*image_xscale,
												bbox_bottom-2*image_yscale,
												bbox_left+1*image_xscale,
												bbox_top+2*image_yscale, obj_ground_untrg,1,1),
				trg_ground=collision_rectangle(bbox_right+(4+dd*4)*image_xscale,
												bbox_bottom-2*image_yscale,
												bbox_left+(4+dd*4)*image_xscale,
												bbox_top+2*image_yscale, obj_ground_all,1,1),
				intrg_ground=collision_rectangle(bbox_right-(4+dd*4)*image_xscale,
												bbox_bottom-2*image_yscale,
												bbox_left-(4+dd*4)*image_xscale,
												bbox_top+2*image_yscale, obj_ground_all,1,1),
				combojump_ground=collision_rectangle(bbox_right,
													bbox_bottom+GROUND_DRAWY+4,
													bbox_left,
													bbox_bottom+GROUND_DRAWY, obj_ground,1,1);
				craw_ground = false;
			//落地
			if(scr_player_Is_fallover(0,0,4,3)
			&& ((jump==8 && vsp>=0) || jump!=8)) { //滑翔时下落才着地
				if(sprite_index==SS_craw) 
					image_xscale*=-1;
				scr_sprite_change(SS_fallover,0,0.25);
				walk=0;
				dash=0;
				hsp=0;
				jump=0;
				vsp=0;
				scr_player_se_step();
				scr_player_fallover_adjust();
			}
			//冲刺补偿跳
			var flordown = collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY+4,bbox_left,bbox_bottom+GROUND_DRAWY,obj_floor,1,1);
			if(image_yscale==-1) 
				flordown = collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY,bbox_left,bbox_top-GROUND_DRAWY-4,obj_floor,1,1);
			//记录的半透板
			if(scr_player_floordown_exists(flordown)) flordown=noone;
			if(((combojump_ground
			 && !instance_is_object(combojump_ground, obj_prick) 
			 && !(instance_is_object(combojump_ground, obj_flyground_prick) && combojump_ground.damage>0))
			||(image_yscale==1
			 && flordown
			 &&!collision_rectangle(bbox_right,bbox_bottom+GROUND_DRAWY,bbox_left,bbox_bottom+GROUND_DRAWY-1,obj_floor,1,1))
			||(image_yscale==-1
			 && flordown
			 &&!collision_rectangle(bbox_right,bbox_top-GROUND_DRAWY+1,bbox_left,bbox_top-GROUND_DRAWY,obj_floor,1,1))
			|| place_meeting(x,y+4*image_yscale,obj_sink))
			&& dash_can==1
			&& jump==2) {
				if(global.jump_cor>0 && global.jump_cor<3) {
					scr_sprite_change(SS_jump,0,0.25);
					walk=0;
					jump=1;
					vsp=-vspd;
					if(ice==0) {
						dashHspeed(1);
					}
					else if(ice==1) {
						if(image_xscale*dis_x<1*hspd) 
							hsp=1*hspd;
						else
							hsp=image_xscale*dis_x*hspd;
					}
					scr_sound_play(SE_jump);
					//清空半透板记录
					scr_player_floordown_clear();
				}
			}
			//爬墙
			else if(craw_ground && craw_ground.ice==0
			&&((keystate_check(global.left_state) && image_xscale==-1)
			 ||(keystate_check(global.right_state) && image_xscale==1))
			&& sign(wind_spd)!=-image_xscale
			&& craw_can==1
			&&!scr_player_icewall()
			&& jump!=14 && jump!=15) {
				scr_sprite_change(SS_craw,0,0.25);
				jump=3;
				vsp=cspd;
				dash=0;
				image_xscale*=-1;
				scr_player_se_step_craw();
			}
			//同向三角跳
			else if(trg_ground && trg_ground.ice==0
			&& craw_can==1
			&& jump==2
			&&!scr_player_icewall()) {
				if(keystate_check_pressed(global.jump_state)) {
					scr_sprite_change(SS_crawjump,0,0.25);
					//image_xscale*=-1;
					jump=4;
					vsp=-vspd;
					if(keystate_check(global.dash_state)
					|| dash_order_time_H>0) 
						dash=1;
					else
						dash=0;
				
					dashHspeed(-1);
					jump_craw=0;
					scr_sound_play(SE_crawjump);
					with(instance_create_depth(x+16*image_xscale,y+24*image_yscale,depth-1,obj_animation_once)){
						scr_sprite_change(spr_player_craw_light,0,0.25);
						image_xscale=other.image_xscale;
						image_yscale=other.image_yscale;
					}
					//清空半透板记录
					scr_player_floordown_clear();
				}
			}
			//反向三角跳
			else if(intrg_ground && intrg_ground.ice==0
			&& craw_can==1
			&& jump==2
			&&!scr_player_icewall()) {
				if(keystate_check_pressed(global.jump_state)) {
					scr_sprite_change(SS_crawjump,0,0.25);
					image_xscale*=-1;
					jump=4;
					vsp=-vspd;
					if(keystate_check(global.dash_state)
					|| dash_order_time_H>0) 
						dash=1;
					else
						dash=0;
				
					dashHspeed(-1);
					jump_craw=0;
					scr_sound_play(SE_crawjump);
					with(instance_create_depth(x+16*image_xscale,y+24*image_yscale,depth-1,obj_animation_once)){
						scr_sprite_change(spr_player_craw_light,0,0.25);
						image_xscale=other.image_xscale;
						image_yscale=other.image_yscale;
					}
					//清空半透板记录
					scr_player_floordown_clear();
				}
			}
		}
		#endregion
		#region 爬墙跳
		if(jump==4) {
			w_j=1;
			if(scr_player_dash_cor() && dash==0) {
				dash=1;
				hsp=-dashspd*hspd;
			}
			if(jump_craw<6) 
				jump_craw+=1;
			else{
				jump=1;
				if(hsp<0) hsp*=-1;
			}
			if(place_meeting(x,y,obj_sink)) vsp=0;
			if((keystate_check(global.left_state) && !keystate_check(global.right_state) && image_xscale==1)
			||(!keystate_check(global.left_state) && keystate_check(global.right_state) && image_xscale==-1)){
				scr_sprite_change(SS_jumping,0,0.25);
				//image_xscale*=-1;
				jump=1;
				if(hsp<0) hsp*=-1;
			}	
			
			if(place_meeting(x,y-1*image_yscale,obj_ground)
			|| vsp*image_yscale>=0
			|| !keystate_check(global.jump_state)) {
				if(vsp<0) vsp=0;
				if(in(sprite_index, [SS_jump, SS_jumping, SS_crawjump])) 
					scr_sprite_change(SS_jumped,0,0.25);
				jump=2;
				if(hsp<0) hsp*=-1;
			}
		}
		#endregion
		#region 摔落
		if(jump==19) {
			if(scr_player_Is_fallover(0,0,4,3)) {
				scr_sprite_change(SS_fallover,0,0.25);
				dash=0;
				hsp=0;
				jump=0;
				vsp=0;
				scr_player_se_step();
				scr_player_fallover_adjust();
			}
		}
		#endregion
		#region 悬崖保护
		if(jump==20) {
			if(cliff_protect_time>0) {
				cliff_protect_time--;
				image_alpha=cliff_protect_time mod 3;
				if(y>global.room_yb-32) {
					if(vsp>-1) vsp-=0.01;
				}
				else{
					//上飞
					if(keystate_check(global.up_state)) {
						if(vsp>-1) vsp-=0.1;
					}
					else if(vsp<0) vsp+=0.1;
				}
				var old_xscale=image_xscale;
				//左右飞行
				if(keystate_check(global.left_state)) {
					image_xscale=-1;
					if(old_xscale!=image_xscale) hsp*=-1;
					if(hsp<1) hsp+=0.1;
				}
				else if(keystate_check(global.right_state)) {
					image_xscale=1;
					if(old_xscale!=image_xscale) hsp*=-1;
					if(hsp<1) hsp+=0.1;
				}
				else if(hsp>0) hsp-=0.1;
				else if(hsp<0) hsp+=0.1;
				
				if(keystate_check_pressed(global.jump_state)) cliff_protect_time=0;
			}
			else{
				image_alpha=1;
				cliff_protect_time=0;
				uninjure=0;
				jump=2;
				scr_sprite_change(SS_fall,0,0.25);
				hsp=walkspd*hspd;
				vsp=0;
			}
		}
		#endregion
		#region 受伤
		if(jump==-1) {
			if(scr_player_Is_fallover(0,0,4,3)) {
				injure_ingrd=true;
				vsp=0;
				scr_player_fallover_adjust();
			} else injure_ingrd=false;
		}
		#endregion
	}
	#endregion
#endregion
#region 坐标精确度
if(!instance_exists(flyobj)
&& !place_meeting(x,y,obj_sink)) {
	if(jump==0 || jump==5) {
		if(image_yscale==1) y=ceil(y);
		if(image_yscale==-1) y=floor(y);
	}
	if(ice==0)
		x=round(2*x)/2;
}
#endregion