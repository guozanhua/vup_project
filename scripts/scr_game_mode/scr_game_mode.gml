/// @desc 是否简单模式
function scr_mode_Is_easy() {
	return global.mode==0
}
/// @desc 是否困难模式
function scr_mode_Is_hard() {
	return global.mode==2
}
/// @desc 模式是否为
/// @arg mode
function scr_mode_Is(mode) {
	return global.mode==mode
}