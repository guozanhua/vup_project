scr_view_inroom()
#region 场景切换过度
if global.operate>0
&& global.operate<1{
	#region 激活实例+设置镜头
	if global.operate<=0.5{
		instance_activate_all()
		scr_view_set_with_inst(obj_player.id)
	}
	#endregion
	if global.operate==0.1
		global.operate=0
	else if global.operate==0.5{//<--
		global.operate=0.6
		if global.room_change_rate[1]>0
			global.room_change_rate[1]=1.04
	}
	else if global.operate==0.6{//<--
		global.operate=0.7
	}
	else if global.operate==0.7{
		if global.room_change_rate[1]==0{
			global.operate=1
			//global.player_operate=1
		}
	}
	//延迟完成oper=1
	else if global.operate==0.8
		global.operate=0.9
	else if global.operate==0.9{
		global.operate=1
		//global.player_operate=1
	}
	#region 换场景判断门
	if global.operate==0.6{
		//with(obj_door_left){
		//	if collision_double_rectangle(bbox_right+32,bbox_bottom,bbox_left-32,bbox_top,
		//								obj_player.bbox_right,obj_player.bbox_bottom,obj_player.bbox_left,obj_player.bbox_top){
		//		closeDoor();
		//	}
		//}
		//with(obj_door_up){
		//	if collision_double_rectangle(bbox_right,bbox_bottom,bbox_left,bbox_top,
		//								obj_player.bbox_right,obj_player.bbox_bottom,obj_player.bbox_left,obj_player.bbox_top){
		//		closeDoor();
		//	}
		//}
	}
	#endregion
}
#endregion