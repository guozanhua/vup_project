/// @function rgb(red,green,blue)
/// @arg red
/// @arg green
/// @arg blue
function rgb(red, green, blue) {
	return make_color_rgb(red,green,blue)
}
/// @function rgb(hue,saturation,value)
/// @arg hue
/// @arg saturation
/// @arg value
function hsv(hue, saturation, value) {
	return make_color_hsv(hue,saturation,value)
}
/// @arg color
function getRGB(col) {
	return [color_get_red(col), color_get_green(col), color_get_blue(col)]
}
/// @arg color
function getHSV(col) {
	return [color_get_hue(col), color_get_saturation(col), color_get_value(col)]
}