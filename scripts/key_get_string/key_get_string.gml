/// @function key_get_string(key)
/// @arg key
function key_get_string(key) {
	var _key;
	switch(key){
	    case vk_nokey :{
	        _key=@"none"
	        break
	    }
	    case vk_alt :{
	        _key=@"Alt"
	        break
	    }
	    case vk_control :{
	        _key=@"Ctrl"
	        break
	    }
	    case vk_shift :{
	        _key=@"Shift"
	        break
	    }
	    case vk_backspace :{
	        _key=@"Back"
	        break
	    }
	    case vk_decimal :{
	        _key=@"Num."
	        break
	    }
	    case vk_delete :{
	        _key=@"Del"
	        break
	    }
	    case vk_divide :{
	        _key=@"Num/"
	        break
	    }
	    case vk_down :{
	        _key=@"Down"
	        break
	    }
	    case vk_end :{
	        _key=@"End"
	        break
	    }
	    case vk_enter :{
	        _key=@"Enter"
	        break
	    }
	    case vk_escape :{
	        _key=@"Esc"
	        break
	    }
	    case vk_f1 :{
	        _key=@"F1"
	        break
	    }
	    case vk_f2 :{
	        _key=@"F2"
	        break
	    }
	    case vk_f3 :{
	        _key=@"F3"
	        break
	    }
	    case vk_f4 :{
	        _key=@"F4"
	        break
	    }
	    case vk_f5 :{
	        _key=@"F5"
	        break
	    }
	    case vk_f6 :{
	        _key=@"F6"
	        break
	    }
	    case vk_f7 :{
	        _key=@"F7"
	        break
	    }
	    case vk_f8 :{
	        _key=@"F8"
	        break
	    }
	    case vk_f9 :{
	        _key=@"F9"
	        break
	    }
	    case vk_f10 :{
	        _key=@"F10"
	        break
	    }
	    case vk_f11 :{
	        _key=@"F11"
	        break
	    }
	    case vk_f12 :{
	        _key=@"F12"
	        break
	    }
	    case vk_home :
	    {
	        _key=@"Home"
	        break
	    }
	    case vk_insert :{
	        _key=@"Insert"
	        break
	    }
	    case vk_lalt :{
	        _key=@"LAlt"
	        break
	    }
	    case vk_lcontrol :{
	        _key=@"LCtrl"
	        break
	    }
	    case vk_lshift :{
	        _key=@"LShift"
	        break
	    }
	    case vk_left :{
	        _key=@"Left"
	        break
	    }
	    case vk_multiply :{
	        _key=@"Num*"
	        break
	    }
	    case vk_numpad0 :{
	        _key=@"Num0"
	        break
	    }
	    case vk_numpad1 :{
	        _key=@"Num1"
	        break
	    }
	    case vk_numpad2 :{
	        _key=@"Num2"
	        break
	    }
	    case vk_numpad3 :{
	        _key=@"Num3"
	        break
	    }
	    case vk_numpad4 :
	    {
	        _key=@"Num4"
	        break
	    }
	    case vk_numpad5 :{
	        _key=@"Num5"
	        break
	    }
	    case vk_numpad6 :{
	        _key=@"Num6"
	        break
	    }
	    case vk_numpad7 :{
	        _key=@"Num7"
	        break
	    }
	    case vk_numpad8 :{
	        _key=@"Num8"
	        break
	    }
	    case vk_numpad9 :{
	        _key=@"Num9"
	        break
	    }
	    case vk_pagedown :{
	        _key=@"PageDown"
	        break
	    }
	    case vk_pageup :{
	        _key=@"PageUp"
	        break
	    }
	    case vk_pause :{
	        _key=@"Pruse"
	        break
	    }
	    case vk_printscreen :{
	        _key=@"Prtscr"
	        break
	    }
	    case vk_ralt :{
	        _key=@"RAlt"
	        break
	    }
	    case vk_rcontrol :{
	        _key=@"RCtrl"
	        break
	    }
	    case vk_rshift :{
	        _key=@"RShift"
	        break
	    }
	    case vk_right :{
	        _key=@"Right"
	        break
	    }
	    case vk_space :{
	        _key=@"Space"
	        break
	    }
	    case vk_subtract :{
	        _key=@"Num-"
	        break
	    }
	    case vk_add :{
	        _key=@"Num+"
	        break
	    }
	    case vk_tab :{
	        _key=@"Tab"
	        break
	    }
	    case vk_up :{
	        _key=@"Up"
	        break
	    }
	    /*************/
	    case ord("0") :{
	        _key=@"0"
	        break
	    }
	    case ord("1") :{
	        _key=@"1"
	        break
	    }
	    case ord("2") :{
	        _key=@"2"
	        break
	    }
	    case ord("3") :{
	        _key=@"3"
	        break
	    }
	    case ord("4") :{
	        _key=@"4"
	        break
	    }
	    case ord("5") :{
	        _key=@"5"
	        break
	    }
	    case ord("6") :{
	        _key=@"6"
	        break
	    }
	    case ord("7") :{
	        _key=@"7"
	        break
	    }
	    case ord("8") :{
	        _key=@"8"
	        break
	    }
	    case ord("9") :{
	        _key=@"9"
	        break
	    }
	    /*************/
	    case ord("A") :{
	        _key=@"A"
	        break
	    }
	    case ord("B") :{
	        _key=@"B"
	        break
	    }
	    case ord("C") :{
	        _key=@"C"
	        break
	    }
	    case ord("D") :{
	        _key=@"D"
	        break
	    }
	    case ord("E") :{
	        _key=@"E"
	        break
	    }
	    case ord("F") :{
	        _key=@"F"
	        break
	    }
	    case ord("G") :{
	        _key=@"G"
	        break
	    }
	    case ord("H") :{
	        _key=@"H"
	        break
	    }
	    case ord("I") :{
	        _key=@"I"
	        break
	    }
	    case ord("J") :{
	        _key=@"J"
	        break
	    }
	    case ord("K") :{
	        _key=@"K"
	        break
	    }
	    case ord("L") :{
	        _key=@"L"
	        break
	    }
	    case ord("M") :{
	        _key=@"M"
	        break
	    }
	    case ord("N") :{
	        _key=@"N"
	        break
	    }
	    case ord("O") :{
	        _key=@"O"
	        break
	    }
	    case ord("P") :{
	        _key=@"P"
	        break
	    }
	    case ord("Q") :{
	        _key=@"Q"
	        break
	    }
	    case ord("R") :{
	        _key=@"R"
	        break
	    }
	    case ord("S") :{
	        _key=@"S"
	        break
	    }
	    case ord("T") :{
	        _key=@"T"
	        break
	    }
	    case ord("U") :{
	        _key=@"U"
	        break
	    }
	    case ord("V") :{
	        _key=@"V"
	        break
	    }
	    case ord("W") :{
	        _key=@"W"
	        break
	    }
	    case ord("X") :{
	        _key=@"X"
	        break
	    }
	    case ord("Y") :{
	        _key=@"Y"
	        break
	    }
	    case ord("Z") :{
	        _key=@"Z"
	        break
	    }
	    /*************/
	    case 188 :{
	        _key=@","
	        break
	    }
	    case 190 :
	    {
	        _key=@"."
	        break
	    }
	    case 191 :{
	        _key=@"/"
	        break
	    }
	    case 186 :{
	        _key=@";"
	        break
	    }
	    case 222 :{
	        _key=@"'"
	        break
	    }
	    case 220 :{
	        _key=@"\"
	        break
	    }
	    case 219 :{
	        _key=@"["
	        break
	    }
	    case 221 :{
	        _key=@"]"
	        break
	    }
	    case 189 :{
	        _key=@"-"
	        break
	    }
	    case 187 :{
	        _key=@"="
	        break
	    }
	    case 192 :{
	        _key=@"`"
	        break
	    }
	    /*************/
	    default :{
	        _key=@"???"
	        break
	    }
	}
	return(_key)
}
