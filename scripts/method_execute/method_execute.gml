// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function method_execute(mtd, args){
	var val = undefined;
	var argcount = array_length(args);
	//执行
	switch argcount{
	case 0 :
		val = script_execute(mtd);
		break;
	case 1 :
		val = script_execute(mtd, args[0]);
		break;
	case 2 :
		val = script_execute(mtd, args[0], args[1]);
		break;
	case 3 :
		val = script_execute(mtd, args[0], args[1], args[2]);
		break;
	case 4 :
		val = script_execute(mtd, args[0], args[1], args[2], args[3]);
		break;
	case 5 :
		val = script_execute(mtd, args[0], args[1], args[2], args[3], args[4]);
		break;
	case 6 :
		val = script_execute(mtd, args[0], args[1], args[2], args[3], args[4], args[5]);
		break;
	case 7 :
		val = script_execute(mtd, args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
		break;
	case 8 :
		val = script_execute(mtd, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]);
		break;
	case 9 :
		val = script_execute(mtd, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]);
		break;
	case 10 :
		val = script_execute(mtd, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]);
		break;
	case 11 :
		val = script_execute(mtd, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10]);
		break;
	case 12 :
		val = script_execute(mtd, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11]);
		break;
	case 13 :
		val = script_execute(mtd, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11], args[12]);
		break;
	case 14 :
		val = script_execute(mtd, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11], args[12], args[13]);
		break;
	case 15 :
		val = script_execute(mtd, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11], args[12], args[13], args[14]);
		break;
	case 16 :
		val = script_execute(mtd, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11], args[12], args[13], args[14], args[15]);
		break;
	}
	return val;
}