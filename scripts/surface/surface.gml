/// @desc 绘制surface并将老目标保存起来
/// @arg id
/// @arg w
/// @arg h
function surface_set_target_fix(target, width, height) {
	//判断表面是否存在
	if !surface_exists(target)
		target=surface_create(width,height)
	surface_set_target(target)
	return target
}
/// @desc 完成关闭或变回原来的surface
function surface_reset_target_fix() {
	surface_reset_target()
}
