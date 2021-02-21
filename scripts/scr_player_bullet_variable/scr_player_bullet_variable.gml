function scr_player_bullet_variable() {
	attack=0
	attack_up=0
	element=ELEMENTS.none
	//debuff=DEBUFF.none//继承玩家的debuff
	attack_type=0//0炮击1切开2击飞
	unrepeat=0//设置击中后的防止重复数值
	uninjure_set=0//0赋值1叠加
	uninjure_up=0//可行无敌上限
	uninjure_change=0//无敌改变为/增加数值
	speed_low=0//是否有打击感
	bullet_dispel=false //是否能消弹
	hit=0//击中目标
	half_action=0//敌人半身动作，0无，1击飞，2旋转击飞
	charge_break=0
	unrepeat_demage=0//是否在敌人无敌时造成无效攻击
	push_dir=0
	damage1=0//击中杂兵
	damage2=0//击中BOSS
	damage3=0//击中子弹
	action=0
	hsp=0
	vsp=0
	hitx=x
	hity=y
	hit_target=noone//被击中的目标id
	only_target=[] //唯一指定攻击目标
	exclude_target=[] //需要排除的对象
	undm_exclude=[] //需要排除的护盾
	//跳帧攻击用
	skip_now_insts = [] //当前帧受到伤害的实例记录
	skip_attack_step = 0 //受到伤害间隔
	for(var i=0;i<30;i++){ //记录最多5帧的伤害对象
		skip_pre_insts[i]=[]
	}
	only_hit_once = false //每个对象只攻击一次(防止重复伤害和超级判定)
	only_hit_once_insts = []
}
