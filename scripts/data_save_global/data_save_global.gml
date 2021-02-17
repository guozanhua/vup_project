/// @desc 保存全局记录
/// @arg maps[] 单独保存为noone
/// @arg keys[] 单独保存为noone
function scr_data_save_global(maps, keys) {
	var map=ds_map_create(),
		key="global"
	//保存进入map
	//根据配置保存
	var filemap = global.save_global_map
	var filemapsize = ds_map_size(filemap)
	var filemapkey = ds_map_find_first(filemap)
	repeat(filemapsize){
		var filemaptype = filemap[? filemapkey]
		if !is_undefined(filemaptype){
			if filemaptype = noone
				scr_map_auto_write_var(map, filemapkey)
			else
				scr_map_auto_write_ds(map, filemapkey, filemaptype)
		}
		filemapkey = ds_map_find_next(filemap, filemapkey)
	}
	//如果是单独保存
	if maps=noone{
		maps=[map]
		keys=[key]
		scr_datafile_save(maps,keys)
		//刷新存档信息
		scr_data_set_note()
	}
	else{
		//将此部分列入到maps和keys的最后部分
		var i=array_length(maps)
		maps[@ i]=map
		keys[@ i]=key
		//由于会一并保存，保存后会刷新存档信息，故此处不再设置
	}


}
