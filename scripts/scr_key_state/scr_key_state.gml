/// @arg state
/// @arg key
function scr_key_state(state, key) {
	var keychk=false
	if is_array(key){
		for(var i=0;i<array_length(key);i++){
			keychk = (keyboard_check_direct(key[i]) && keyboard_check(key[i]))
					|| keychk
			if keychk break;
		}
	} else {
		keychk = (keyboard_check_direct(key) && keyboard_check(key))
				|| keychk
	}
	if keychk{
		if state<=0 return 1
		else return ++state
	}
	else{
		if state=-1 return 0
		else if state!=0 return -1
		else return 0
	}
}
