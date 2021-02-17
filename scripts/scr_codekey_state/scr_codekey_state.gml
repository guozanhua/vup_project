function scr_codekey_state(state, key) {
	//scr_codekey_state(state,key)
	/// @arg state
	/// @arg key
	var keychk=0;

	if is_array(key){
		for(var i=0;i<array_length(key);i++){
			if key[i]==1{
				keychk=1
				break
			}
		}
	} else {
		keychk = key
	}
	if keychk==1{
		if state==0 || state==-1
			state=1
		else 
			++state
	}
	else if keychk==0{
		if state>=1
			state=-1
		else if state==-1
			state=0
	}
	return state
}
