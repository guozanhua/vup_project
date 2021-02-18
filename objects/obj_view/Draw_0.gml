if view_current!=1 exit
#region 使用镜头0内容覆盖app
surface_resize(application_surface, ui.width, ui.height)
if surface_exists(view0_surface_temp) {
	var apsw = surface_get_width(application_surface), 
		apsh = surface_get_height(application_surface), 
		v0sw = surface_get_width(view0_surface_temp), 
		v0sh = surface_get_height(view0_surface_temp),
		xsc = apsw/v0sw,
		ysc = apsh/v0sh;
	surface_set_target(application_surface)
	draw_surface_ext(view0_surface_temp, 0, 0, xsc, ysc, 0, c_white, 1)
	surface_reset_target()
	//滤镜划线
	var pixFilter = global.pix_filter
	pixFilter=true
	if pixFilter{
		draw_set_color(c_black)
		draw_set_alpha(0.5)
		for(var i=0;i<apsw;i+=xsc) {
			draw_line(i, 0, i, apsh)
		}
		for(var i=0;i<apsh;i+=ysc) {
			draw_line(0, i, apsw, i)
		}
		draw_set_color(c_white)
		draw_set_alpha(1)
	}
}
#endregion
#region 界面内容
//血条
var hpif={
	x : 24,
	y : 48,
	hpx : x+6,
	hpy : y+54
}, hpifspx=hpif.x
//左侧
draw_sprite(spr_ui_grd_hp_iframe_left, 1, hpifspx, hpif.y)
draw_sprite(spr_ui_grd_hp_iframe_left, 0, hpifspx, hpif.y)
//中央
hpifspx+=214
var hpxsc = (global.player_hp_up-32)/32*32
draw_sprite_ext(spr_ui_grd_hp_iframe_center, 1, hpifspx, hpif.y, hpxsc, 1, 0, c_white, 1)
draw_sprite_ext(spr_ui_grd_hp_iframe_center, 0, hpifspx, hpif.y, hpxsc, 1, 0, c_white, 1)
//右侧
hpifspx+=hpxsc*16
draw_sprite(spr_ui_grd_hp_iframe_right, 1, hpifspx, hpif.y)
draw_sprite(spr_ui_grd_hp_iframe_right, 0, hpifspx, hpif.y)

#endregion