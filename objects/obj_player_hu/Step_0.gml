var inx=image_index,
	inxorg=image_index;
event_inherited()
if !scr_player_stop_trem() exit
#region 人类动作
//////////////////
//蹲下
if jump==0{
	if walk==0 || walk==1{
		if(keystate_check(global.down_state) && image_yscale==1)
		||(keystate_check(global.up_state) && image_yscale==-1){
			scr_sprite_change(SS_creep,0,0.25)
			walk=8
			hsp=0
		}
	}
	if walk==8{
		if !scr_player_collcreep(){
			if(!keystate_check(global.down_state) && image_yscale==1)
			  ||(!keystate_check(global.up_state) && image_yscale==-1){
				scr_sprite_change(SS_creeped,0,0.25)
				walk=0
				hsp=0
			}
		}
		if sprite_index==SS_creeping{
			if keystate_check(global.left_state) || keystate_check(global.right_state){
				if keystate_check(global.left_state)
					image_xscale=-1
				else if keystate_check(global.right_state)
					image_xscale=1
				hsp=1*hspd
				scr_sprite_change(-2,-2,0.1)
				//scr_sprite_imspd(sprite_index,0.1,-1,-1)
			}
			else{
				hsp=0
				scr_sprite_change(-2,-2,0)
				//scr_sprite_imspd(sprite_index,0,-1,-1)
			}
		}
	}
}
#endregion