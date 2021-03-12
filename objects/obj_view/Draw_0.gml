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
	draw_clear_alpha(c_white, 1)
	draw_surface_ext(view0_surface_temp, 0, 0, xsc, ysc, 0, c_white, 1)
	surface_reset_target()
	//滤镜划线
	var pixFilter = global.pix_filter,
		pixAlpha = 0.2
	//pixFilter=true
	if pixFilter{
		draw_set_color(c_black)
		draw_set_alpha(pixAlpha)
		for(var i=0;i<apsw;i+=xsc) {
			draw_line(i, 0, i, apsh)
			//scr_draw_line(c_black, pixAlpha, 1, false, i, 0, i, apsh)
		}
		for(var i=0;i<apsh;i+=ysc) {
			//scr_draw_line(c_black, pixAlpha, 1, false, 0, i, apsw, i)
			draw_line(0, i, apsw, i)
		}
		draw_set_alpha(1)
		draw_set_color(c_white)
	}
}
#endregion
#region 界面内容
var ifx=16, ify=16;
draw_sprite(spr_ui_grd_support_iframe, 0, ifx, ify)
//hp 对应血条64=3倍长度
{
	//血条框架
	var hpx=ifx+32, hpy=ify+13,
		hpifw=sprite_get_width(spr_ui_grd_hp_iframe),
		hpifh=sprite_get_height(spr_ui_grd_hp_iframe),
		hpiflen=(global.player_hp_up/64)*3*hpifw;
	draw_sprite(spr_ui_grd_hp_iframe, 0, hpx, hpy)
	draw_sprite_ext(spr_ui_grd_hp_iframe, 1, hpx+hpifw, hpy, (hpiflen-hpifw-32)/hpifw, 1, 0, c_white, 1)
	draw_sprite_ext(spr_ui_grd_hp_iframe, 2, hpx+hpiflen, hpy, -1, 1, 0, c_white, 1)
	var hpsurf = draw_hp(global.player_hp, hpiflen-1),
		hpaftsurf = draw_hp(global.player_hp_aft, hpiflen-1)
	draw_surface_ext(hpaftsurf, hpx+2, hpy+2, 1, 1, 0, $130ecc, 1)
	surface_free(hpaftsurf)
	draw_surface_ext(hpsurf, hpx+2, hpy+2, 1, 1, 0, c_white, 1)
	surface_free(hpsurf)
}
//mp
{
	//能量条框架
	var mpx=ifx+36, mpy=ify+39,
		mpifw=sprite_get_width(spr_ui_grd_mp_iframe),
		mpifh=sprite_get_height(spr_ui_grd_mp_iframe),
		mpiflen=(global.player_mp_up/64)*3*mpifw;
	draw_sprite(spr_ui_grd_mp_iframe, 0, mpx, mpy)
	draw_sprite_ext(spr_ui_grd_mp_iframe, 1, mpx+mpifw, mpy, (mpiflen-mpifw-16)/mpifw, 1, 0, c_white, 1)
	draw_sprite_ext(spr_ui_grd_mp_iframe, 2, mpx+mpiflen, mpy, -1, 1, 0, c_white, 1)
	//能量条
	var mpsurf = draw_mp(global.player_mp, mpiflen-4)
	draw_surface_ext(mpsurf, mpx+2, mpy+2, 1, 1, 0, $f0ce00, 1)
	surface_free(mpsurf)
}


//var supportw = sprite_get_width(spr_ui_grd_support),
//	supporth = sprite_get_height(spr_ui_grd_support),
//	parth = floor(supporth*(1-global.player_support/100))
//draw_sprite_part(spr_ui_grd_support, 0, 0, parth, supportw, supporth-parth, 39, 102+parth)
////scr_draw_text(c_white, 1, 0, font_butter_support, 0.5, 0.5, "50", 60, 82, 1, 1, -1, -1, -1)
//draw_set_font(font_butter_support)
//draw_set_halign(fa_center)
//draw_set_valign(fa_middle)
//draw_set_alpha(1)
//draw_set_color($5300f1)
//draw_text_ext_transformed(59, 81, global.player_support, -1, -1, 1, 1, 0)
//draw_set_color(c_white)
//draw_set_alpha(1)
////血条
//draw_sprite(spr_ui_grd_hp_iframe, 0, 81, 76)
//draw_sprite_ext(spr_ui_grd_hp, 0, 83, 76, global.player_hp/global.player_hp_up, 1, 0, c_white, 1)
////能量条
//draw_sprite(spr_ui_grd_mp_iframe, 0, 89, 120)
//draw_sprite_ext(spr_ui_grd_mp, 0, 92, 120, global.player_mp/global.player_mp_up, 1, 0, c_white, 1)
//腰带
draw_sprite(spr_ui_grd_belt, 0, 128, 480)
#endregion