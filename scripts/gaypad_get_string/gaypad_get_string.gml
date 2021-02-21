/// @function gaypad_get_string(gaypad)
/// @arg gaypad
function gaypad_get_string(gpkey) {
	var gaypad;
	switch(gpkey){
		case gp_a:{
	        gaypad="A"
	        break
	    }
	    case gp_b:{
	        gaypad="B"
	        break
	    }
		case gp_x:{
	        gaypad="X"
	        break
	    }
		case gp_y:{
	        gaypad="Y"
	        break
	    }
		/*****************/
		case gp_l:{
	        gaypad="L"
	        break
	    }
		case gp_zl:{
	        gaypad="ZL"
	        break
	    }
		case gp_r:{
	        gaypad="R"
	        break
	    }
		case gp_zr:{
	        gaypad="ZR"
	        break
	    }
		/*****************/
		case gp_select:{
	        gaypad="select"
	        break
	    }
		case gp_start:{
	        gaypad="start"
	        break
	    }
		/*****************/
		case gp_stickl:{
	        gaypad="stickL"//左摇杆按下
	        break
	    }
		case gp_stickr:{
	        gaypad="stickR"//右摇杆按下
	        break
	    }
		/*****************/
		case gp_padl:{
	        gaypad="left"
	        break
	    }
		case gp_padr:{
	        gaypad="right"
	        break
	    }
		case gp_padu:{
	        gaypad="up"
	        break
	    }
		case gp_padd:{
	        gaypad="down"
	        break
	    }
		/*****************/
		default:{
	        gaypad="???"
	        break
	    }
	}
	return gaypad
}
