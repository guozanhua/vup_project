model=PLAYER_MODEL.HU
event_inherited();
dash_can=0//可以冲刺
craw_can=0//可以爬墙
swim_can=0//可以下水

bullet_time=-1
bullet_set=30
clearBullets = function() {
	bullet_time=-1;
}
//判断是否能射出子弹
canShootBullets = function() {
	var bullet_number=0
	if instance_exists(obj_player_hu_bullet){
		with(obj_player_hu_bullet){
			if sprite_index==spr_player_hu_bullet01
				bullet_number+=1
		}
	}
	return bullet_number<3
}
shoot_x[0]=29
shoot_y[0]=-17

shoot_x[1]=30
shoot_y[1]=-18

shoot_x[2]=34
shoot_y[2]=-19

//shoot_x[3]=25
//shoot_y[3]=-7