scr_menu_stop();
if(!scr_menu_trem()) exit;
scr_time_alarm();
hit=0;
if(set_hit!=0) {
	hit=set_hit;
	set_hit=0;
}
//////////////////////////////
damage1=scr_player_damage_enemy();
damage2=scr_player_damage_boss();
//////////////////////////////
var bullet = instance_place(x,y,obj_bullet)
if(instance_exists(bullet)) {
	with(bullet) {
		if(undm==1 || can_be_dmg) {
			other.damage3=true;
			if(can_be_dmg) other.hit=2;
			else if(undm==1) other.hit=-1;
		}
		else other.damage3=false;
	}
} else damage3=false;