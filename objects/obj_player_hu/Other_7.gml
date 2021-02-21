event_inherited();
if sprite_index == SS_creep{
	scr_sprite_change(SS_creeping,0,0)
}
else if sprite_index == SS_creeped{
	scr_sprite_change(SS_idle,0,0.25)
	walk=0
}
else if sprite_index == SS_injure3{
	scr_sprite_change(SS_creeping,1,0)
	walk=8
	jump=0
}
else if sprite_index == SS_idle_shoot{
	scr_sprite_change(-2,2,0)
}
else if sprite_index == SS_walk_shoot{
	scr_sprite_change(-2,1,-2)
}
else if sprite_index == SS_walk_shoot1{
	scr_sprite_change(-2,1,-2)
}
else if sprite_index == SS_walk_shoot2{
	scr_sprite_change(-2,1,-2)
}
else if sprite_index == SS_fall_shoot{
	scr_sprite_change(-2,2,-2)
}
//else if sprite_index == SS_lad_shoot{
//	scr_sprite_change(-2,2,0)
//}