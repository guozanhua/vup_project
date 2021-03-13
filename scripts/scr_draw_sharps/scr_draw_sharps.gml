/// @desc 绘制矩形
/// @arg col
/// @arg alpha
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
/// @arg outline
function scr_draw_rectangle(col, alpha, x1, y1, x2, y2, outline) {
	draw_set_color_alpha(col, alpha)
	draw_rectangle(x1,y1,x2,y2,outline)
	draw_set_color_alpha_init()
}
/// @desc 绘制三角形
/// @arg col
/// @arg alpha
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
/// @arg x3
/// @arg y3
function scr_draw_triangle(col,alpha,x1,y1,x2,y2,x3,y3) {
	draw_set_color_alpha(col, alpha)
	draw_triangle(x1,y1,x2,y2,x3,y3,false)
	draw_set_color_alpha_init()
}
/// @desc 绘制镜头矩形
/// @arg col
/// @arg alpha
/// @arg view
function scr_draw_rectangle_view(col, alpha, view) {
	draw_set_color_alpha(col, alpha)
	draw_rectangle(view_xpos(view)+view_wpos(view)*2,
						view_ypos(view)+view_hpos(view)*2,
						view_xpos(view)-view_wpos(view),
						view_ypos(view)-view_hpos(view),
						false)
	draw_set_color_alpha_init()
}
/// @desc 绘制线条
/// @arg col
/// @arg alpha
/// @arg width
/// @arg tophave
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
function scr_draw_line(col,alpha,w,top,x1,y1,x2,y2) {
	var dir;
	dir=degtorad(point_direction(x1,y1,x2,y2))
	draw_set_color_alpha(col, alpha)
	//draw_line_width(x1-w/2,y1-w/2,x2-w/2,y2-w/2,w)
	if top=true
		draw_line_width(x1-(w/2)*cos(dir),y1+(w/2)*sin(dir),x2+(w/2)*cos(dir),y2-(w/2)*sin(dir),w)
	else
		draw_line_width(x1,y1,x2,y2,w)
	draw_set_color_alpha_init()
}
/// @desc 绘制带圆头线条
/// @arg col
/// @arg alpha
/// @arg width
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
function scr_draw_linecircle(col,alpha,w,x1,y1,x2,y2) {
	draw_set_color_alpha(col, alpha)
	draw_line_width(x1,y1,x2,y2,w)
	draw_circle(x1,y1,w/2,false)
	draw_circle(x2,y2,w/2,false)
	draw_set_color_alpha_init()
}
/// @desc 绘制圆形
/// @arg col
/// @arg alpha
/// @arg rad
/// @arg x
/// @arg y
/// @arg outline
function scr_draw_circle(col,alpha,w,xx,yy,outline) {
	draw_set_color_alpha(col, alpha)
	draw_circle(xx,yy,w,outline)
	draw_set_color_alpha_init()
}
/// @desc 绘制扇形/圆环
/// @arg col
/// @arg aph
/// @arg x
/// @arg y
/// @arg rad 圆半径
/// @arg rad2 内环半径
/// @arg rot 扇形角度
/// @arg rot_s 起始角度
/// @arg dir 方向
function scr_draw_circle_part(col, aph, dcx, dcy, rad, rad2, rot ,rot_s, dir) {
	var surf=noone //临时表面
	surf=scr_draw_circle_part_surf(col, aph, dcx, dcy, rad, rad2, rot ,rot_s, dir)
	draw_surface(surf, dcx-rad, dcy-rad)
	surface_free(surf)
}
/// @desc 绘制扇形/圆环的表面步骤
/// @arg col
/// @arg aph
/// @arg x
/// @arg y
/// @arg rad
/// @arg rad2
/// @arg rot
/// @arg rot_s
/// @arg dir
function scr_draw_circle_part_surf(col, aph, dcx, dcy, rad, rad2, rot, rot_s, dir) {
	var rot_n=45, //切分程度，最大45
	    surf=noone //临时表面
	surf=surface_set_target_fix(surf, rad*2, rad*2)
	draw_clear_alpha(c_black, 0)
	//画圆
	scr_draw_circle(col, aph, rad, rad, rad, false)
	//设置gpu
	gpu_set_blendmode(bm_subtract)
	//绘制内环
	if rad2>0 && rad2<rad
		scr_draw_circle(c_black, 1, rad2, rad, rad, false)
	//画扇形三角
	var rot_d = rot div rot_n
	for(var i=0;i<rot_d;i++){
	    scr_draw_triangle(c_black, 1, 
	        rad, rad, 
	        rad+lengthdir_x(rad*sqrt(2), rot_s+dir*i*rot_n), rad+lengthdir_y(rad*sqrt(2), rot_s+dir*i*rot_n),
	        rad+lengthdir_x(rad*sqrt(2), rot_s+dir*(i+1)*rot_n), rad+lengthdir_y(rad*sqrt(2), rot_s+dir*(i+1)*rot_n))
	}
	scr_draw_triangle(c_black, 1, 
	        rad, rad, 
	        rad+lengthdir_x(rad*sqrt(2), rot_s+dir*rot_d*rot_n), rad+lengthdir_y(rad*sqrt(2), rot_s+dir*rot_d*rot_n),
	        rad+lengthdir_x(rad*sqrt(2), rot_s+dir*rot), rad+lengthdir_y(rad*sqrt(2), rot_s+dir*rot))
	//重置gpu
	gpu_set_blendmode(bm_normal)
	surface_reset_target_fix()
	return surf
}
