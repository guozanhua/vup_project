/// @arg otherobj 能伤害的对象
function scr_player_damage(otherobj) {
	var damage_note=false;
	//碰到且有伤害
	if attack>0
	&& place_meeting(x,y,otherobj){
		//获得武器的id
		var btn_or_sbr=id, sbr_is_ext=false
		//如果是光剑延长部分，则将武器切换为光剑
		//if instance_is_object(btn_or_sbr,obj_player_saber_extend){
		//	btn_or_sbr=global.player_saber
		//	sbr_is_ext=true
		//}
		//获得碰到的所有该对象
		var list=ds_list_create(),
			listcnt=instance_place_list(x, y, otherobj, list, false)
		//遍历对象一个一个处理
		for(var i=0;i<listcnt;i++){
			var target = list[| i]
		#region 如果有排除目标，则检测是否为此目标
			if array_length(btn_or_sbr.exclude_target)>0{
				var isexclude = false
				for(var j=0;j<array_length(btn_or_sbr.exclude_target);j++){
					var ontag = btn_or_sbr.exclude_target[j]
					if instance_is_object(target, ontag){
						isexclude = true
						break
					} else if ontag = target{
						isexclude = true
						break
					}
				}
				if isexclude continue
			}
		#endregion
		#region 如果有指定目标，则检测是否为此目标
			if array_length(btn_or_sbr.only_target)>0{
				var istag = false
				for(var j=0;j<array_length(btn_or_sbr.only_target);j++){
					var ontag = btn_or_sbr.only_target[j]
					if instance_is_object(target, ontag){
						istag = true
						break
					} else if ontag = target{
						istag = true
						break
					}
				}
				if !istag continue
			}
		#endregion
		#region 如果是光剑，则先判断其在这一帧是否已经处理过了
			if sbr_is_ext{
				var saber_enemy_list = btn_or_sbr.enemy_list
				if ds_list_find_value(saber_enemy_list, target)>=0{
					continue
				} else {
					ds_list_add(saber_enemy_list, target)
				}
			}
		#endregion
			//切换到对象实例内处理
			with target{
				btn_or_sbr.hitx=x
				btn_or_sbr.hity=y
				btn_or_sbr.hit_target=id
				if can_dmg{
				#region 非无敌
					if undm=0 {
					#region 判断是否切中护盾，护盾判断只针对不无敌的敌人
						//列出所有可能作为护盾的对象
						var undm_obj_type = [
							obj_enemy,
							obj_boss,
							obj_bullet,
							obj_ground_block_bullet,
							obj_boss,
						], place_undm = false
						for(var o=0;o<array_length(undm_obj_type);o++){
							//判断子弹和目标敌人之间的直线链接上是否存在护盾且击中护盾
							var undmlist = ds_list_create(),
								undmlistcnt=collision_line_list(x, y, btn_or_sbr.x, btn_or_sbr.y, undm_obj_type[o], 1, 1, undmlist, false);
							for(var u=0;u<undmlistcnt;u++){
								var undmobj = undmlist[| u]
								if undmobj.undm = 0 continue //护盾不无敌直接跳过
								//如果有排除护盾，则检测是否为此目标
								if array_length(btn_or_sbr.undm_exclude)>0{
									var isexclude = false
									for(var j=0;j<array_length(btn_or_sbr.undm_exclude);j++){
										var ontag = btn_or_sbr.undm_exclude[j]
										if instance_is_object(undmobj, ontag){
											isexclude = true
											break
										} else if ontag = undmobj{
											isexclude = true
											break
										}
									}
									if isexclude continue
								}
								//判断光剑是否击中了护盾
								var btn_or_sbr_placeundm = true
								with btn_or_sbr{
									btn_or_sbr_placeundm = place_meeting(x, y, undmobj)
								}
								if btn_or_sbr_placeundm 
								&& !collision_line(btn_or_sbr.x, btn_or_sbr.y, undmobj.x, undmobj.y, id, 1, 1){ //剑击中了护盾之前没击中敌人
									var x1 = target.x, y1 = target.y,
										x2 = undmobj.x, y2 = undmobj.y,
										cx , cy,
										len = point_distance(x1, y1, x2, y2)
									//迭代判断
									var get_result = false
									while !get_result{
										cx = (x1 + x2)/2
										cy = (y1 + y2)/2
										len/= 2
										//判断前半部分线是否碰到目标
										if collision_line(x1, y1, cx, cy, target, 1, 1){
											//是否碰到护盾，碰到则继续循环
											if collision_line(x1, y1, cx, cy, undmobj, 1, 1){
												x2 = cx
												y2 = cy
											//没碰到直接结束，判定护盾无效
											} else {
												get_result = true
											}
										//判断后半部分线是否碰到目标
										} else if collision_line(x2, y2, cx, cy, target, 1, 1){
											//是否碰到护盾，碰到则继续循环
											if collision_line(x2, y2, cx, cy, undmobj, 1, 1){
												x1 = cx
												y1 = cy
											//没碰到直接结束，判定护盾无效
											} else {
												get_result = true
											}
										//都没碰到目标则表示只碰到护盾，护盾有效
										} else {
											get_result = true
											place_undm = true
										}
										//长度过小但还没判断出来，则表示有重叠，此时判定护盾有效
										if !get_result && len<=1{
											get_result = true
											place_undm = true
										}
									}
									//如果护盾有效了，则直接退出不再判断
									if place_undm break
								}
							}
							ds_list_destroy(undmlist)
							if place_undm break
						}
					#endregion
					#region 无敌等级有效
						if(injure_unrepeat!=btn_or_sbr.unrepeat	//判断是否因为刀刃叠加重复伤害
						|| injure_unrepeat=0		//或者敌人还没进入防重复保护
						|| btn_or_sbr.unrepeat=0)	//或者剑刃没设置防重复
						&& !place_undm		//判断是否砍到护盾
						&& hp>0{			//判断HP是否大于0
							//检测实例是否在上几帧碰撞检测中
							var in_pre_ary = false
							if btn_or_sbr.skip_attack_step>0{
								for(var s=0;s<btn_or_sbr.skip_attack_step;s++){
									if(in_array(btn_or_sbr.skip_pre_insts[s], id)){
										in_pre_ary = true
										break
									}
								}
							}
							if in_pre_ary continue
							//else btn_or_sbr.skip_now_insts=array_push(btn_or_sbr.skip_now_insts, id)
							array_push(btn_or_sbr.skip_now_insts, id)
						
							//判断是否为只击中一次记录对象
							if btn_or_sbr.only_hit_once{
								if in(id, btn_or_sbr.only_hit_once_insts) continue
								//else btn_or_sbr.only_hit_once_insts=array_push(btn_or_sbr.only_hit_once_insts, id)
								array_push(btn_or_sbr.only_hit_once_insts, id)
							}
						
							//如果是杂兵，执行被击中事件
							if instance_is_object(id,obj_enemy) injureTrigger();
					
							//如果不是击飞，则设置击中方向和受伤类型
							if injure_type!=ATK_TYPE.push{
								injure_type=btn_or_sbr.attack_type
								//子弹击中
								if instance_is_object(btn_or_sbr.id,obj_player_bullet){
									inxscale=sign(btn_or_sbr.hspeed+btn_or_sbr.hsp)
									if inxscale=0 inxscale=sign_no0(btn_or_sbr.image_xscale)
								}
								//剑刃击中
								else{
									inxscale=sign(x-btn_or_sbr.x)
									if inxscale=0 inxscale=sign(btn_or_sbr.image_xscale)
								}
								//如果死亡后朝向死亡方向（敌人里有判断）
								/*if death_xscale=1{
									if injure_back=1 || hp<=0
										image_xscale=-inxscale
								}*/
							}
					
							//设置剑刃防重复保护
							if btn_or_sbr.unrepeat!=0
								injure_unrepeat=btn_or_sbr.unrepeat
							scr_player_cut_slow(btn_or_sbr) //打击感
							last_in_element=injure_element //存储上一个被打击到的属性
							//half_action=btn_or_sbr.half_action //砍开类型（普通砍开，抛尸等）
					
							//进行伤害值的造成伤害计算
							var playerattack=btn_or_sbr.attack
							//XXX 道具效果
							//计算各种克制伤害结果
							var atkelement = btn_or_sbr.element, //造成伤害的属性
								attnor=playerattack*DEF, //普通伤害
								attgrum=playerattack*1.5*DEF, //克制伤害
								attingrum=0, //被克制伤害
								attsame=playerattack/2*DEF, //同属性伤害
							    att_infact=attnor, //实际造成伤害
								old_injure_element = injure_element; //记录之前受伤属性
							//冰元素破冰1.5伤害，且不附带任何属性
							if att_infact>0 
							&& old_injure_element==ELEMENTS.ice {
								att_infact = playerattack*1.5*DEF;
								atkelement = ELEMENTS.none;
								element_index=9999
							}
							//敌人无属性
							if element=ELEMENTS.none{
								att_infact=attnor
								if atkelement!=ELEMENTS.none{
									injure_element=atkelement
									element_index=0
								}
							}
							//敌人火属性
							else if element=ELEMENTS.fire{
								if atkelement=ELEMENTS.fire att_infact=attsame
								else if atkelement=ELEMENTS.ice att_infact=attingrum
								else if atkelement=ELEMENTS.elec{
									att_infact=attgrum
									injure_element=atkelement
									element_index=0
								}
								else att_infact=attnor
							}
							//敌人冰属性
							else if element=ELEMENTS.ice{
								if atkelement=ELEMENTS.ice att_infact=attsame
								else if atkelement=ELEMENTS.elec att_infact=attingrum
								else if atkelement=ELEMENTS.fire{
									att_infact=attgrum
									injure_element=atkelement
									element_index=0
								}
								else att_infact=attnor
							}
							//敌人雷属性
							else if element=ELEMENTS.elec{
								if atkelement=ELEMENTS.elec att_infact=attsame
								else if atkelement=ELEMENTS.fire att_infact=attingrum
								else if atkelement=ELEMENTS.ice{
									att_infact=attgrum
									injure_element=atkelement
									element_index=0
								}
								else att_infact=attnor
							}
	        				//减血
						    hp-=att_infact
							scr_sound_play(se_enemy_damage) //播放音效
					
							//反馈给武器攻击结果
							if hp>0 btn_or_sbr.hit=1 //击中
							else{
								if btn_or_sbr.hit!=1
									btn_or_sbr.hit=2 //击杀，不覆盖击中的结果
								hp=0
							}
							flash=1 //闪白
							hitedstp=1

							btn_or_sbr.unrepeat_demage=0
							damage_note=true //记录结果，确实有击中过敌人
					
							//如果是击飞攻击
							if injure_type=ATK_TYPE.push{
								//判断敌人是否可以被击飞
								if push_fly=0 || (push_fly=1 && hp<=0) || push_fly=3{
									if push_fly=0 hp=0
									//如果是光剑，则计算点在玩家脚下
									if btn_or_sbr.object_index=obj_player_saber
										direction=point_direction(btn_or_sbr.x,btn_or_sbr.y+16*btn_or_sbr.image_yscale,x,y)
									//如果是子弹，则计算点为子弹位置
									else direction=point_direction(btn_or_sbr.x,btn_or_sbr.y,x,y)
									speed=6
									gravity=grav
								}
								//不可击飞则抹除击飞效果
								else injure_type=ATK_TYPE.bullet
							}
						}
					#endregion
					#region 击中了无敌中的敌人，属于击中无效
						else if hp>0{
							btn_or_sbr.hitstp=1
							btn_or_sbr.unrepeat_demage=1
						}
					#endregion
					}
				#endregion
				#region 击中无敌的敌人
					else if undm=1 && hp>0{
						//无敌状态被击飞
						if btn_or_sbr.attack_type=ATK_TYPE.push 
						&& undm_push{
							//判断是否为可被击飞类型
							if push_fly=0 || (push_fly=1 && hp<=0) || push_fly=3{
								injure_type=ATK_TYPE.push
								inxscale=sign_no0(btn_or_sbr.x-x)
								if push_fly=0 hp=0
								//击飞设置
								scr_player_push_script(btn_or_sbr)
							}
							//不可击飞则抹除击飞效果
							else injure_type=ATK_TYPE.bullet
						}
						btn_or_sbr.hit=-1 //打击无效
						btn_or_sbr.unrepeat_demage=1 //设置打击无效防重复
						//判断是否开启打击感
						//undm_injure_type=ATK_TYPE.bullet
						if injure_unrepeat_undm!=btn_or_sbr.unrepeat || btn_or_sbr.unrepeat=0{
							scr_sound_play(se_enemy_undamage)
							scr_player_cut_slow(btn_or_sbr)
							injure_unrepeat_undm=btn_or_sbr.unrepeat
							undm_injure_type=btn_or_sbr.attack_type
							hitedstp=-1
						}
					}
				#endregion
				}
			}
		}
		ds_list_destroy(list)
	}
	return damage_note
}
//对硬箱子破坏
function scr_player_damage_block() {
	var damage_note=false,
		btn_or_sbr=id,
		blocklist = ds_list_create(),
		blockcollcnt = 0;
	//if instance_is_object(id,obj_player_saber_extend) btn_or_sbr=global.player_saber
	//对轰击箱子的伤害
	ds_list_clear(blocklist)
	blockcollcnt = instance_place_list(x+(hspeed+hsp)+sign_no0(hspeed+hsp), y+vspeed+sign_no0(vspeed), obj_ground_block, blocklist, false)
	if blockcollcnt>0
	&& btn_or_sbr.attack!=0
	&&(btn_or_sbr.attack_type==2 || btn_or_sbr.element=ELEMENTS.fire){
		for(var i=0;i<blockcollcnt;i++){
			with blocklist[| i]{
				//子弹打破的单独计算
				if instance_is_object(id,obj_ground_block_bullet) continue
				//不是冰块时，如果非轰击则跳过
				if !instance_is_object(id,obj_ground_block_ice) && btn_or_sbr.attack_type!=2 continue
				if undamage=0{
					if btn_or_sbr.only_hit_once{
						if in(id, btn_or_sbr.only_hit_once_insts) continue
						else btn_or_sbr.only_hit_once_insts = array_add_value(btn_or_sbr.only_hit_once_insts, id)
					}
					damage+=1
					undamage=1
					if(btn_or_sbr.speed_low!=0) {
						var oldlow=btn_or_sbr.speed_low
						btn_or_sbr.speed_low=1
						scr_player_cut_slow(btn_or_sbr)
						btn_or_sbr.speed_low=oldlow
					}
					//if instance_is_object(btn_or_sbr,obj_player_saber)
					//	damage_dir=point_direction(btn_or_sbr.x,btn_or_sbr.y+16*btn_or_sbr.image_yscale,x,y)
					//else
					//	damage_dir=point_direction(btn_or_sbr.x,btn_or_sbr.y,x,y)
					damage_dir=point_direction(btn_or_sbr.x,btn_or_sbr.y,x,y)
				}
			}
		}
	}
	ds_list_destroy(blocklist)
	return false
}
//对杂兵伤害
function scr_player_damage_enemy() {
	var damage_note=false
	|| scr_player_damage_block() //对炮击箱子的伤害
	|| scr_player_damage(obj_ground_block_bullet) //对炮击箱子的伤害
	|| scr_player_damage(obj_enemy) //对杂兵伤害
	return damage_note
}
//对BOSS伤害
function scr_player_damage_boss() {
	return false
}