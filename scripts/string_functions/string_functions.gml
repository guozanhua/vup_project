/// @function to_string(val)
/// @desc 将值转化为字符串输出
/// @arg val 字符串
function to_string(val) {
	/**
	 * 使用范例
	 * array = [1, 2, [3, 4]]
	 * txt = to_string(array)
	 * txt : "[1, 2, [3, 4]]"
	 */
	var valstr = "undefined"
	if val == undefined return "undefined"
	else{
		if is_real(val) valstr = string(val)
		else if is_array(val){
			valstr = "["
			var height = array_length(val)
			//2维数组
			if height > 1{
				for(var i=0;i<height;i++){
					valstr += "["
					var length = array_length_2d(val, i)
					for(var j=0;j<length;j++){
						valstr += to_string(val[i, j])
						if j<length-1 valstr += ","
					}
					valstr += "]"
					if i<height-1 valstr += ","
				}
			} 
			//1维数组
			else {
				var length = array_length(val)
				for(var i=0;i<length;i++){
					valstr += to_string(val[i])
					if i<length-1 valstr += ","
				}
			}
			valstr += "]"
		}
		else if is_string(val) valstr = val
	} 
	return valstr
}
/// @desc 字符串多次替换
/// @arg str
/// @arg [old,new]
/// @arg ...
function string_replace_more() {
	var str=argument[0]
	for(var i=1;i<argument_count;i++){
		var arr=argument[i],old=arr[0],neo=arr[1]//neo=(is_string(arr[1]) ? arr[1] : string(arr[1]))
		str=string_replace(str,old,neo)
	}
	return str
}

