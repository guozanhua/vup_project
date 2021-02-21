/// @arg posxy
/// @arg hcon
/// @arg vcon
function scr_view_freedom(posxy, hcon, vcon) {
	var objx=posxy.x,
		objy=posxy.y

	with(obj_view){
	    if global.view_control=0{
		#region 横坐标控制区
			if hcon{
	        #region 自由活动空间
		        if objx>=global.room_xl+view_wpos(0)/2 && objx<=global.room_xr-view_wpos(0)/2{
		            if view_xpos(0)<objx-256{
		                if global.room_change_xr=1{
		                    if view_xpos(0)<objx-480
		                        view_addx(10+global.player_dx)
		                    else if view_xpos(0)<objx-448
		                        view_addx(9+global.player_dx)
		                    else if view_xpos(0)<objx-416
		                        view_addx(8+global.player_dx)
		                    else if view_xpos(0)<objx-384
		                        view_addx(7+global.player_dx)
		                    else if view_xpos(0)<objx-352
		                        view_addx(6+global.player_dx)
		                    else if view_xpos(0)<objx-320
		                        view_addx(5+global.player_dx)
		                    else if view_xpos(0)<objx-304
		                        view_addx(4+global.player_dx)
		                    else if view_xpos(0)<objx-288
		                        view_addx(3+global.player_dx)
		                    else if view_xpos(0)<objx-272
		                        view_addx(2+global.player_dx)
		                    else if view_xpos(0)<objx-264
		                        view_addx(1+global.player_dx)
		                    else{
		                        view_setx(objx-256)
								global.room_change_xr=0
							}
		                }
		                else if global.room_change_xr=0
		                    view_setx(objx-256)
		            }
		            else if view_xpos(0)>objx-256{
		                if global.room_change_xl=1{
		                    if view_xpos(0)>objx-32
		                        view_addx(-10+global.player_dx)
		                    else if view_xpos(0)>objx-64
		                        view_addx(-9+global.player_dx)
		                    else if view_xpos(0)>objx-96
		                        view_addx(-8+global.player_dx)
		                    else if view_xpos(0)>objx-128
		                        view_addx(-7+global.player_dx)
		                    else if view_xpos(0)>objx-144
		                        view_addx(-6+global.player_dx)
		                    else if view_xpos(0)>objx-176
		                        view_addx(-5+global.player_dx)
		                    else if view_xpos(0)>objx-192
		                        view_addx(-4+global.player_dx)
		                    else if view_xpos(0)>objx-224
		                        view_addx(-3+global.player_dx)
		                    else if view_xpos(0)>objx-240
		                        view_addx(-2+global.player_dx)
		                    else if view_xpos(0)>objx-248
		                        view_addx(-1+global.player_dx)
		                    else{
								view_setx(objx-256)
								global.room_change_xl=0
							}
		                }
		                else if global.room_change_xl=0
		                    view_setx(objx-256)
		            }
		            else{
		                global.room_change_xl=0
						global.room_change_xr=0
		                view_setx(objx-256)
		            }
		        }
			#endregion
	        #region 小房间左侧半个真空期
		        else if /*objx>=global.room_xl && */objx<global.room_xl+view_wpos(0)/2{
		            if view_xpos(0)>global.room_xl+256
		                view_addx(-10)
		            else if view_xpos(0)>global.room_xl+224
		                view_addx(-9)
		            else if view_xpos(0)>global.room_xl+192
		                view_addx(-8)
		            else if view_xpos(0)>global.room_xl+160
		                view_addx(-7)
		            else if view_xpos(0)>global.room_xl+128
		                view_addx(-6)
		            else if view_xpos(0)>global.room_xl+96
		                view_addx(-5)
		            else if view_xpos(0)>global.room_xl+64
		                view_addx(-4)
		            else if view_xpos(0)>global.room_xl+32
		                view_addx(-3)
		            else if view_xpos(0)>global.room_xl+16
		                view_addx(-2)
		            else if view_xpos(0)>global.room_xl
		                view_addx(-1)
		        }
			#endregion
	        #region 小房间右侧半个真空期
		        else if objx>global.room_xr-view_wpos(0)/2/* && objx<=global.room_xr*/{
		            if view_xpos(0)<global.room_xr-view_wpos(0)-256
		                view_addx(10)
		            else if view_xpos(0)<global.room_xr-view_wpos(0)-224
		                view_addx(9)
		            else if view_xpos(0)<global.room_xr-view_wpos(0)-192
		                view_addx(8)
		            else if view_xpos(0)<global.room_xr-view_wpos(0)-160
		                view_addx(7)
		            else if view_xpos(0)<global.room_xr-view_wpos(0)-128
		                view_addx(6)
		            else if view_xpos(0)<global.room_xr-view_wpos(0)-96
		                view_addx(5)
		            else if view_xpos(0)<global.room_xr-view_wpos(0)-64
		                view_addx(4)
		            else if view_xpos(0)<global.room_xr-view_wpos(0)-32
		                view_addx(3)
		            else if view_xpos(0)<global.room_xr-view_wpos(0)-16
		                view_addx(2)
		            else if view_xpos(0)<global.room_xr-view_wpos(0)
		                view_addx(1)
		        }
			#endregion
	        #region 分段小房间（进入）
		        if objx>=global.room_xl && objx<=global.room_xr{
		            if view_xpos(0)<=global.room_xl{
		                if view_xpos(0)<global.room_xl-256
		                    view_addx(10)
		                else if view_xpos(0)<global.room_xl-224
		                    view_addx(9)
		                else if view_xpos(0)<global.room_xl-192
		                    view_addx(8)
		                else if view_xpos(0)<global.room_xl-160
		                    view_addx(7)
		                else if view_xpos(0)<global.room_xl-128
		                    view_addx(6)
		                else if view_xpos(0)<global.room_xl-96
		                    view_addx(5)
		                else if view_xpos(0)<global.room_xl-64
		                    view_addx(4)
		                else if view_xpos(0)<global.room_xl-32
		                    view_addx(3)
		                else if view_xpos(0)<global.room_xl-16
		                    view_addx(2)
		                else if view_xpos(0)<global.room_xl
		                    view_addx(1)
		            }
		            else if view_xpos(0)>=global.room_xr-view_wpos(0){
		                if view_xpos(0)>global.room_xr-view_wpos(0)+256
		                    view_addx(-10)
		                else if view_xpos(0)>global.room_xr-view_wpos(0)+224
		                    view_addx(-9)
		                else if view_xpos(0)>global.room_xr-view_wpos(0)+192
		                    view_addx(-8)
		                else if view_xpos(0)>global.room_xr-view_wpos(0)+160
		                    view_addx(-7)
		                else if view_xpos(0)>global.room_xr-view_wpos(0)+128
		                    view_addx(-6)
		                else if view_xpos(0)>global.room_xr-view_wpos(0)+96
		                    view_addx(-5)
		                else if view_xpos(0)>global.room_xr-view_wpos(0)+64
		                    view_addx(-4)
		                else if view_xpos(0)>global.room_xr-view_wpos(0)+32
		                    view_addx(-3)
		                else if view_xpos(0)>global.room_xr-view_wpos(0)+16
		                    view_addx(-2)
		                else if view_xpos(0)>global.room_xr-view_wpos(0)
		                    view_addx(-1)
		            }
		            if global.room_xr-global.room_xl<=512{
		                if view_xpos(0)>global.room_xr-view_wpos(0)
		                    view_addx(-1)
		                else if view_xpos(0)<global.room_xl
		                    view_addx(1)
		                else
		                    view_setx(global.room_xl)
                    
		                if view_xpos(0)>global.room_xr-view_wpos(0) && view_xpos(0)<global.room_xr-view_wpos(0)+1
		                    view_setx(global.room_xr-view_wpos(0))
		                if view_xpos(0)<global.room_xl && view_xpos(0)>global.room_xl-1
		                    view_setx(global.room_xl)
                
		            }
		        }
			#endregion
			}
		#endregion
		#region 纵坐标控制区
			if vcon{
			#region 自由活动空间
		        if objy>=global.room_yt+view_hpos(0)/2 && objy<=global.room_yb-view_hpos(0)/2{
		            if global.player_reversed=0{
		                if view_ypos(0)<objy-144{
		                    if view_ypos(0)<objy-288
		                        view_addy(11+global.player_dy)
		                    if view_ypos(0)<objy-272
		                        view_addy(10)
		                    if view_ypos(0)<objy-256
		                        view_addy(9)
		                    else if view_ypos(0)<objy-240
		                        view_addy(8)
		                    else if view_ypos(0)<objy-224
		                        view_addy(7)
		                    else if view_ypos(0)<objy-208
		                        view_addy(6)
		                    else if view_ypos(0)<objy-192
		                        view_addy(5)
		                    else if view_ypos(0)<objy-176
		                        view_addy(4)
		                    else if view_ypos(0)<objy-160
		                        view_addy(3)
		                    else if view_ypos(0)<objy-152
		                        view_addy(2)
		                    else if view_ypos(0)<objy-148
		                        view_addy(1)
		                    else
		                        view_sety(objy-144)
		                }
		                else if view_ypos(0)>objy-144{
		                    if view_ypos(0)<objy-136
		                        view_sety(objy-144)
		                    else if view_ypos(0)<objy-128
		                        view_addy(-1)
		                    else if view_ypos(0)<objy-120
		                        view_addy(-2)
		                    else if view_ypos(0)<objy-112
		                        view_addy(-3)
		                    else if view_ypos(0)<objy-96
		                        view_addy(-4)
		                    else if view_ypos(0)<objy-64
		                        view_addy(-5+global.player_dy)
		                    else if view_ypos(0)<objy-32
		                        view_addy(-6+global.player_dy)
		                    else if view_ypos(0)<objy-16
		                        view_addy(-7+global.player_dy)
		                    else
		                        view_addy(-8+global.player_dy)
		                }
		                else
		                    view_sety(objy-144)
		            }
		            else if global.player_reversed=1{
		                if view_ypos(0)>objy-144{
		                    if view_ypos(0)>objy
		                        view_addy(-11+global.player_dy)
		                    else if view_ypos(0)>objy-4
		                        view_addy(-10)
		                    else if view_ypos(0)>objy-8
		                        view_addy(-9)
		                    else if view_ypos(0)>objy-16
		                        view_addy(-8)
		                    else if view_ypos(0)>objy-32
		                        view_addy(-7)
		                    else if view_ypos(0)>objy-48
		                        view_addy(-6)
		                    else if view_ypos(0)>objy-64
		                        view_addy(-5)
		                    else if view_ypos(0)>objy-80
		                        view_addy(-4)
		                    else if view_ypos(0)>objy-96
		                        view_addy(-3)
		                    else if view_ypos(0)>objy-112
		                        view_addy(-2)
		                    else if view_ypos(0)>objy-128
		                        view_addy(-1)
		                    else
		                        view_sety(objy-144)
		                }
		                if view_ypos(0)<objy-144{
		                    if view_ypos(0)>objy-152
		                        view_sety(objy-144)
		                    else if view_ypos(0)>objy-160
		                        view_addy(1)
		                    else if view_ypos(0)>objy-168
		                        view_addy(2)
		                    else if view_ypos(0)>objy-176
		                        view_addy(3)
		                    else if view_ypos(0)>objy-192
		                        view_addy(4)
		                    else if view_ypos(0)>objy-224
		                        view_addy(5+global.player_dy)
		                    else if view_ypos(0)>objy-256
		                        view_addy(6+global.player_dy)
		                    else if view_ypos(0)>objy-272
		                        view_addy(7+global.player_dy)
		                    else
		                        view_addy(8+global.player_dy)
		                }
		                else
		                    view_sety(objy-144)
		            }
		        }
			#endregion
			#region 小房间上方半个真空期
		        else if /*objy>global.room_yt && */objy<=global.room_yt+view_hpos(0)/2{
		            if view_ypos(0)>global.room_yt+144
		                view_addy(-11)
		            else if view_ypos(0)>global.room_yt+128
		                view_addy(-10)
		            else if view_ypos(0)>global.room_yt+112
		                view_addy(-9)
		            else if view_ypos(0)>global.room_yt+96
		                view_addy(-8)
		            else if view_ypos(0)>global.room_yt+80
		                view_addy(-7)
		            else if view_ypos(0)>global.room_yt+64
		                view_addy(-6)
		            else if view_ypos(0)>global.room_yt+48
		                view_addy(-5)
		            else if view_ypos(0)>global.room_yt+32
		                view_addy(-4)
		            else if view_ypos(0)>global.room_yt+16
		                view_addy(-3)
		            else if view_ypos(0)>global.room_yt+8
		                view_addy(-2)
		            else if view_ypos(0)>global.room_yt+4
		                view_addy(-1)
		        }
			#endregion
			#region 小房间下方半个真空期
		        else if objy>=global.room_yb-view_hpos(0)/2/* && objy<global.room_yb*/{
		            if view_ypos(0)<global.room_yb-view_hpos(0)-144
		                view_addy(11)
		            else if view_ypos(0)<global.room_yb-view_hpos(0)-128
		                view_addy(10)
		            else if view_ypos(0)<global.room_yb-view_hpos(0)-112
		                view_addy(9)
		            else if view_ypos(0)<global.room_yb-view_hpos(0)-96
		                view_addy(8)
		            else if view_ypos(0)<global.room_yb-view_hpos(0)-80
		                view_addy(7)
		            else if view_ypos(0)<global.room_yb-view_hpos(0)-64
		                view_addy(6)
		            else if view_ypos(0)<global.room_yb-view_hpos(0)-48
		                view_addy(5)
		            else if view_ypos(0)<global.room_yb-view_hpos(0)-32
		                view_addy(4)
		            else if view_ypos(0)<global.room_yb-view_hpos(0)-16
		                view_addy(3)
		            else if view_ypos(0)<global.room_yb-view_hpos(0)-8
		                view_addy(2)
					else if view_ypos(0)<global.room_yb-view_hpos(0)-4
		                view_addy(1)
		        }
			#endregion
	        #region 分段小房间（进入）
		        if objy>=global.room_yt && objy<=global.room_yb{
		            if view_ypos(0)<global.room_yt{
		                if view_ypos(0)<global.room_yt-144
		                    view_addy(11)
		                else if view_ypos(0)<global.room_yt-128
		                    view_addy(10)
		                else if view_ypos(0)<global.room_yt-112
		                    view_addy(9)
		                else if view_ypos(0)<global.room_yt-96
		                    view_addy(8)
		                else if view_ypos(0)<global.room_yt-80
		                    view_addy(7)
		                else if view_ypos(0)<global.room_yt-64
		                    view_addy(6)
		                else if view_ypos(0)<global.room_yt-48
		                    view_addy(5)
		                else if view_ypos(0)<global.room_yt-32
		                    view_addy(4)
		                else if view_ypos(0)<global.room_yt-16
		                    view_addy(3)
		                else if view_ypos(0)<global.room_yt-8
		                    view_addy(2)
						else if view_ypos(0)<global.room_yt-4
		                    view_addy(1)
		            }
		            else if view_ypos(0)>global.room_yb-view_hpos(0){
		                if view_ypos(0)>global.room_yb-view_hpos(0)+144
		                    view_addy(-11)
		                else if view_ypos(0)>global.room_yb-view_hpos(0)+128
		                    view_addy(-10)
		                else if view_ypos(0)>global.room_yb-view_hpos(0)+112
		                    view_addy(-9)
		                else if view_ypos(0)>global.room_yb-view_hpos(0)+96
		                    view_addy(-8)
		                else if view_ypos(0)>global.room_yb-view_hpos(0)+80
		                    view_addy(-7)
		                else if view_ypos(0)>global.room_yb-view_hpos(0)+64
		                    view_addy(-6)
		                else if view_ypos(0)>global.room_yb-view_hpos(0)+48
		                    view_addy(-5)
		                else if view_ypos(0)>global.room_yb-view_hpos(0)+32
		                    view_addy(-4)
		                else if view_ypos(0)>global.room_yb-view_hpos(0)+16
		                    view_addy(-3)
		                else if view_ypos(0)>global.room_yb-view_hpos(0)+8
		                    view_addy(-2)
						else if view_ypos(0)>global.room_yb-view_hpos(0)+4
		                    view_addy(-1)
		            }
					if global.room_yb-global.room_yt<=view_hpos(0){
			            if view_ypos(0)>global.room_yb-view_hpos(0)
			                view_addy(-1)
			            else if view_ypos(0)<global.room_yt
			                view_addy(1)
			            else
			                view_sety(global.room_yt)
                    
			            if view_ypos(0)>global.room_yb-view_hpos(0) && view_ypos(0)<global.room_yb-view_hpos(0)+1
			                view_sety(global.room_yb-view_hpos(0))
			            if view_ypos(0)<global.room_yt && view_ypos(0)>global.room_yt-1
			                view_sety(global.room_yt)
			        }
		        }
			#endregion
		    }
		#endregion
		}
		//整个房间的掌控
		if view_xpos(0)<0
		    view_setx(0)
		else if view_xpos(0)>room_width-view_wpos(0)
		    view_setx(room_width-view_wpos(0))
		if view_ypos(0)<0
		    view_sety(0)
		else if view_ypos(0)>room_height-view_hpos(0)
		    view_sety(room_height-view_hpos(0))
	}
}
