/// @desc 根据allkey状态赋值
/// @arg allkey
function scr_allkey_state(allkey) {
	var state=0;
	for(var i=0;i<array_length(allkey);i++) {
		if allkey[i]==-1 && state==0
			state = -1
		else if allkey[i]>state
			state = allkey[i]
	}
	return state;
}
