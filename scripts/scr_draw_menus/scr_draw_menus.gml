/// @desc 绘制头部页签
/// @arg x
/// @arg y
function scr_draw_menu_tab(dx, dy, index){
	var cenx = dx+VIEW_W_UI/2;
	var preinx = index-1,
		nextinx = index+1;
	if preinx<0 preinx=menu_page_count-1
	if nextinx>=menu_page_count nextinx=0
	draw_sprite(spr_menu_tab, 0, dx, dy)
	scr_draw_text(c_white, 1, 0, font_puhui, 0.5, 0.5, global.txt_menu_tabs[preinx], 
				dx+432, dy+64, 1, 1, -1, -1, -1, 0)
	scr_draw_text(c_white, 1, 0, font_puhui, 0.5, 0.5, global.txt_menu_tabs[nextinx], 
				dx+VIEW_W_UI-432, dy+64, 1, 1, -1, -1, -1, 0)
	//L
	draw_sprite_ext(spr_menu_tab_lr, 0, dx, dy, 1, 1, 0, c_white, 1)
	scr_draw_text(c_white, 1, 0, font_puhui, 0.5, 0.5, "L", 
				dx+112, dy+64, 1, 1, -1, -1, -1, 0)
	//R
	draw_sprite_ext(spr_menu_tab_lr, 0, dx+VIEW_W_UI, dy, -1, 1, 0, c_white, 1)
	scr_draw_text(c_white, 1, 0, font_puhui, 0.5, 0.5, "R", 
				dx+VIEW_W_UI-112, dy+64, 1, 1, -1, -1, -1, 0)
	//name
	draw_sprite(spr_menu_tab_name, 0, cenx, dy)
	scr_draw_text(c_white, 1, 0, font_puhui, 0.5, 0.5, global.txt_menu_tabs[index], 
				cenx, dy+64, 1, 1, -1, -1, -1, 0)
	//箭头
	var af = sin(global.fps_curr*pi/30);
	draw_sprite_ext(spr_menu_arrow, 0, cenx-352-16*af, dy+64, -1, 1, 0, c_white, 1)
	draw_sprite_ext(spr_menu_arrow, 0, cenx+352+16*af, dy+64, 1, 1, 0, c_white, 1)
}
/// @desc 绘制状态页
/// @arg x
/// @arg y
function scr_draw_menu_status(dx, dy){
	scr_draw_menu_tab(dx, dy, 0)
	
}
/// @desc 绘制道具页
/// @arg x
/// @arg y
function scr_draw_menu_item(dx, dy){
	scr_draw_menu_tab(dx, dy, 1)
	
}
/// @desc 绘制设置页
/// @arg x
/// @arg y
function scr_draw_menu_option(dx, dy){
	scr_draw_menu_tab(dx, dy, 2)
	
}
/// @desc 绘制任务页
/// @arg x
/// @arg y
function scr_draw_menu_mission(dx, dy){
	scr_draw_menu_tab(dx, dy, 3)
	
}
/// @desc 绘制技能页
/// @arg x
/// @arg y
function scr_draw_menu_skill(dx, dy){
	scr_draw_menu_tab(dx, dy, 4)
	
}