/// @desc 切割字符串 "a,b,d,"->["a","b","d"]
/// @arg str 要切分的字符串
/// @arg pot 切分标志
function string_split(str, pot) {
	var potlen=string_length(pot),array=0,i=0
	while string_pos(pot,str)>0{
		array[i++]=string_copy(str,1,string_pos(pot,str)-1)
		str=string_copy(str,string_pos(pot,str)+potlen,string_length(str)-(string_pos(pot,str)+potlen-1))
	}
	array[i++]=str
	if is_array(array) return array
	else if str="" return []
	else return [str]
}
/// @desc 拼接字符串
/// @arg str[]
/// @arg regx
function string_join(ary, regx) {
	var str="",
		arylen=array_length(ary)
	for(var i=0;i<arylen;i++){
		var as=ary[i]
		if is_string(as) str+=ary[i]
		else str+=string(ary[i])
		if i<arylen-1 str+=regx
	}
	return str
}
/// @desc 字符串是否以某段开头
/// @arg str
/// @arg ch
function string_startwith(str, ch) {
	return string_pos(ch, str) == 1
}
/// @desc 字符串是否以某段结尾
/// @arg str
/// @arg ch
function string_endwith(str, ch) {
	return string_pos(ch, str) == string_length(str) - string_length(ch) + 1
}
/// @desc string_contain(str,sunstr) 
/// @arg str 
/// @arg substr/[] 
function string_contain(str, substr) {
	if is_array(substr) {
		for(var i=0;i<array_length(substr);i++) 
			if string_pos(substr[i], str)>0 
				return true
	} else 
		return string_pos(substr, str)>0
	return false
}
/// @desc 对字符进行unicode比较，大于返回1，等于返回0，小于返回-1
/// @arg str1
/// @arg str2
function string_compare(string1, string2) {
	var 
	str1=string_lower(string1),str2=string_lower(string2),
	len1=string_length(str1),len2=string_length(str2),
	minlen=min(len1,len2),maxlen=max(len1,len2)

	for(var i=1;i<=minlen;i++){
		var char1=string_char_at(str1,i),char2=string_char_at(str2,i)
		var ord1=ord(char1),ord2=ord(char2)
		if(ord1>ord2) return 1
		else if(ord1<ord2) return -1
	}
	//前面部分相同则用长度判断
	if len1>len2 return 1
	else if len1<len2 return -1
	else return 0
}
/// @desc 传入6位/8位颜色字符串[RRGGBBAA]，返回[颜色,透明度]
/// @arg colstr
function color_from_string(colstr68) {
	var colstr = string_upper(colstr68),//强制大写，控制格式
		colpart=[0,0,0],//颜色RGB值
		color_alpha=[];//颜色和透明度，传入8位字符串则返回[col,aph]，否则只返回[col]

	//如果长度超过8位就截取
	if(string_length(colstr)>8){
		colstr = string_copy(colstr, 1, 8);
	}
	//如果长度不到6位就补全F
	while(string_length(colstr)<6){
		colstr += "F";
	}

	var _strlen = string_length(colstr);
	for(var i=0;i<_strlen/2;i++){
		var 
		_part_txt = string_copy(colstr, (i+1)*2-1, (i+1)*2),//两位字符串
		_pos_txt = [],//两位字符串
		_pos_real = [],//两位数字
		_num255 = 0;//转换为255后的数字
	
		_pos_txt[0] = string_char_at(_part_txt, 1);//第一位
		_pos_txt[1] = string_char_at(_part_txt, 2);//第二位
	
		for(var j=0;j<2;j++){
			//如果是字母
			if(string_digits(_pos_txt[j]) == ""){
				_pos_real[j] = 10 + string_ord_at(_pos_txt[j], 1) - ord("A");
			}else{
				_pos_real[j] = real(_pos_txt[j]);
			}
		}
		//两位转换为255数字
		_num255 = _pos_real[0]*16 + _pos_real[1];
	
		if(i==3){//如果是透明度
			color_alpha[1] = _num255 / 255;
		}else{//如果是颜色
			colpart[i] = _num255;
		}
	}
	color_alpha[0] = rgb(colpart[0], colpart[1], colpart[2]);

	return color_alpha;
}
/// @desc string_filter(str,regx) 用于过滤指定格式的内容
/// @arg str 需要处理的字符串
/// @arg regx 过滤格式 xxx%{长度}%xxx
function string_filter(str, regx) {
	/**
	 * 使用范例
	 * string_filter("aaaa[$=112233]bbbb", "[$=%{6}%]") //过滤所有[$=xxxxxx],模糊长度6
	 * string_filter("aaaa[$=112233]bbbb", "[$=%{6|8}%]") //过滤所有[$=xxxxxx]和[$=xxxxxxxx],模糊长度6或者8
	 * string_filter("aaaa[$=112233]bbbb", "[$=%{?}%]") //过滤所有[$=xxx...xxx],长度不限
	 * regx限定进行使用一次模糊格式，可以无后段确定，但必须有前段确定，无后段时只能定长或无限长，无限长表示到下一个格式点之前
	 */
	var str_filter;
	if(str=="") return str;
	//如果有模糊部分
	if(string_pos("%{", regx)>0){
		var 
		_regxs=[], //切分格式，[前段确定%{中段模糊}%后段确定]
		_splits=[],
		_blur_lengths=[];
		//模糊前半部分
		_splits = string_split(regx, "%{");
		_regxs[0] = _splits[0];
		//模糊后半部分
		_splits = string_split(_splits[1], "}%");
		_regxs[1] = _splits[0];
		if(array_length(_splits)>1) _regxs[2] = _splits[1];
		else _regxs[2] = "";
		//确定模糊长度
		if(_regxs[1]=="?") _blur_lengths[0]=-1;
		else{
			var _blur_lengths_string = string_split(_regxs[1], "|");
			for(var i=0;i<array_length(_blur_lengths_string);i++){
				_blur_lengths[i] = real(_blur_lengths_string[i]);
			}
		}
	
		//使用前段确定进行切割
		var pre_splits = string_split(str, _regxs[0]);
		if(array_length(pre_splits)>0) str_filter = pre_splits[0];
		else str_filter="";
		//从第二个开始，因为第一个不携带标志
		for(var i=1;i<array_length(pre_splits);i++){
			var oldstr = pre_splits[i];//处理前保存一个用于作对比
			for(var j=0;j<array_length(_blur_lengths);j++){
				//无后段确定
				if(_regxs[2]==""){
					if(_blur_lengths[j]>0){
						pre_splits[i] = string_copy(pre_splits[i], _blur_lengths[j]+1, string_length(pre_splits[i])-_blur_lengths[j]);
					}
					else{
						pre_splits[i] = "";
					}
				}
				else{
					if((_blur_lengths[j]>0 && string_pos(_regxs[2], pre_splits[i]) == _blur_lengths[j]+1)
					|| _blur_lengths[j]<=0){//长度符合或者没有长度限制
						var sndsplits = string_split(pre_splits[i], _regxs[2]);//对后端确定再切分
						pre_splits[i] = sndsplits[1];
					}
				}
			}
			//如果没变化，就把前缀补上
			if(pre_splits[i]==oldstr) pre_splits[i] = _regxs[0] + pre_splits[i];
			str_filter += pre_splits[i];
		}
	}
	//没有模糊部分则直接使用替换函数
	else{
		str_filter = string_replace_all(str, regx, "");
	}
	return str_filter;
}
/// @desc string_filter_more(str,[regx]) 批量过滤
/// @arg str 
/// @arg [regx] 
function string_filter_more(str, regxs) {
	for(var i=0;i<array_length(regxs);i++) {
		str = string_filter(str, regxs[i]);
	}
	return str;
}
/// @function string_format_vals(str, [val1, val2, ...])
/// @example string_format_vals("test_string,%1$,%2$", [1, "aaa"]) --> "test_string,1,aaa"
/// @desc 字符插入变量
/// @arg str
/// @arg [vals]
function string_format_vals(str, vals) {
	for(var i=0;i<array_length(vals);i++){
		var reg = "%"+string(i+1)+"$",
			rep 
		if is_string(vals[i]) rep=vals[i]
		else rep=string(vals[i])
		str = string_replace(str, reg, vals[i])
	}
	return str
}
/// @desc 获取特定格式日期
/// @arg reg
function date_format(reg) {
	reg=string_replace(reg, "yyyy", string(current_year))
	reg=string_replace(reg, "MM", string(current_month))
	reg=string_replace(reg, "dd", string(current_day))
	reg=string_replace(reg, "HH", string(current_hour))
	reg=string_replace(reg, "mm", string(current_minute))
	reg=string_replace(reg, "ss", string(current_second))
	return reg
}