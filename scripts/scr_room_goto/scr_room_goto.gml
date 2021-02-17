/// @arg room
function scr_room_goto(rm) {
	instance_activate_all()//切换房间时唤醒所有对象，防止有对象的切换事件无法执行
	room_goto(rm)
	//scr_view_set_with_player_center()
}
