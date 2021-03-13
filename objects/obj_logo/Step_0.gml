scr_time_alarm()
if action==0 {
	if keyboard_check_pressed(vk_enter) {
		scr_view_transition(1, 0)
		action=1
	}
} else if action==1 {
	if scr_view_transition_Isover(1) {
		//scr_view_transition(1, 1)
		room_goto(room_test)
	}
}