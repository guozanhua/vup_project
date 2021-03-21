#region 数据设定
if(scr_menu_trem()) {
	#region 精灵播放帧速修改区
	scr_sprite_imspd(SS_idle,1/120,0,1);
	scr_sprite_imspd(SS_idle,0.1,1,2);
	scr_sprite_imspd(SS_idle,0.025,2,3);
	scr_sprite_imspd(SS_idle,0.1,3,6);
	//////////////////////////////////////
	//scr_sprite_imspd(SS_idle2,1/60,0,1);
	scr_sprite_imspd(SS_idle2,0.1,0,1);
	scr_sprite_imspd(SS_idle2,0.1,1,7);
	//////////////////////////////////////
	scr_sprite_imspd(SS_injure_fall,0,0.2);
	//////////////////////////////////////
	scr_sprite_imspd(SS_injure1,0.25,0,1);
	scr_sprite_imspd(SS_injure1,0.05,1,2);
	//////////////////////////////////////
	scr_sprite_imspd(SS_injure2,0.25,0,1);
	scr_sprite_imspd(SS_injure2,0.05,1,2);
	//////////////////////////////////////
	if(variable_instance_exists(id,"SS_injure3")) {
		scr_sprite_imspd(SS_injure3,0.5,0,1);
		scr_sprite_imspd(SS_injure3,0.05,1,2);
	}
	#endregion
	#region 声控区
	if(sprite_index==SS_idle2) {
		//image_index=accurate_to(image_index, 0.1)
		if between(image_index, 3, true, 3.1, false)
			scr_sound_play(se_player_dying)
	} else {
		scr_sound_stop(se_player_dying)
	}
	if(jump==3) {
		if((global.fps_10==0 && vsp==1.5)
		||(global.fps_6==0 && vsp==1)
		||(global.fps_3==0 && vsp==0.5)) {
			scr_sound_play(se_player_crawing);
			if(!place_meeting(x,y,obj_water)) {
				with(instance_create_depth(x-8*image_xscale,y+20*image_yscale,depth-1,obj_animation_once)){
					scr_sprite_change(spr_smoke,0,0.25);
					image_xscale=other.image_xscale;
					image_yscale=other.image_yscale;
				}
			}
		}
	}
	if(walk==1) {
		if(image_index mod 5==3) 
			scr_player_se_step();
	}
	if(sprite_index==SS_lwalk) {
		if(image_index mod 3==0)
			scr_player_se_step();
	}
	if((charge[1]>=30 || charge[2]>=30)
	&& global.fps_3==0
	&& global.player_operate==1
	&& global.operate==1)
		scr_sound_play(se_player_charge);
	#endregion
	#region 飞行物
	if(global.player_hp>0) 
		scr_player_flyobj_move();
	#endregion
	#region 死亡
	if global.player_hp<=0
	&& global.operate==1{
		scr_sprite_change(spr_none,0,0);
		global.operate=0;
		walk=0;
		jump=0;
		dash=0;
		hsp=0;
		vsp=0;
		water=0;
		injure_element=ELEMENTS.none;
		injure_t=0;
		//清空各类记录
		scr_player_charge_clear()
		scr_player_floordown_clear(); 
		//声音停止
		audio_bgm_stop()
		scr_sound_stopall_dpl()
		audio_stop_all()
		//创建玩家死亡动画
		with instance_create_depth(x, y, 100, obj_player_death_anima) {
			scr_sprite_change(other.SS_death, 0, 0)
			image_xscale=other.image_xscale
			cliff=other.death_cliff
			if cliff image_angle=0
		}
	}
	#endregion
	#region 检测model是否符合当前卡片
	var newplayer = noone;
	if model==0 && global.model!=0 {
		newplayer=obj_player_armor
	} else if model!=0 && global.model==0 {
		newplayer=obj_player_hu
	}
	if(newplayer!=noone) {
		with instance_create_depth(x, y, depth, newplayer) {
			scr_sprite_change(SS_idle, 0, 0.25)
			image_xscale=other.image_xscale
			image_yscale=other.image_yscale
		}
		instance_destroy()
	}
	#endregion
}
#endregion
#region 进剧情时清空无敌状态
if(!scr_player_stop_trem()) {
	if(global.operate==0) {
		injure_t=0;
		uninjure=0;
		injure_level=0;
	}
	exit;
}
#endregion
#region 爬墙震倒计时
if(craw_trip_time>0) {
	craw_trip_time--;
	if(jump==3) {
		scr_sprite_change(SS_injure_fall,0,1);
		//scr_player_EB_close();
		vsp=0;
		hsp=0;
		dash=0;
		jump=19;
		walk=0;
		clearBullets();
	}
}
#endregion
#region 伤害计算
//接触尖刺取消
//if(jump==0) meet_prick=noone;
global.player_def=1;
#region 防御力设定
//简单模式
//if(scr_mode_Is_easy()) {
//	global.player_def*=0.5;
//}
////普通模式
//else if(scr_mode_Is_normal()) {
//	global.player_def*=1;
//}
////困难模式
//else if(scr_mode_Is_hard()) {
//	global.player_def*=1.5;
//}
#endregion
#region 受伤
{
	var place=false, 
		operator = (global.player_operate==1 && global.operate==1);
	#region 伤害数值和属性修改
	ds_list_clear(enemylist);
	ds_list_clear(bulletlist);
	ds_list_clear(bosslist);
	var //enemylist=ds_list_create(),
		enemylistcnt=0,
		//bulletlist=ds_list_create(),
		bulletlistcnt=0,
		//bosslist=ds_list_create(),
		bosslistcnt=0,
		oldhp=global.player_hp,
		konjo=false,
		overload=scr_itemb_overload(),
		enemylistcnt=collision_rectangle_list(bbox_right,bbox_bottom,bbox_left,bbox_top,obj_enemy,1,1,enemylist,0)
		bulletlistcnt=collision_rectangle_list(bbox_right,bbox_bottom,bbox_left,bbox_top,obj_bullet,1,1,bulletlist,0)
		bosslistcnt=collision_rectangle_list(bbox_right,bbox_bottom,bbox_left,bbox_top,obj_boss,1,1,bosslist,0);
	#region 杂兵撞击受伤
	if(enemylistcnt>0
	&& operator) {//omega剑强行取消无敌写在剑的事件中
		for(var i=0;i<enemylistcnt;i++){
			var enemy=enemylist[| i];
			if(enemy.hp>0 && enemy.attack!=0
			&& enemy.have_dmg
			&& enemy.injure_type!=2
			&& (uninjure==0 || injure_level<enemy.damage_level)) {
				place=true;
				konjo=true;
				scr_player_damage_cal(enemy);
			}
		}
		//ds_list_destroy(enemylist);
		ds_list_clear(enemylist);
	}
	#endregion
	#region 子弹撞击受伤
	if(bulletlistcnt>0
	&& operator) {
		for(var i=0;i<bulletlistcnt;i++){
			var bullet=bulletlist[| i];
			if(bullet.attack!=0) {
				if(uninjure==0 || injure_level<bullet.damage_level) {
					place=true;
					konjo=true;
					scr_player_damage_cal(bullet);
				}
				else{
					bullet.hit=1;
				}
			}
		}
		//ds_list_destroy(bulletlist);
		ds_list_clear(bulletlist);
	}
	#endregion
	#region BOSS撞击受伤
	if(bosslistcnt>0
	&& operator) {
		for(var i=0;i<bosslistcnt;i++){
			var boss=bosslist[| i];
			if(global.boss_hp>0 && boss.attack!=0 && boss.have_dmg=true
			&& !in(boss.injure_element, [ELEMENTS.ice, ELEMENTS.elec])
			&& (uninjure==0 || injure_level<boss.damage_level)) {
				place=true;
				konjo=true;
				scr_player_damage_cal(boss);
			}
		}
		//ds_list_destroy(bosslist);
		ds_list_clear(bosslist);
	}
	#endregion
	#region 尖刺撞击
	if(collision_rectangle(bbox_right+1,bbox_bottom+1,bbox_left-1,bbox_top-1,obj_prick,1,1)
	|| collision_rectangle(bbox_right+1,bbox_bottom+1,bbox_left-1,bbox_top-1,obj_flyground_prick,1,1)) {
		var matrix_pos = [
			[1, 0, 0, 0],
			[0, 1, 0, 0],
			[0, 0, 1, 0],
			[0, 0, 0, 1]],
			prick_meeting_all = false;
		for(var i=0;i<array_length(matrix_pos);i++){
			var pos = matrix_pos[i],
				//pricklist = ds_list_create(),
				prick_list_cnt = collision_rectangle_list(bbox_right+pos[0], bbox_bottom+pos[1], bbox_left-pos[2], bbox_top-pos[3], obj_ground, 1, 1, pricklist, false),
				prick_meeting = false;
			prick_meeting = (prick_list_cnt>0) || prick_meeting
			for(var j=0;j<prick_list_cnt;j++){
				var prick=pricklist[| j];
				//冷却岩浆
				if(instance_is_object(prick, obj_flyground_prick)) {
					if(!prick.damage) {
						prick_meeting=false;
						break;
					}
				} 
				//普通墙壁
				else if(!instance_is_object(prick, obj_prick)) {
					prick_meeting=false;
					break;
				} 
			}
			//ds_list_destroy(pricklist);
			ds_list_clear(pricklist);
			prick_meeting_all = prick_meeting || prick_meeting_all;
		}
		if((prick_meeting_all)
		//&& !place
		&& ((uninjure==0 && global.player_operate==1) || (global.player_operate!=1))) {
			if(global.prick_attack!=0) {
				place=true;
				var damage,attack=global.prick_attack;
				damage=ceil(attack*global.player_def);
				//可操作时简单模式或者尖刺防护
				//if(global.player_operate==1
				//&& (scr_mode_Is_easy()
				//	|| scr_itemb_isrun(ITEMB.spike_protect))) {
				//	//伤害吸收
				//	if(scr_player_mp_ebing()) {
				//		damage=scr_player_damage_offset(damage);
				//	}
				//	//普通伤害(不用else是为了部分抵消)
				//	if(!scr_player_mp_ebing()) {
				//		uninjure=1;
				//		scr_player_hp_subtract(damage+overload);
				//		konjo=true;
				//	}
				//}
				//else 
					global.player_hp=0;
			}
		}
	}
	#endregion
	#endregion
	#region 进入受伤状态，进行方向和类型设定
	if(place) injure_t=0;
	if((uninjure==1 || uninjure==-1)
	&& place) {
		var ww=walk;
		dash=0;
		//击飞
		if(injure_element==ELEMENTS.push
		&& !scr_itemb_isrun(ITEMB.shock_absorber)) {
			if(uninjure==1) scr_sprite_change(SS_injure1,1,0);
			else if(uninjure==-1) scr_sprite_change(SS_injure2,1,0);
			if(jump==9) scr_player_outground();
			hsp=4*hspd*(-uninjure);
			vsp=-(5/6)*vspd;
			//提前位移，否则会被直接判定为落在地上
			if(!place_meeting(x,y-4*image_yscale,obj_ground))
				y-=4*image_yscale;
		}
		//上击飞
		else if(injure_element==ELEMENTS.pushup) {
			if(uninjure==1) scr_sprite_change(SS_injure1,1,0);
			else if(uninjure==-1) scr_sprite_change(SS_injure2,1,0);
			if(jump==9) scr_player_outground();
			hsp=0*hspd*(-uninjure);
			vsp=-2.5*vspd;
			dash=1;
			//提前位移，否则会被直接判定为落在地上
			if(!place_meeting(x,y-4*image_yscale,obj_ground))
				y-=4*image_yscale;
		}
		//下击飞
		else if(injure_element==ELEMENTS.pushdown) {
			if(uninjure==1) scr_sprite_change(SS_injure1,1,0);
			else if(uninjure==-1) scr_sprite_change(SS_injure2,1,0);
			if(jump==9) scr_player_outground();
			hsp=0*hspd*(-uninjure);
			vsp=2*vspd;
			dash=1;
			//提前位移，否则会被直接判定为落在地上
			if(!place_meeting(x,y-4*image_yscale,obj_ground))
				y-=4*image_yscale;
		}
		//冰冻
		else if(injure_element==ELEMENTS.ice) {
			if(uninjure==1) scr_sprite_change(SS_injure1,1,0);
			else if(uninjure==-1) scr_sprite_change(SS_injure2,1,0);
			if(jump==9) scr_player_outground();
			hsp=0;
			vsp=0;
			ice_time=0;
			scr_sound_play(se_ice);
		}
		//普通受伤
		else{
			if(uninjure==1) {
				scr_sprite_change(SS_injure1,0,0.25);
				scr_sound_play(SE_injure1);
			}
			else if(uninjure==-1) {
				scr_sprite_change(SS_injure2,0,0.25);
				scr_sound_play(SE_injure2);
			}
			if(jump==9) scr_player_outground();
			if(injure_element!=ELEMENTS.absorb) {//吸附
				hsp=2*hspd*(-uninjure);
				vsp=-(1/3)*vspd;
			}
			else{
				hsp=0;
				vsp=0;
			}
			injure_element=ELEMENTS.none;
		}
		//if(scr_itemb_isrun(ITEMB.shock_absorber)) {
		//	hsp=0;
		//	vsp=0;
		//}
		walk=-1;
		jump=-1;
		uninjure=1;
		injure_ingrd=false;
		//if(injure_element==ELEMENTS.fire
		//|| injure_element==ELEMENTS.elec)
		//	injure_element=ELEMENTS.none;
		//夹缝中
		if(ww==8 
		&& global.model==PLAYER_MODEL.HU
		&& scr_player_collcreep()) {
			scr_sprite_change(SS_injure3,0,0.25);
			hsp=0;
			vsp=0;
			injure_element=ELEMENTS.none;
		}
	}
	#endregion
	#region 设定受伤时间
	if(uninjure==1//受伤
	|| uninjure==0.5) {//抵消
		if(uninjure==0.5) uninjure=1;
		//if((injure_t<90 && !scr_itemb_isrun(ITEMB.inv_ext))
		//||(injure_t<150 && scr_itemb_isrun(ITEMB.inv_ext)))
		if(injure_t<90)
			injure_t+=1;
		else{
			injure_t=0;
			uninjure=0;
			injure_level=0;
		}
		//击中子弹销毁
		var bullet=collision_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_top,obj_bullet,1,1);
		if(bullet) bullet.hit=1;
	}
	#endregion
}
#endregion
#region 轰飞
if(injure_element==ELEMENTS.push) {
	injure_t=1;//无敌一直在
	#region 落地
	if(scr_player_Is_fallover(0,0,2,2)) {
		scr_sprite_change(SS_trip,0,1/30);
		dash=0;
		hsp=0;
		vsp=0;
		jump=0;
		injure_element=ELEMENTS.none;
		scr_player_se_step();
		scr_player_fallover_adjust();
	}
	#endregion
	#region 撞墙
	else if(place_meeting(x+2*sign(hsp),y,obj_ground)) {
		scr_sprite_change(SS_fall,0,0.25);
		hsp=walkspd*hspd;
		vsp=0;
		dash=0;
		jump=2;
		walk=0;
		injure_element=ELEMENTS.none;
	}
	#endregion
}
#endregion
#region 上轰飞
else if(injure_element==ELEMENTS.pushup) {
	injure_t=1;//无敌一直在
	#region 落地
	if(scr_player_Is_fallover(0,0,2,2)) {
		scr_sprite_change(SS_trip,0,1/60);
		dash=0;
		hsp=0;
		vsp=0;
		jump=0;
		injure_element=ELEMENTS.none;
		global.player_hp-=1;
		scr_player_se_step();
		scr_player_fallover_adjust();
	}
	#endregion
	#region 撞顶
	else if place_meeting(x, y-1, obj_ground) {
		scr_sprite_change(SS_fall,0,0.25);
		hsp=walkspd*hspd;
		vsp=0;
		dash=0;
		jump=2;
		walk=0;
		injure_element=ELEMENTS.none;
		global.player_hp-=1;
	}
	#endregion
}
#endregion
#region 下轰飞
else if(injure_element==ELEMENTS.pushdown) {
	injure_t=1;//无敌一直在
	#region 落地
	if(scr_player_Is_fallover(0,0,2,2)) {
		scr_sprite_change(SS_trip,0,1/60);
		dash=0;
		hsp=0;
		vsp=0;
		jump=0;
		injure_element=ELEMENTS.none;
		global.player_hp-=1;
		scr_player_se_step();
		scr_player_fallover_adjust();
	}
	#endregion
}
#endregion
#region 冰冻
else if(injure_element==ELEMENTS.ice) {
	injure_t=1;//无敌一直在
	#region 挣扎
	if((keystate_check(global.left_state)
	|| keystate_check(global.right_state))
	&& keystate_check_pressed(global.jump_state)) {
		ice_time+=20;
		global.debuff_time-=20;
	}
	ice_time+=1;
	if(ice_time>=ice_time_up) {
		injure_element=ELEMENTS.none;
		scr_sprite_change(SS_idle,0,0.25);
		walk=0;
		jump=0;
		dash=0;
		hsp=0;
		vsp=0;
		ice_time=0;
		//scr_ice_over(spr_lbullet_dragonover,6);
	}
	#endregion
	#region 落地
	if(scr_player_Is_fallover(0,0,4,3)) {
		dash=0;
		hsp=0;
		vsp=0;
		scr_player_fallover_adjust();
	}
	#endregion
}
#endregion
#region 摔倒在地时落空
if(sprite_index==SS_trip) {
	if(walk==-1) injure_t=1;//跌倒时无敌一直在
	#region 落空
	if(!place_meeting(x,y+2*image_yscale,obj_ground)
	&&!(image_yscale==1
	&& collision_rectangle(bbox_right,bbox_bottom+2,bbox_left,bbox_bottom,obj_floor,1,1)
	&&!collision_rectangle(bbox_right,bbox_bottom-1,bbox_left,bbox_bottom-2,obj_floor,1,1))
	&&!(image_yscale==-1
	&& collision_rectangle(bbox_right,bbox_top,bbox_left,bbox_top-2,obj_floor,1,1)
	&&!collision_rectangle(bbox_right,bbox_top+2,bbox_left,bbox_top+1,obj_floor,1,1))
	&&!place_meeting(x,y,obj_sink)) {
		scr_sprite_change(SS_jumped,0,0.25);
		jump=2;
		walk=0;
		hsp=walkspd*hspd;
	}
	#endregion
}
#endregion
#endregion
#region 挤压墙壁致死
/*if((collision_rectangle(bbox_right-1,bbox_bottom-1,bbox_left+1,bbox_top+1,obj_ground,1,1)
&&(walk!=2 && walk!=5 && jump!=9))
||(collision_rectangle(bbox_right-1,bbox_bottom-1,bbox_left+1,bbox_top,obj_ground,1,1)
&&(walk==2 || walk==5 || jump==9))) */
if(collision_rectangle(bbox_right-1,bbox_bottom-2,bbox_left+1,bbox_top+2,obj_ground,1,1)) 
	global.player_hp=0;
#endregion
#region 左右出镜头
if(x<global.room_xl) x=global.room_xl;
if(x>global.room_xr) x=global.room_xr;
#endregion
#region 坐标偏移计算
	dis_x=x-x_last;
	x_last=x;
	dis_y=y-y_last;
	y_last=y;
	imx_last=image_xscale;
	imy_last=image_yscale;
#endregion