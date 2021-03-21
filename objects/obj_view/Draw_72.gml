/// @desc 重设application尺寸
if view_current==0 {
	surface_resize(application_surface, view.width, view.height)
} else if view_current==1 {
	surface_resize(application_surface, ui.width, ui.height)
}
