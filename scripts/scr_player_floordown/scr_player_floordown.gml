/// @desc 检测此半透板是否在记录中
/// @arg id
function scr_player_floordown_exists(flordown) {
	return ds_list_exists(global.floor_down_list, flordown)
}
/// @desc 将脚下半透板及其所有接触对象全部列入list
/// @arg id
function scr_player_floordown_set(flordown) {
	//将脚下的板子列入list
	var list = global.floor_down_list,
		listtmp = ds_list_create(),
		listcount = 1, 
		precount = 0
	ds_list_add(list, flordown)
	//当list大笑还能扩大（还有能加入的对象时）
	while listcount!=precount {
		//遍历list里所有元素，找其周围元素
		for(var i=0;i<listcount;i++) {
			ds_list_clear(listtmp)
			with list[| i] {
				var listtmpcnt = collision_rectangle_list(bbox_right+1, bbox_bottom+1, bbox_left-1, bbox_top-1, obj_floor, true, true, listtmp, false)
				for(var j=0;j<listtmpcnt;j++) {
					if instance_exists(listtmp[| j]) && !ds_list_exists(list, listtmp[| j])
						ds_list_add(list, listtmp[| j])
				}
			}
		}
		precount = listcount
		listcount = ds_list_size(list)
	}
	ds_list_destroy(listtmp)
}
function scr_player_floordown_clear() {
	ds_list_clear(global.floor_down_list)
}