#region 屏幕光暗
////变身
//if global.rockon_flash=1{//变白
//	if global.rockon_flash_rate<1
//		global.rockon_flash_rate+=0.25
//	else
//		global.rockon_flash=2
//}
//else if global.rockon_flash=2{//持续
//	if global.rockon_flash_rate<2.5
//		global.rockon_flash_rate+=0.25
//	else
//		global.rockon_flash=3
//}
//else if global.rockon_flash=3{//恢复
//	if global.rockon_flash_rate>0
//		global.rockon_flash_rate-=0.25
//	else
//		global.rockon_flash=0
//}
//变黑
if global.room_change==1{
	if global.room_change_rate[1]<1
		global.room_change_rate[1]+=0.04
	else
		global.room_change=2
}
else if global.room_change==2{
	if global.room_change_rate[1]>0
		global.room_change_rate[1]-=0.04
	else
		global.room_change=0
}
//变白
if global.room_change==3{
	if global.room_change_rate[2]<1
		global.room_change_rate[2]+=0.04
	else
		global.room_change=4
}
else if global.room_change==4{
	if global.room_change_rate[2]>0
		global.room_change_rate[2]-=0.04
	else
		global.room_change=0
}
#endregion