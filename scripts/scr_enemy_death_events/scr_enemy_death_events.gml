/// @desc 死亡时属性特效
function scr_enemy_element_death(){
	if(injure_type==ATK_TYPE.bullet 
	|| injure_type==ATK_TYPE.cut 
	|| injure_type==ATK_TYPE.through) {
		if(element==ELEMENTS.fire && injure_element==ELEMENTS.elec)
		||(element==ELEMENTS.ice && injure_element==ELEMENTS.fire)
		||(element==ELEMENTS.elec && injure_element==ELEMENTS.ice) {
			
		}
	}
}
/// @desc 死亡时产生道具
function scr_enemy_create_item() {
	
}
/// @desc 死亡时发生爆炸
/// @arg x*
/// @arg y*
function scr_enemy_boom_number(xx, yy, number, type) {
	if!xx xx=x;
	if!yy yy=y;
	if!number number=boom_number;
	if!type type=boom_type;
	//按照爆炸数进行爆炸
	if number>0{
		for(var i=0;i<number;i+=1){
			var ddd=90+i*(360/((number=1) ? number : (number-1)))
			var lex=xx+lengthdir_x(24,ddd)*sign(i)
			var ley=yy+lengthdir_y(24,ddd)*sign(i)
			if type==0{
				with(instance_create_depth(lex,ley,depth-1,obj_animation_once)){
					scr_sprite_change(spr_boom,0,0.5)
				}
			}
			//互相伤害
			else if type==1{
				with(instance_create_depth(lex,ley,depth-1,obj_bullet_animation_once)){
					scr_sprite_change(spr_boom2 ,0,0.5)
					attack=other.attack
					with(instance_create_depth(lex,ley,depth,obj_player_bullet)){
						dis_edge=-1
						scr_sprite_change(spr_boom2 ,0,0.5)
						scr_player_damage_set(other.attack,0,0,1,1,0,1,0)
						animation_once=true
					}
				}
			}
			//只伤害玩家
			else if type==2{
				with(instance_create_depth(lex,ley,depth-1,obj_bullet_animation_once)){
					scr_sprite_change(spr_boom2 ,0,0.5)
					attack=other.attack
				}
			}
		}
		var edge=64
		if variable_instance_exists(id,"view_edge") edge=view_edge
		if scr_in_view(edge) || edge<0{
			if number>=3 scr_sound_play(se_boom)
			else scr_se_boom()
			scr_enemy_boom_viewweak()
		}
	}
}
/// @desc 死亡时爆零件
function scr_enemy_boompart(partspr) {
	if partspr=spr_none exit
	var number=sprite_get_number(partspr)
	for(var i=0;i<number;i+=1){
		var part
		if layer_exists(layer) part=instance_create_layer(x,y,layer,obj_enemy_part)
		else part=instance_create_depth(x,y,depth,obj_enemy_part)
		part.image_xscale=image_xscale
		part.image_yscale=image_yscale
		part.dspeed=random(10)*-image_xscale*image_yscale
		with(part){
			scr_sprite_change(partspr,i,0)
			gravity=G
			if place_meeting(x,y,obj_water)
				gravity=G/2
			switch(irandom(number)){
				case 0:{
					hspeed=4*image_xscale
					vspeed=-10*image_yscale
					break
				} case 1:{
					hspeed=2*image_xscale
					vspeed=-6*image_yscale
					break
				} case 2:{
					hspeed=-2*image_xscale
					vspeed=-8*image_yscale
					break
				} case 3:{
					hspeed=-8*image_xscale
					vspeed=-6*image_yscale
					break
				} case 4:{
					hspeed=-4*image_xscale
					vspeed=-10*image_yscale
					break
				} case 5:{
					hspeed=-2*image_xscale
					vspeed=-6*image_yscale
					break
				} case 6:{
					hspeed=2*image_xscale
					vspeed=-8*image_yscale
					break
				} case 7:{
					hspeed=8*image_xscale
					vspeed=-6*image_yscale
					break
				} default:{
					hspeed=6*image_xscale
					vspeed=-6*image_yscale
					break
				}
			}
			if place_meeting(x,y,obj_water)
				vspeed*=1.5
		}
	}
}
/// @arg spr_part
/// @arg number
/// @arg x
/// @arg y
function scr_enemy_boompart_ext(spr, number, xx, yy) {
	if spr=spr_none exit
	var spr_num=sprite_get_number(spr)
	for(var i=0;i<number;i+=1){
		var part=instance_create_depth(xx,yy,depth,obj_enemy_part)
		part.image_xscale=image_xscale
		part.image_yscale=image_yscale
		part.dspeed=random(10)*-image_xscale*image_yscale
		with(part){
			scr_sprite_change(spr,i mod spr_num,0)
			gravity=G
			if place_meeting(x,y,obj_water)
				gravity=G/2
			hspeed=random_range(-10,10)
			vspeed=image_yscale*random_range(-10,-6)
			if place_meeting(x,y,obj_water)
				vspeed*=1.5
		}
	}
}

/// @desc 死亡时晃动镜头
function scr_enemy_boom_viewweak() {
	
}