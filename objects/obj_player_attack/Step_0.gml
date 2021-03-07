scr_menu_stop();
if(!scr_menu_trem()) exit;
scr_time_alarm();
hit=0;
if(set_hit!=0) {
	hit=set_hit;
	set_hit=0;
}
damage[0]=scr_player_damage_enemy();
damage[1]=scr_player_damage_boss();
var bullet = instance_place(x,y,obj_bullet),
	targets = array_copy([], 0, skip_now_insts, 0, array_length(skip_now_insts))
if(instance_exists(bullet)) {
	with(bullet) {
		if(undm==1 || can_be_dmg) {
			other.damage[2]=true;
			if(can_be_dmg) other.hit=2;
			else if(undm==1) other.hit=-1;
			array_push(targets, id)
		}
		else other.damage[2]=false;
	}
} else damage[2]=false;


//有击中
if((hit>0 && in(true, damage))
|| hit==-1){
	//hit_target(targets)
}