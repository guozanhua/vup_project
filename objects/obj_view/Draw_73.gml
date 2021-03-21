/// @desc 将镜头0内容保留下来
if view_current!=0 exit
view0_surface_temp=surface_set_target_fix(view0_surface_temp, view.width, view.height)
draw_surface(application_surface, 0, 0)
surface_reset_target()