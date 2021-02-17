/// @desc 清空ds
/// @arg id
/// @arg type
function ds_clear(ds, type) {
	switch(type) {
		case ds_type_list:
			ds_list_clear(ds);
			break;
		case ds_type_map:
			ds_map_clear(ds);
			break;
		case ds_type_grid:
			ds_grid_resize(ds,ds_grid_width(ds),ds_grid_height(ds));
			break;
		case ds_type_priority:
			ds_priority_clear(ds);
			break;
		case ds_type_queue:
			ds_queue_clear(ds);
			break;
		case ds_type_stack:
			ds_stack_clear(ds);
			break;
	}
}
/// @desc 合并集合
/// @arg list1
/// @arg list2
/// @arg ...
function ds_list_addall() {
	var list=argument[0];
	for(var i=1;i<argument_count;i++){
		var list2=argument[i],
			size2=ds_list_size(list2);
		for(var j=0;j<size2;j++){
			ds_list_add(list, list2[| j]);
		}
	}
}
/// @desc 查看list中是否有此元素
/// @arg list
/// @arg o
function ds_list_exists(list, o) {
	var pos = ds_list_find_index(list, o);
	if(is_array(pos)) return true;
	else if(pos == -1) return false;
	else return true;
}
/// @function ds_list_remove(list, o)
/// @desc 去除dslist中某一项，请保证此项在list中唯一
/// @arg list 
/// @arg o 要去除的项的值
function ds_list_remove(list, o) {
	var i = ds_list_find_index(list, o);
	ds_list_delete(list, i);
}
/// @desc 读取ds
/// @arg id
/// @arg type
/// @arg str
function ds_read(ds, type, str) {
	switch(type) {
		case ds_type_list:{
			ds_list_read(ds,str);
			break;
		}
		case ds_type_map:{
			ds_map_read(ds,str);
			break;
		}
		case ds_type_grid:{
			ds_grid_read(ds,str);
			break;
		}
		case ds_type_priority:{
			ds_priority_read(ds,str);
			break;
		}
		case ds_type_queue:{
			ds_queue_read(ds,str);
			break;
		}
		case ds_type_stack:{
			ds_stack_read(ds,str);
			break;
		}
	}
}
/// @desc 清空ds
/// @arg id
/// @arg type
function ds_write(ds, type) {
	var str;
	switch(type) {
		case ds_type_list:{
			str=ds_list_write(ds);
			break;
		}
		case ds_type_map:{
			str=ds_map_write(ds);
			break;
		}
		case ds_type_grid:{
			str=ds_grid_write(ds);
			break;
		}
		case ds_type_priority:{
			str=ds_priority_write(ds);
			break;
		}
		case ds_type_queue:{
			str=ds_queue_write(ds);
			break;
		}
		case ds_type_stack:{
			str=ds_stack_write(ds);
			break;
		}
	}
	return str;
}
/// @desc 获取map所有key
/// @arg map
function ds_map_get_keys(map){
	var size = ds_map_size(map),
		key = ds_map_find_first(map),
		keys = [];
	for (var i = 0; i < size; i++;) {
		keys[i]=key;
		key = ds_map_find_next(map, key);
	}
}
/// @desc 获取map所有value
/// @arg map
function ds_map_get_values(map){
	var size = ds_map_size(map),
		key = ds_map_find_first(map),
		keys = [];
	for (var i = 0; i < size; i++;) {
		keys[i]=map[? key];
		key = ds_map_find_next(map, key);
	}
}