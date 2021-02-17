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