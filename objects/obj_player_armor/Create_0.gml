model=PLAYER_MODEL.ARMOR
event_inherited();

bullet_time=-1
bullet_set=30
clearBullets = function() {
	bullet_time=-1;
}
//站立
shoot_x[0]=29
shoot_y[0]=-17
//走路
shoot_x[1]=30
shoot_y[1]=-18
//空中
shoot_x[2]=34
shoot_y[2]=-19
//冲刺
shoot_x[3]=51
shoot_y[3]=2

//shoot_x[3]=25
//shoot_y[3]=-7