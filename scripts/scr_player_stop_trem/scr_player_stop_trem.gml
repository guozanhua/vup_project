function scr_player_stop_trem() {
	if scr_menu_trem() 
	&& global.operate==1 
	&& global.player_hp>0
		return true
	else
		return false
}
