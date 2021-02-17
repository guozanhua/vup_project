/// @desc 计算玩家受到伤害
/// @arg enemy
function scr_player_damage_cal(enemy) {
	var attack = enemy.attack,
		damage=ceil(attack*global.player_def),
		overload=scr_itemb_overload()
	//受伤方向
	if sign(enemy.x-x)=image_xscale uninjure=1
	else uninjure=-1
	//扣血
	scr_player_hp_subtract(damage+overload)
	//受伤等级
	injure_level=enemy.damage_level
	//子弹记录击中
	if instance_is_object(enemy, obj_bullet) enemy.hit=1
	//属性（击飞）
	if in(enemy.element, [ELEMENTS.push, ELEMENTS.absorb, ELEMENTS.pushup, ELEMENTS.pushdown]) 
	&& enemy.element!=element{
		injure_element=enemy.element
		//击飞方向，有位移则以位移为准
		if enemy.element = ELEMENTS.push {
			if(enemy.x!=enemy.xprevious) {
				if sign_no0(enemy.xprevious-enemy.x)=image_xscale uninjure=1
				else uninjure=-1
			}
		}
		//击飞方向，有位移则以位移为准
		else if enemy.element = ELEMENTS.pushup {
			uninjure=-1
		}
		//击飞方向，有位移则以位移为准
		else if enemy.element = ELEMENTS.pushdown {
			uninjure=1
		}
	}
}
