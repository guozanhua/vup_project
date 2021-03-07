var inx=image_index,
	inxorg=image_index;
event_inherited()
if !scr_player_stop_trem() exit
#region 动画纠错
if bullet_time>0{
	inx=inx mod 3
	bullet_time-=1
	if jump==0{
		if walk==0{
			if sprite_index!=SS_idle_shoot
				scr_sprite_change(SS_idle_shoot,inx,0.25)
		}
		else if walk==1{
			var spd=sprite_get_speed(sprite_index)*image_speed
			if bullet_time>bullet_set-(1/spd)*1
				scr_sprite_change(SS_walk_shoot,-2,0.25)
			else if bullet_time>bullet_set-(1/spd)*2
				scr_sprite_change(SS_walk_shoot1,-2,0.25)
			else
				scr_sprite_change(SS_walk_shoot2,-2,0.25)
		}
		else if walk==2{
			if sprite_index!=SS_dash_shoot
				scr_sprite_change(SS_dash_shoot,inxorg,0.25)
		}
	}
	else if jump==1 || jump==23{
		if sprite_index!=SS_jump_shoot
			scr_sprite_change(SS_jump_shoot,inxorg,0.25)
	}
	else if jump==2{
		if sprite_index!=SS_fall_shoot
			scr_sprite_change(SS_fall_shoot,inxorg,0.25)
	}
}
else if bullet_time==0{
	bullet_time=-1
	if jump==0{
		if walk==0
			scr_sprite_change(SS_idle,0,0.25)
		else if walk==1
			scr_sprite_change(SS_walk,-2,0.25)
		else if walk==2
			scr_sprite_change(SS_dash,-2,0.25)
	}
	else if jump==1 || jump==23 || jump==4
		scr_sprite_change(SS_jumping,0,0.25)
	else if jump==2
		scr_sprite_change(SS_fall,0,0.25)
}
#endregion
#region 发动射击
if scr_player_mainuse(0,0) {
	if jump=0{
		if walk==0{
			scr_sprite_change(SS_idle_shoot,0,0.25)
			scr_player_re_shoot(shoot_x[0],shoot_y[0])
		}
		else if walk==1{
			scr_sprite_change(SS_walk_shoot,-2,0.25)
			scr_player_re_shoot(shoot_x[1],shoot_y[1])
		}
		else if walk==2{
			scr_sprite_change(SS_dash_shoot,-2,0.25)
			scr_player_re_shoot(shoot_x[3],shoot_y[3])
		}
	}
	else if jump==1 || jump==23{
		scr_sprite_change(SS_jump_shoot,0,0.25)
		scr_player_re_shoot(shoot_x[2],shoot_y[2])
	}
	else if jump==2{
		scr_sprite_change(SS_fall_shoot,0,0.25)
		scr_player_re_shoot(shoot_x[2],shoot_y[2])
	}
}
#endregion