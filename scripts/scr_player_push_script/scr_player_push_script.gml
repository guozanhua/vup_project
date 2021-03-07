/// @desc获得被击飞的角度
/// @arg saber_or_bullet
function scr_player_push_script(argument0) {
	var saber_or_bullet=argument0
	//如果是光剑，则计算点在玩家脚下
	if saber_or_bullet.object_index=obj_player_saber
		direction=point_direction(saber_or_bullet.x,saber_or_bullet.y+16*saber_or_bullet.image_yscale,x,y)
	//如果是子弹，则计算点为子弹位置
	else direction=point_direction(saber_or_bullet.x,saber_or_bullet.y,x,y)
	speed=6
	if variable_instance_exists(id,"grav") gravity=grav
	else gravity=G
	scr_sound_play(se_cut_off) //攻击无效声音
}
