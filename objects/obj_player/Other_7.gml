#region 常规动作
if sprite_index==SS_walk{
	scr_sprite_change(-2,2,-2);
}
else if sprite_index==SS_dash{
	scr_sprite_change(-2,5,-2);
}
else if sprite_index==SS_dashed{
	scr_sprite_change(SS_idle,0,0.25);
}
else if sprite_index==SS_jump{
	scr_sprite_change(SS_jumping,0,0.25);
}
else if sprite_index==SS_fallover{
	scr_sprite_change(SS_idle,0,0.25);
}
else if sprite_index==SS_jumped{
	scr_sprite_change(SS_fall,0,0.25);
}
else if sprite_index==SS_craw{
	scr_sprite_change(SS_crawing,0,0.25);
}
else if sprite_index==SS_crawjump{
	scr_sprite_change(-2,1,-2);
}
else if sprite_index==SS_talk{
	scr_sprite_change(SS_talking,0,0.25);
}
else if sprite_index==SS_talked{
	scr_sprite_change(SS_idle,0,0.25);
}
//else if sprite_index==SS_squat{
//	scr_sprite_change(SS_squating,0,0.25);
//}
//else if sprite_index==SS_squated{
//	scr_sprite_change(SS_idle,4,0.25);
//	walk=0;
//	jump=0;
//}
else if sprite_index==SS_trip{
	scr_sprite_change(SS_climb,0,0.25);
}
else if sprite_index==SS_climb{
	scr_sprite_change(SS_squated,0,0.25);
}
else if sprite_index==SS_doorup{
	scr_sprite_change(-2,image_number-0.5,0);
}
#endregion
#region 变身
//else if sprite_index==SS_change{
//	if(global.player_change==0) 
//		scr_sprite_change(-2,4,-2);
//	else if(global.player_change==1) 
//		scr_sprite_change(SS_changing,0,0.5);
//}
//else if sprite_index==SS_changing{
//	scr_sprite_change(SS_changing2,0,0.5);
//	global.rockon_flash=1;
//	scr_sound_play(se_player_transon);
//}
//else if sprite_index==SS_changing2{
//	with(global.player_saber) {
//		scr_sprite_change(spr_zsaber_none,0,0);
//		attack=0;
//	}
//	instance_destroy(obj_player_bullet);
//	var po=id;
//	if(global.player_change==0) 
//		global.model=obj_staff.model_select;
//	with(instance_create_depth(po.x,po.y,po.depth,obj_staff.player[global.model][global.character])){
//		image_xscale=po.image_xscale;
//		image_yscale=po.image_yscale;
//		wind_spd=po.wind_spd;
//		water=po.water;
//		waterboost=po.waterboost;
//		underwater=po.underwater;
//		injure_t=po.injure_t;
//		uninjure=po.uninjure;
//		injure_element=po.uninjure;
//		if(variable_instance_exists(id,"airdashed")) 
//			airdashed=1;
//		scr_sprite_change(SS_changed,0,0.5);
//		while(collision_rectangle(bbox_right,bbox_bottom-4,x,bbox_top+1,obj_ground,1,1)) x--;
//		while(collision_rectangle(x,bbox_bottom-4,bbox_left,bbox_top+1,obj_ground,1,1)) x++;
//		while(collision_rectangle(bbox_right-1,y,bbox_left+1,bbox_top,obj_ground,1,1)) y++;
//		while(collision_rectangle(bbox_right-1,bbox_bottom,bbox_left+1,y,obj_ground,1,1)) y--;
//	}
//	instance_destroy(po);
//}
//else if sprite_index==SS_changed{
//	scr_sprite_change(-2,image_number-0.25,0);
//	obj_staff.model_select=-1;
//	global.player_change=0;
//}
//else if sprite_index==SS_change_air{
//	if(global.player_change==0)
//		scr_sprite_change(-2,4,-2);
//	else if(global.player_change==1)
//		scr_sprite_change(SS_changing_air,0,0.5);
//}
//else if sprite_index==SS_changing_air{
//	scr_sprite_change(SS_changing2_air,0,0.5);
//	global.rockon_flash=1;
//	scr_sound_play(se_player_rockon);
//}
//else if sprite_index==SS_changing2_air{
//	with(global.player_saber) {
//		scr_sprite_change(spr_zsaber_none,0,0);
//		attack=0;
//	}
//	instance_destroy(obj_player_bullet);
//	var po=id;
//	if(global.player_change==0) 
//		global.model=obj_staff.model_select;
//	with(instance_create_depth(po.x,po.y,po.depth,obj_staff.player[global.model][global.character])){
//		image_xscale=po.image_xscale;
//		image_yscale=po.image_yscale;
//		wind_spd=po.wind_spd;
//		water=po.water;
//		waterboost=po.waterboost;
//		underwater=po.underwater;
//		injure_t=po.injure_t;
//		uninjure=po.uninjure;
//		injure_element=po.uninjure;
//		jump=2;
//		hsp=walkspd*hspd;
//		airdashed=1;
//		scr_sprite_change(SS_changed_air,0,0.5);
//		while(collision_line(bbox_right,bbox_bottom-4,bbox_right,bbox_top+4,obj_ground,1,1)) x-=1;
//		while(collision_line(bbox_left,bbox_bottom-4,bbox_left,bbox_top+4,obj_ground,1,1)) x-=1;
//		while(collision_line(bbox_right-4,bbox_bottom,bbox_left+4,bbox_bottom,obj_ground,1,1)) y-=1;
//		while(collision_line(bbox_right-4,bbox_top,bbox_left+4,bbox_top,obj_ground,1,1)) y+=1;
//	}
//	instance_destroy(po);
//}
//else if sprite_index==SS_changed_air{
//	scr_sprite_change(-2,image_number-0.25,0);
//	obj_staff.model_select=-1;
//	global.player_change=0;
//}
#endregion
#region 受伤与死亡
else if sprite_index==SS_injure1{
	if(scr_player_Is_fallover(0,0,4,3)) {
		scr_sprite_change(SS_idle,4,0.25);
		walk=0;
		jump=0;
		hsp=0;
		vsp=0;
	}
	else{
		scr_sprite_change(SS_fall,0,0.25);
		walk=0;
		jump=2;
		hsp=walkspd*hspd;
	}
}
else if sprite_index==SS_injure2{
	if(scr_player_Is_fallover(0,0,4,3)) {
		scr_sprite_change(SS_idle,4,0.25);
		walk=0;
		jump=0;
		hsp=0;
		vsp=0;
	}
	else{
		scr_sprite_change(SS_fall,0,0.25);
		walk=0;
		jump=2;
		hsp=walkspd*hspd;
	}
}
else if sprite_index==SS_death{
	scr_sprite_change(spr_player_deathnone,0,1/20);
	//scr_sound_play(se_player_death);
	//for(var i=0;i<8;i+=1){
	//	with(instance_create_depth(x,y,depth-1,obj_fly_outdestroy)) {
	//		scr_sprite_change(spr_player_death_round,0,0.25);
	//		direction=45*i;
	//		speed=2;
	//	}
	//}
}
else if sprite_index==spr_player_deathnone{
	scr_sprite_change(spr_player_none,0,0);
	//for(var i=0;i<8;i+=1){
	//	with(instance_create_depth(x,y,depth-1,obj_fly_outdestroy)) {
	//		scr_sprite_change(spr_player_death_round,0,0.25);
	//		direction=45*i;
	//		speed=2;
	//	}
	//}
}
#endregion