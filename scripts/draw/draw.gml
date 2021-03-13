/// @desc 一次设置颜色透明度
/// @arg col
/// @arg aph
function draw_set_color_alpha(col, aph) {
	draw_set_color(col)
	draw_set_alpha(aph)
}
/// @desc 初始化颜色透明度，默认白色不透明
function draw_set_color_alpha_init() {
	draw_set_color_alpha(c_white, 1)
}