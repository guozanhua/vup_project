/// @arg gaypad
/// @arg state
/// @arg gpkey
function scr_gaypad_state(gaypad, state, gpkey) {
	var keychk=false
	if is_array(gpkey){
		for(var i=0;i<array_length(gpkey);i++){
			keychk = gamepad_button_check(gaypad,gpkey[i]) || keychk
			if keychk break;
		}
	} else {
		keychk = gamepad_button_check(gaypad,gpkey) || keychk
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
