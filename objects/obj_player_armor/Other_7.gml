event_inherited();
if sprite_index == SS_idle_shoot{
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
else if sprite_index == SS_jump_shoot{
	scr_sprite_change(-2,2,-2)
}
else if sprite_index == SS_fall_shoot{
	scr_sprite_change(-2,2,-2)
}
else if sprite_index == SS_dash_shoot{
	scr_sprite_change(-2,2,-2)
}
//else if sprite_index == SS_lad_shoot{
//	scr_sprite_change(-2,2,0)
//}