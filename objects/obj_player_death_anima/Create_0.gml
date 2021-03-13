action=0
time=0
blackbgs_alpha=0
after_img_alpha=0.5
after_img_dir=0 //1横向，2纵向
after_img_dis=0 //距离
flash=0 //闪白帧
cliff=false //是否悬崖摔死

stage_trans=function() {
	obj_staff.player_death_action=1
	instance_destroy()
}