if(!scr_menu_trem()) exit;
damage[0]=0;
damage[1]=0;
damage[2]=0;
//跳帧伤害记录后推
if(skip_attack_step>0) {
	for(var i=0;i<skip_attack_step-1;i++)
		skip_pre_insts[i]=skip_pre_insts[i+1];
	skip_pre_insts[skip_attack_step-1]=skip_now_insts;
	skip_now_insts=[];
}