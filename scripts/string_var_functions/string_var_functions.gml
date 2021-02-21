/// @function string_get_var
/// @desc 根据字符串变量名获取变量值，也可以用于将字符串表示的值转化为gml数据类型
/// @arg str
function string_get_var(str) {
	/**
	 * 使用范例
	 * txt = "obj_player.walk"
	 * val = string_get_var(txt)
	 * val : 1
	 * 
	 * txt = "[1,2,'3']"
	 * val = string_get_var(txt)
	 * val : [1,2,"3"]
	 * 注：二维数组格式为[[1,2,3],[4,5]]，所以不可以使用三层及以上数组嵌套
	 */
	var varname = string_replace_all(str, " ", ""),//去掉空格
		varname_s = str,//不去空格的，用来做字符串
		val = undefined
	//全局或对象变量
	if string_pos("." ,varname){
		var obj_var = string_split(varname, "."),
			OBJ = obj_var[0],
			VAR = obj_var[1]
		//如果是全局变量
		if OBJ = "global" {
			if variable_global_exists(VAR){
				val = variable_global_get(VAR)
			}
		}
		//如果是对象变量(一般为唯一对象，如obj_staff)
		else {
			var object = asset_get_index(OBJ)
			if object_exists(object){
				var inst = object.id
				if variable_instance_exists(inst ,VAR){
					val = variable_instance_get(inst, VAR)
				}
			}
		}
	}
	//已经写好的值
	else{
		//二维数组
		if string_pos("[[" ,varname){
			while string_char_at(varname_s, string_length(varname_s)) = " "
				varname_s = string_copy(varname_s, 1, string_length(varname_s)-1)
			var arys = string_split(string_copy(varname_s, 2, string_length(varname_s)-2), "],[")
			val = []
			for(var i=0;i<array_length(arys);i++){
				var tmp1 = arys[i], tmp2 = string_replace_all(arys[i], " ", "")
				if string_char_at(tmp2, 1) = "[" && string_char_at(tmp2, string_length(tmp2)) != "]"
					tmp1 += "]"
				else if string_char_at(tmp2, 1) != "[" && string_char_at(tmp2, string_length(tmp2)) = "]"
					tmp1 = "[" + tmp1
				else if string_char_at(tmp2, 1) != "[" && string_char_at(tmp2, string_length(tmp2)) != "]"
					tmp1 = "[" + tmp1 + "]"
			
				var aryvals = string_get_var(tmp1)
				for(var j=0;j<array_length(aryvals);j++){
					val[i][j] = aryvals[j]
				}
			}
		}
		//一维数组
		else if string_pos("[" ,varname){
			while string_char_at(varname_s, string_length(varname_s)) = " "
				varname_s = string_copy(varname_s, 1, string_length(varname_s)-1)
			var aryvals = string_split(string_copy(varname_s, 2, string_length(varname_s)-2), ",")
			val = []
			for(var i=0;i<array_length(aryvals);i++){
				val[i] = string_get_var(aryvals[i])
			}
		}
		//字符串
		else if string_pos("'" ,varname){
			var parts = string_split(varname_s, "'")
			val = parts[1]
		}
		//实数
		else if varname = string(string_digits(varname)){
			val = real(varname)
		}
		//资源
		else{
			var asset = asset_get_index(varname)
			if asset != -1 val = asset
		}
	}
	return val
}
/// @desc 根据键名获取图标信息
/// @arg keyname
/// @return [spr, inx]
function string_get_icon(keyname) {
	var iconspr = spr_none,
		iconinx = 0,
		currtime = global.fps_curr,
		currtimediv = currtime div 15
	#region 有分类
	if string_contain(keyname, ":") {
		var type_name = string_split(keyname, ":"),
			type = type_name[0],
			name = type_name[1]
		switch type {
			case "key" : { #region key:
			#region 手柄
				if gaypad_exists() || os_type_is(OS.HOST) {
					iconspr = spr_menu_gaypad_icon_xbox
					if os_type_is(OS.HOST) {
						if os_type_is(OS.NS) iconspr = spr_menu_gaypad_icon_ns
						else if os_type_is(OS.PS) iconspr = spr_menu_gaypad_icon_ps
						else if os_type_is(OS.XBOX) iconspr = spr_menu_gaypad_icon_xbox
					} else {
						if global.joy_button_style=0 iconspr = spr_menu_gaypad_icon_xbox
						else if global.joy_button_style=1 iconspr = spr_menu_gaypad_icon_ps
						else if global.joy_button_style=2 iconspr = spr_menu_gaypad_icon_ns
						//if gaypad_pc_host_type() = OS.NS iconspr = spr_menu_gaypad_icon_ns
					}
				#region 动作按键
					switch name {
						case "jump" : {
							name = gaypad_get_string(global.jump_joy)
							break
						}
						case "true" : {
							name = gaypad_get_string(global.true_joy)
							break
						}
						case "att" : {
							name = gaypad_get_string(global.att_joy)
							break
						}
						case "trans" : {
							name = gaypad_get_string(global.trans_joy)
							break
						}
						case "dash" : {
							name = gaypad_get_string(global.dash_joy)
							break
						}
						case "sub" : {
							name = gaypad_get_string(global.sub_joy)
							break
						}
						case "tformL" : {
							name = gaypad_get_string(global.tformL_joy)
							break
						}
						case "tformR" : {
							name = gaypad_get_string(global.tformR_joy)
							break
						}
					}
				#endregion
				#region 功能按键
					switch name {
						case "direct" : {
							iconinx=0
							break
						}
						case "up" : {
							iconinx=1
							break
						}
						case "right" : {
							iconinx=2
							break
						}
						case "down" : {
							iconinx=3
							break
						}
						case "left" : {
							iconinx=4
							break
						}
						case "A" : {
							iconinx=5
							break
						}
						case "B" : {
							iconinx=6
							break
						}
						case "X" : {
							iconinx=7
							break
						}
						case "Y" : {
							iconinx=8
							break
						}
						case "L" : {
							iconinx=9
							break
						}
						case "R" : {
							iconinx=10
							break
						}
						case "ZL" : {
							iconinx=11
							break
						}
						case "ZR" : {
							iconinx=12
							break
						}
						case "start" : {
							iconinx=13
							break
						}
						case "select" : {
							iconinx=14
							break
						}
						case "stickL" : {
							iconinx=17
							break
						}
						case "stickR" : {
							iconinx=18
							break
						}
					} 
				#endregion
				} else {
					
				}
			#endregion
				break
			} #endregion
		}
	} 
	#endregion
	#region 无分类
	else {
	
	}
	#endregion
	return [iconspr, iconinx]
}
