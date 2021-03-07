// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_macro(){
#macro DATA_ENCODE_KEY "VUPROJECT" //加密key
#macro VERSION "1.0.0.0" //版本号
#macro VERSION_KEY "112233AABBCC" //版本密钥
#macro FPS_N 60 //正常帧数
#region 常用参数
	#macro True bool(true)
	#macro False bool(false)
#endregion
#region 屏幕标准尺寸
    #macro VIEW_W 512
    #macro VIEW_H 288
#endregion
#region 文件
	#macro FILE_CONFIG "GameConfig.ini" //配置文件
	#macro FILE_SAVE "save" //存档文件
#endregion
#region 手柄按键（日式）
	#macro gp_a gp_face1
	#macro gp_b gp_face2
	#macro gp_x gp_face3
	#macro gp_y gp_face4
	#macro gp_l gp_shoulderl
	#macro gp_zl gp_shoulderlb
	#macro gp_r gp_shoulderr
	#macro gp_zr gp_shoulderrb
	#macro axis_min 0.5 //摇杆有用的最小幅度（0-1）
#endregion
#region 文本颜色
	#macro TXT_KEY "[$=ff8800]"
	#macro TXT_W "[$=ffffff]"
	#macro TXT_ERR "[$=ff0000]"
	#macro TXT_COL_PERFIX "[$="
	#macro TXT_COL_SURFIX "]"
	#macro TXT_ICON_PERFIX "[@="
	#macro TXT_ICON_SURFIX "]"
#endregion
#region 常用obj常量
	#macro GRAV 0.5
	#macro GROUND_DRAWY 4
#endregion
}