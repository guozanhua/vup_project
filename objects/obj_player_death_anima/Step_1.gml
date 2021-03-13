scr_time_alarm()
if(!cliff) {
	if action==0 {
		global.stop=0.5;
		action=1;
		time=1;
	} 
	//进入黑屏
	else if action==1 && time==0 {
		scr_sprite_change(-2, 1, 0)
		action=2
		time=10
	}
	else if action==2 {
		if flash==0 flash=1
		blackbgs_alpha=1-time/10
		if time==0 {
			action=3
		}
	}
	//移动到屏幕中间
	else if action==3 {
		var dis=point_distance(x, y, view_xcenpos(0), view_ycenpos(0))
		direction=point_direction(x, y, view_xcenpos(0), view_ycenpos(0))
		speed=ceil(dis/16)
		if dis<=1 {
			x=view_xcenpos(0)
			y=view_ycenpos(0)
			speed=0
			action=4
			time=30
		}
	}
	//心跳
	else if action==4 && time==0 {
		flash=1
		scr_sound_play(se_player_death_heart)
		//残影1
		after_img_dir=1
		action=5
		time=40
	}
	else if action==5 {
		after_img_dis=48*sin(pi/40*time)
		if time==0 {
			scr_sound_play(se_player_death_heart)
			scr_sprite_change(-2, 2, 0)
			//残影2
			after_img_dir=1
			action=6
			time=40
		}
	}
	//分散
	else if action==6 {
		after_img_dis=48*sin(pi/40*time)
		if time==0 {
			after_img_dir=1
			action=7
			time=40
		}
	}
	else if action==7 {
		after_img_alpha=time/40
		after_img_dis=256*(1-time/40)
		if time==0 {
			after_img_dir=0
			after_img_dis=0
			after_img_alpha=0
			scr_sprite_change(-2, -2, 0.25)
			action=8
		}
	}
	//爆炸
	else if action==8 {
		if image_index>=17 {
			with instance_create_depth(x, y, depth-1, obj_animation_once) {
				scr_sprite_change(spr_player_death_boom, 0, 0.5)
			}
			scr_sound_play(obj_player.SE_death)
			scr_sound_play(se_player_death_boom)
			scr_sprite_change(-2, -2, 0)
			action=9
			time=10
		}
	}
	else if action==9 && time==0 {
		scr_sprite_change(-2, -2, 0.25)
		scr_sound_play(se_player_death_disapper)
		action=10
		time=60
	}
	else if action==10 && time==0 {
		global.stop=0
		scr_view_transition(1, 2)
		stage_trans()
	}
} else {
	if action==0 {
		action=1;
		time=30;
	} 
	else if action==1 && time==0 {
		scr_sound_play(obj_player.SE_death)
		scr_sound_play(se_player_death_boom)
		action=2
		time=120
	}
	else if action==2 && time==0 {
		scr_view_transition(1, 0)
		action=3
	}
	else if action==3 {
		if scr_view_transition_Isover(1) {
			scr_view_transition(1, 2)
			action=4
			time=0
		}
	}
	else if action==4 && time==0 {
		action=5
		stage_trans()
	}
}

