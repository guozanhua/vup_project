/// @desc 将镜头0内容保留下来
if view_current!=0 exit
surface_resize(application_surface, view.width, view.height)
if !surface_exists(view0_surface_temp)
	view0_surface_temp=surface_create(view.width, view.height)
surface_set_target(view0_surface_temp)
draw_surface(application_surface, 0, 0)
surface_reset_target()