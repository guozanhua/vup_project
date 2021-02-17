/// @desc 主武器按键状态
function scr_player_charge_mainkey_status() {
	if obj_player.sub_unuse=0{
		if global.sub_type=0
			return global.att_state
		else if global.sub_type=1
			return global.att_state
		else if global.sub_type=2{
			if global.sub_change[global.model]=0
				return global.att_state
			else
				return 0
		}
	}
	else if obj_player.sub_unuse=1{
		//Y,R
		if global.sub_type=0{
			if !keystate_check(global.att_state) 
			&& !keystate_check(global.sub_state)
				return 0
			else if keystate_check(global.att_state)
			&& !keystate_check_direct(global.sub_state){
				if keystate_check_released(global.sub_state) 
				|| keystate_check_pressed(global.sub_state)
					return global.sub_state
				else return global.att_state
			}
			else if keystate_check(global.sub_state)
			&& !keystate_check_direct(global.att_state){
				if keystate_check_released(global.att_state) 
				|| keystate_check_pressed(global.att_state)
					return global.att_state
				else return global.sub_state
			}
			else
				return global.att_state
		}
		//Y.Y+R
		else if global.sub_type=1
			return global.att_state
		//Y|R
		else if global.sub_type=2
			return global.att_state
	}
}
/// @desc 副武器按键状态
function scr_player_charge_subkey_status() {
	if global.sub_type=0
		return global.sub_state
	else if global.sub_type=1
		return global.att_state
	else if global.sub_type=2{
		if global.sub_change[global.model]=1
			return global.att_state
		else
			return 0
	}
}
/// @desc 放开蓄力时的等级
/// @arg i
function scr_player_charge_release(i) {
	with obj_player{
		if charge_break[i]==4
			charge_break[i]=5
		else{
			if charge[i]>=150 charge_break[i]=3
			else if charge[i]>=100 charge_break[i]=2
			else if charge[i]>=30 charge_break[i]=1
			else charge_break[i]=0
		}
		charge[i]=0
	}
}
/// @desc 发射子弹后变化的charge_break的值
/// @arg oldval
function scr_player_charge_break_change(oldval) {
	if oldval==3 return 4
	else if oldval==4 return 4
	else return 0
}
/// @desc 清空玩家的蓄力状态
function scr_player_charge_clear() {
	with obj_player{
		charge[1]=0
		charge[2]=0
		charge_break[1]=0
		charge_break[2]=0
		charge_index[1]=0
		charge_index[2]=0
	}
}
/// @desc 蓄力释放后，清空该武器蓄力
/// @arg mainsub0-1
function scr_player_charge_over(mainsub) {
	if mainsub==0{
		if global.main_sub_exchange[global.model]==0 
			obj_player.charge_break[1]=0
		else if global.main_sub_exchange[global.model]==1 
			obj_player.charge_break[2]=0
	}
	else{
		if global.main_sub_exchange[global.model]==0 
			obj_player.charge_break[2]=0
		else if global.main_sub_exchange[global.model]==1 
			obj_player.charge_break[1]=0
	}
}
#region 武器按键判定
/// @arg status 按下0按住1
/// @arg exmainsub0 0使用另一武器判定
function scr_player_mainuse(status, exmainsub0) {
	if global.main_sub_exchange[global.model]==1
	&& exmainsub0==0{
		return scr_player_subuse(status,1)
	}
	else if status==0{
		if(global.sub_type==0 
		&&(keystate_check_pressed(global.att_state) || !in(scr_player_main_chargebreak(1),0,4)))
		||(global.sub_type==1 && !keystate_check(global.sub_state)
		&&(keystate_check_pressed(global.att_state) || !in(scr_player_main_chargebreak(1),0,4)))
		||(global.sub_type==2 && global.sub_change[global.model]==0
		&&(keystate_check_pressed(global.att_state) || !in(scr_player_main_chargebreak(1),0,4)))
			return true
		else{
			if obj_player.sub_unuse==1{
				if(global.sub_type==0 
				&&(keystate_check_pressed(global.sub_state) || !in(scr_player_main_chargebreak(1),0,4)))
				||(global.sub_type==1 && !keystate_check(global.sub_state)
				&&(keystate_check_pressed(global.att_state) || !in(scr_player_main_chargebreak(1),0,4)))
				||(global.sub_type==2 && global.sub_change[global.model]==1
				&&(keystate_check_pressed(global.att_state) || !in(scr_player_main_chargebreak(1),0,4)))
					return true
				else
					return false
			}
			else
				return false
		}
		if(!in(scr_player_main_chargebreak(1),0,4) && global.main_sub_exchange[global.model]==0)
		||(!in(scr_player_main_chargebreak(1),0,4) && global.main_sub_exchange[global.model]==1){
			if(global.sub_type==1 && keystate_check(global.sub_state))
			||(global.sub_type==2 && global.sub_change[global.model]==1){
				if global.main_sub_exchange[global.model]==0
					obj_player.charge_break[1]=scr_player_charge_break_change(obj_player.charge_break[1])
				else if global.main_sub_exchange[global.model]==1
					obj_player.charge_break[2]=scr_player_charge_break_change(obj_player.charge_break[2])
			}
		}
	}
	else if status==1{
		if(global.sub_type==0 && keystate_check(global.att_state))
		||(global.sub_type==1 && keystate_check(global.att_state) && !keystate_check(global.sub_state))
		||(global.sub_type==2 && keystate_check(global.att_state) && global.sub_change[global.model]==0)
			return true
		else{
			if obj_player.sub_unuse==1{
				if(global.sub_type==0 && keystate_check(global.sub_state))
				||(global.sub_type==1 && keystate_check(global.att_state) && keystate_check(global.sub_state))
				||(global.sub_type==2 && keystate_check(global.att_state) && global.sub_change[global.model]==1)
					return true
				else
					return false
			}
			else
				return false
		}
	}
}
/// @arg exmainsub0 0使用另一武器判定
function scr_player_main_chargebreak(exmainsub0) {
	//主手蓄力结果
	if global.main_sub_exchange[global.model]==1
	&& exmainsub0==0
		return scr_player_sub_chargebreak(1)
	else{
		if(global.sub_type==1 && keystate_check(global.sub_state))
		||(global.sub_type==2 && global.sub_change[global.model]==1)
			return 0
		else
			return obj_player.charge_break[1]
	}
}
/// @arg status 按下0按住1
/// @arg exmainsub0 0使用另一武器判定
function scr_player_subuse(status, exmainsub0) {
	if global.main_sub_exchange[global.model]==1
	&& exmainsub0==0{
		return scr_player_mainuse(status,1)
	}
	else if status==0{
		if(global.sub_type==0 
		&&(keystate_check_pressed(global.sub_state) || !in(scr_player_sub_chargebreak(1),0,4)))
		||(global.sub_type==1 && keystate_check(global.sub_state)
		&&(keystate_check_pressed(global.att_state) || !in(scr_player_sub_chargebreak(1),0,4)))
		||(global.sub_type==2 && global.sub_change[global.model]==1
		&&(keystate_check_pressed(global.att_state) || !in(scr_player_sub_chargebreak(1),0,4)))
			return true
		else
			return false
		
		if(!in(scr_player_sub_chargebreak(1),0,4) && global.main_sub_exchange[global.model]==0)
		||(!in(scr_player_main_chargebreak(1),0,4) && global.main_sub_exchange[global.model]==1){
			if(global.sub_type==1 && keystate_check(global.sub_state))
			||(global.sub_type==2 && global.sub_change[global.model]==0){
				if global.main_sub_exchange[global.model]==0
					obj_player.charge_break[2]=scr_player_charge_break_change(obj_player.charge_break[2])
				else if global.main_sub_exchange[global.model]==1
					obj_player.charge_break[1]=scr_player_charge_break_change(obj_player.charge_break[1])
			}
		}
	}
	else if status==1{
		if(global.sub_type==0 && keystate_check(global.sub_state))
		||(global.sub_type==1 && keystate_check(global.att_state) && keystate_check(global.sub_state))
		||(global.sub_type==2 && keystate_check(global.att_state) && global.sub_change[global.model]==1)
			return true
		else
			return false
	}
}/// @arg exmainsub0 0使用另一武器判定
function scr_player_sub_chargebreak(exmainsub0) {
	//副手蓄力结果
	if global.main_sub_exchange[global.model]==1
	&& exmainsub0==0
		return scr_player_main_chargebreak(1)
	else{
		if(global.sub_type==1 && !keystate_check(global.sub_state))
		||(global.sub_type==2 && global.sub_change[global.model]==0)
			return 0
		else
			return obj_player.charge_break[2]
	}
}
#endregion