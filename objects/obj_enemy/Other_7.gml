if sprite_index == spr_boom{
	scr_sprite_change(spr_none,0,0);
}
else if sprite_index == SS_injure{
	if(injure_type!=2) {
		scr_sprite_change(SS_idle,0,SP_idle);
		action=0;
		hsp=0;
		vsp=0;
	}
}