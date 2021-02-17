function data_filemap(){
#region 单存档变量
	if variable_global_exists("save_data_map")
		ds_map_destroy(global.save_data_map)
	global.save_data_map=ds_map_create()
	var map = global.save_data_map
	map[? "start_current"]=noone
	map[? "second"]=noone
	map[? "minute"]=noone
	map[? "hour"]=noone

	map[? "game_cleared"]=noone
	map[? "mode"]=noone
	map[? "main_sub_exchange"]=noone

	map[? "player_hp"]=noone
	map[? "player_hp_ex"]=noone
	map[? "player_hp_up"]=noone
	map[? "player_mp"]=noone
	map[? "player_mp_ex"]=noone
	map[? "player_mp_up"]=noone
	map[? "player_life"]=noone
	map[? "player_ec"]=noone
	map[? "hpup_item"]=noone
	map[? "mpup_item"]=noone

	map[? "boss"]=noone
	map[? "sub_bosses"]=noone
	
	map[? "thread"]=noone
#endregion
#region 公用变量
	if variable_global_exists("save_global_map")
		ds_map_destroy(global.save_global_map)
	global.save_global_map=ds_map_create()
	var globalmap = global.save_global_map
	globalmap[? "start_current"]=noone
	globalmap[? "hard_mode"]=noone
	globalmap[? "threaded"]=noone
	globalmap[? "achievement"]=noone
#endregion
}