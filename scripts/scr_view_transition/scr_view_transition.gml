/// @arg white-0/black-1
/// @arg in-0/out-1/ing-2
function scr_view_transition(type, inout) {
	//白色
	if type=0{
		if inout=0{
			global.room_change=3
		}
		else if inout=1{
			global.room_change_rate[2]=1.04
			global.room_change=4
		}
		else if inout=2{
			global.room_change_rate[2]=1.04
			global.room_change=3.5
		}
	}
	//黑色
	else if type=1{
		if inout=0{
			global.room_change=1
		}
		else if inout=1{
			global.room_change_rate[1]=1.04
			global.room_change=2
		}
		else if inout=2{
			global.room_change_rate[1]=1.04
			global.room_change=1.5
		}
	}
}
/// @arg white-0/black-1
function scr_view_transition_Isover(type) {
	//白色
	if type=0{
		if global.room_change=4
			return true
		else
			return false
	}
	//黑色
	else if type=1{
		if global.room_change=2
			return true
		else
			return false
	}
}
/// @desc 是否还有屏幕过度
function scr_view_transition_IsRealover() {
	return global.room_change=0
}
