/// @arg attack伤害值
/// @arg element 属性
/// @arg type 击打方式
/// @arg unrepeat 是否防止重复伤害，0防重复，其他值为间隔时间
/// @arg ui_max 造成无敌的最大等级<=
/// @arg ui_settype 造成无敌的数值改变，0为赋值，1为叠加
/// @arg ui_change 造成无敌的数值改变量
/// @arg slow 是否有打击感
function scr_player_damage_set(att, elm, type, urp, ui_max, ui_set, ui_chg, slow) {
	//A类道具加成
	attack=att+attack_up
	element=elm
	attack_type=type//0炮击1切开2击飞3贯穿
	unrepeat=urp//设置击中后的防止重复数值
	uninjure_set=ui_set//0赋值1叠加
	uninjure_up=ui_max//可行无敌上限
	uninjure_change=ui_chg//无敌改变为/增加数值
	speed_low=slow//是否有打击感
	//debuff=scr_player_debuff_get()//继承玩家的debuff
}
