/// @desc 按键是否按下
/// @arg state
function keystate_check(state) {
	return state>0
}
/// @desc 按键是否按住中
/// @arg state
function keystate_check_direct(state) {
	return state>1
}
/// @desc 按键是否没有状态
/// @arg state
function keystate_check_none(state) {
	return state==0
}
/// @desc 按键是否刚按下
/// @arg state
function keystate_check_pressed(state) {
	return state==1
}
/// @desc 按键是否刚松开
/// @arg state
function keystate_check_released(state) {
	return state==-1
}
