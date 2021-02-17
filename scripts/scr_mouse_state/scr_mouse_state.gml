/// @arg state
/// @arg button
function scr_mouse_state(state, button) {
	var keychk=false
	if is_array(button){
		for(var i=0;i<array_length(button);i++){
			keychk = mouse_check_button(button[i]) || keychk
		}
	} else {
		keychk = mouse_check_button(button) || keychk
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
