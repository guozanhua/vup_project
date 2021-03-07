if(sprite_index!=spr_boom) 
	if(enemy_ground==1) 
		scr_enemy_flyobj();
if(!scr_menu_trem()) exit;
for(var i=0;i<2;i++){//0前景，1背景，j深度
	for(var j=0;j<5;j++){
		if(sprite_exists(part_spr[i,j])) {
			part_inx[i,j]+=part_spd[i,j];
			part_inx[i,j]=part_inx[i,j] mod sprite_get_number(part_spr[i,j]);
		}
	}
}
if(hitedstp!=0) {
    hited=hitedstp;
    hitedstp=0; //清除hit记录
}
else{
    if(hited!=0) 
        hited=0; //如果有值则清除hit
}
