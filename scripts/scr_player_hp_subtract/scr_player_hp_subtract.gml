/// @desc 玩家血量减少
/// @arg sub_hp 减血量
function scr_player_hp_subtract(sub_hp) {
	global.player_hp-=sub_hp
	//不满血且有扩展
	while global.player_hp_ex>0
	&& global.player_hp<global.player_hp_up{
		global.player_hp_ex--
		global.player_hp++
	}
}
