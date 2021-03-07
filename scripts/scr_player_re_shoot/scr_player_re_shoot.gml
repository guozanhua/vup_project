function scr_player_re_shoot(shx, shy) {
	with instance_create_depth(x+shx*image_xscale,y+shy*image_yscale,depth-1,obj_player_hu_bullet) {
		var bullet_number=0
		if instance_exists(obj_player_hu_bullet){
			with(obj_player_hu_bullet){
				if sprite_index==spr_player_hu_bullet01
					bullet_number+=1
			}
		}
		//数量上限
		if(bullet_number>=3) {
			instance_destroy()
		} else {
			scr_sprite_change(spr_player_hu_bullet01,0,0.5)
			image_xscale=other.image_xscale
			image_yscale=other.image_yscale
			hspeed=8*image_xscale
			scr_player_damage_set(2,ELEMENTS.none,ATK_TYPE.bullet,0,1,0,1,0)
			scr_sound_play(se_player_hu_bullet01)
		}
	}
	bullet_time=bullet_set
}
