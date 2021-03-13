/// @desc 根据字体获取行间距
/// @arg font
function scr_draw_get_font_sep(fontv) {
	return floor(font_get_size(fontv)*1.35*1.4)
}
/// @scr_draw_text_ext(col,alpha,angle,font,left,top,txt,xx,yy,xscale,yscale,sep,width,Stroke)
/// @arg col
/// @arg alpha
/// @arg angle
/// @arg font
/// @arg left
/// @arg top
/// @arg txt
/// @arg x
/// @arg y
/// @arg xscale
/// @arg yscale
/// @arg sep
/// @arg width
/// @arg c_Str[-1无]
/// @arg strokew
function scr_draw_text(col, alpha, angle, font, xcen, ycen, txt, xx,yy,xscale,yscale,sep,width,Stroke, strokew) {
	var left, top
	if		xcen==0		left=fa_left
	else if xcen==0.5	left=fa_center
	else if xcen==1		left=fa_right
	if		ycen==0		top=fa_top
	else if ycen==0.5	top=fa_middle
	else if ycen==1		top=fa_bottom

	//1mm=3.87px
	//1pt=0.35mm
	//1pt=1.35px

	if sep==-1 sep=scr_draw_get_font_sep(font)

	draw_set_font(font)
	draw_set_halign(left)
	draw_set_valign(top)
	draw_set_alpha(alpha)

	if(Stroke>=0){
		draw_set_color(Stroke)
		draw_text_ext_transformed(xx+strokew, yy+strokew, txt, sep, width, xscale, yscale, angle)
		draw_text_ext_transformed(xx+strokew, yy-strokew, txt, sep, width, xscale, yscale, angle)
		draw_text_ext_transformed(xx-strokew, yy+strokew, txt, sep, width, xscale, yscale, angle)
		draw_text_ext_transformed(xx-strokew, yy-strokew, txt, sep, width, xscale, yscale, angle)
		draw_text_ext_transformed(xx+strokew, yy, txt, sep, width, xscale, yscale, angle)
		draw_text_ext_transformed(xx-strokew, yy, txt, sep, width, xscale, yscale, angle)
		draw_text_ext_transformed(xx, yy+strokew, txt, sep, width, xscale, yscale, angle)
		draw_text_ext_transformed(xx, yy-strokew, txt, sep, width, xscale, yscale, angle)
	}
	draw_set_color(col)
	draw_text_ext_transformed(xx, yy, txt, sep, width, xscale, yscale, angle)
	draw_set_color_alpha_init()
}
/// @desc 绘制含有颜色及按键的文本
/// @arg col
/// @arg alpha
/// @arg angle
/// @arg font
/// @arg left
/// @arg top
/// @arg txt
/// @arg x
/// @arg y
/// @arg xscale
/// @arg yscale
/// @arg sep
/// @arg width
/// @arg c_Str[-1无]
/// @arg strokew
function scr_draw_text_ext(col, alpha, angle, font, xcen, ycen, txt, xx, yy, xscale,yscale,sep,width,stroke,strokew) {
	/**
	 * 绘制范例
	 * draw_text_incolor(font_0,x,y,txt)
	 * txt=@"aaabbbccc[$=ff0000]redcolors"
	 * txt=@"aaabbbccc[$=ff0000ab]redcolorsabalpha"
	 * 前6位为颜色，后2位为透明度(可省略)
	 * 初始默认绘制颜色白色
	 */

	//设置函数参数
	var left,top;
	if		xcen==0		left=fa_left
	else if xcen==0.5	left=fa_center
	else if xcen==1		left=fa_right
	if		ycen==0		top=fa_top
	else if ycen==0.5	top=fa_middle
	else if ycen==1		top=fa_bottom

	//初始设定
	draw_set_alpha(alpha);
	draw_set_font(font);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	//有边框背景
	//if(stroke!=-1){
	//	scr_draw_text(stroke,alpha,angle,font,0,0,str_filter,xx,yy,xscale,yscale,sep,1000000,stroke,strokew);
	//}

	//设置临时计算参数
	var _txt_x=0,//目前绘制横向偏移
		_txt_y=0;//目前绘制纵向偏移

	draw_set_color(col);//从边框色设置为默认色
	
	//执行过滤
	var filter_tags=[
			TXT_COL_PERFIX + "%{?}%" + TXT_COL_SURFIX, 
			TXT_ICON_PERFIX + "%{?}%" + TXT_ICON_SURFIX
		],
		str_filter=string_filter_more(txt, filter_tags),
		str_filter_w=string_width(str_filter)*xscale,
		str_filter_h=string_height(str_filter)*yscale,
		shift_x0=0,
		shift_y0=0;

	//计算实际绘制位置
	if left==fa_left 		shift_x0=0
	else if left==fa_center 	shift_x0=str_filter_w/2
	else if left==fa_right 	shift_x0=str_filter_w
	if top==fa_top 			shift_y0=0
	else if top==fa_middle	shift_y0=str_filter_h/2
	else if top==fa_bottom	shift_y0=str_filter_h

	var shift_xy=shift_xy_angle(shift_x0, shift_y0, angle)
	xx-=shift_xy[0]
	yy-=shift_xy[1]

	//如果没有颜色标示符，直接绘制
	if(!string_contain(txt, [TXT_COL_PERFIX, TXT_ICON_PERFIX])){
		scr_draw_text(col,alpha,angle,font,0,0,txt,xx,yy,xscale,yscale,sep,1000000,stroke,strokew);
		return;
	}

	if(sep==-1) sep=scr_draw_get_font_sep(font);

	//利用换行切分字符串，一行一行绘制
	//exp: txt="first row [$=000000]test \n second row [$=111111]test \n......."
	var _txt_rows = string_split(txt, "\n"),
	_txt_rows_count = array_length(_txt_rows);
	for(var i=0;i<_txt_rows_count;i++){
	#region 一阶循环--着色
		var _txt_row_1 = _txt_rows[i]; //"first row [$=000000]test "， 记录每行文本，不作操作，只在最后删除绘制片段用
		while string_length(_txt_row_1)>0 {
			var _txt_draw_1 = _txt_row_1;
			var _txt_draw_tmp_1=""
			//着色切分
			var _col_tags = [TXT_COL_PERFIX, TXT_COL_SURFIX];
			if string_contain(_txt_draw_1, _col_tags[0]){
				//切分点是"[$="，每次分完前半段后，后半段开头就是"[$="，所以要先判断，在每片段绘制前就着色，并删除掉颜色片段
				if string_pos(_col_tags[0], _txt_draw_1) == 1 {// [$=000000]test 
					var _color_pos_end = string_pos(_col_tags[1], _txt_draw_1),//颜色文本结束位置
						_txt_color_tag = string_copy(_txt_draw_1, 1, _color_pos_end),//"[$=000000]"
						_txt_color = string_copy(_txt_color_tag, string_length(_col_tags[0])+1, string_length(_txt_color_tag)-string_length(_col_tags[0])-string_length(_col_tags[1])),//000000
						_color_alpha = color_from_string(_txt_color);//[col, aph]
					_txt_draw_1 = string_delete(_txt_draw_1, 1, string_length(_txt_color_tag)) //"[$=000000]test" --> "test"
					_txt_draw_tmp_1 = _txt_color_tag
					//着色
					draw_set_color(_color_alpha[0]);
					if(array_length(_color_alpha)>1) draw_set_alpha(_color_alpha[1]);
				}
				//再次颜色切分
				if string_contain(_txt_draw_1, _col_tags[0]){
					var _txt_row_col_parts = string_split(_txt_draw_1, _col_tags[0]) // "first row [$=000000]test " --> ["first row ", "000000]test "]
					_txt_draw_1 = _txt_row_col_parts[0] //当前绘制"first row "
				}
			}
		
		#region 一阶循环--按键
			var _txt_row_2 = _txt_draw_1;
			while string_length(_txt_row_2)>0 {
				var _txt_draw_2 = _txt_row_2;
				var _txt_draw_tmp_2=""
				//按键切分
				var _key_tags = [TXT_ICON_PERFIX, TXT_ICON_SURFIX];
				var keyspr = -1,
					keysprinx = 0,
					keysprwidth = 0
				if string_contain(_txt_draw_2, _key_tags[0]){
					//切分点是"[@=key:"，每次分完前半段后，后半段开头就是"[@=key:"，所以要先判断
					if string_pos(_key_tags[0], _txt_draw_2) == 1 {// "[@=key:A] keyset "
						var _key_pos_end = string_pos(_key_tags[1], _txt_draw_2),//颜色文本结束位置
							_txt_key_tag = string_copy(_txt_draw_2, 1, _key_pos_end),//"[@=key:A]"
							_txt_key = string_copy(_txt_key_tag, string_length(_key_tags[0])+1, string_length(_txt_key_tag)-string_length(_key_tags[0])-string_length(_key_tags[1])),//A
							keysprset = string_get_icon(_txt_key)
						_txt_draw_tmp_2 = _txt_key_tag
						_txt_draw_2 = string_delete(_txt_draw_2, 1, string_length(_txt_key_tag)) //"[@=key:A] keyset " --> "keyset "
						//设置按钮精灵
						keyspr = keysprset[0]
						keysprinx = keysprset[1]
						keysprwidth = sprite_get_width(keyspr)
					}
					//再次切分
					if string_contain(_txt_draw_2, _key_tags[0]){
						var _txt_row_key_parts = string_split(_txt_draw_2, _key_tags[0]) //"press [@=key:A] keyset" --> ["press ", "=A] keyset"]
						_txt_draw_2 = _txt_row_key_parts[0] //当前绘制"first row "
					}
				}
			
			#region 绘制
				//存在按键图标
				if sprite_exists(keyspr) {
					var _txt_sxy = shift_xy_angle(_txt_x*xscale, (_txt_y+1)*yscale, angle),
						_txt_sx = _txt_sxy[0], 
						_txt_sy = _txt_sxy[1]
					if(stroke!=-1){
						for(var isx=-1;isx<=1;isx++)
							for(var isy=-1;isy<=1;isy++)
								draw_sprite_ext(keyspr, keysprinx, xx+_txt_sx+isx*strokew, yy+_txt_sy+isy*strokew, xscale, yscale, angle, stroke, alpha)
					} 
					draw_sprite_ext(keyspr, keysprinx, xx+_txt_sx, yy+_txt_sy, xscale, yscale, angle, draw_get_color(), draw_get_alpha())
					_txt_x += keysprwidth+1
				}
				//绘制文本
				var _txt_final_draw = _txt_draw_2
				{
					var _txt_sxy = shift_xy_angle(_txt_x*xscale, _txt_y*yscale, angle),
						_txt_sx = _txt_sxy[0], 
						_txt_sy = _txt_sxy[1],
						nowcol = draw_get_color(),
						nowaph = draw_get_alpha()
					if(stroke!=-1){
						draw_set_color(stroke)
						draw_set_alpha(alpha)
						for(var isx=-1;isx<=1;isx++)
							for(var isy=-1;isy<=1;isy++)
								draw_text_ext_transformed(xx+_txt_sx+isx*strokew, yy+_txt_sy+isy*strokew, _txt_final_draw, sep, width, xscale, yscale, angle)
					} 
					draw_set_color_alpha(nowcol, nowaph)
					draw_text_ext_transformed(xx+_txt_sx, yy+_txt_sy, _txt_final_draw, sep, width, xscale, yscale, angle)
					_txt_x += string_width(_txt_final_draw);
				}
			#endregion
		
				//删除当前行的绘制内容
				var delstr = _txt_draw_tmp_2 + _txt_draw_2
				_txt_row_2 = string_delete(_txt_row_2, 1, string_length(delstr))
			}
		
			//删除当前行的绘制内容
			var delstr = _txt_draw_tmp_1 + _txt_draw_1
			_txt_row_1 = string_delete(_txt_row_1, 1, string_length(delstr))
		#endregion
		}
	#endregion
		//此行结束，进行坐标计算
		_txt_x = 0;//绘制横坐标清零
		_txt_y += sep;//绘制高度增加一行
	}
}
/// @desc 中间可以绘制彩色的文本，需要注意的是会默认左上角绘制
/// @arg font 绘制的字体
/// @arg x 绘制横坐标
/// @arg y 绘制纵坐标
/// @arg txt 绘制文本
/// @arg col 绘制初始颜色
/// @arg alpha 绘制透明度
/// @arg sep 行间距[-1无]
/// @arg c_Str[-1无]
/// @arg strokew
function scr_draw_text_incolor(font, xx, yy, txt, col, alpha, sep, stroke, strokew) {
	/**
	 * 绘制范例
	 * draw_text_incolor(font_0,x,y,txt)
	 * txt=@"aaabbbccc[$=ff0000]redcolors"
	 * txt=@"aaabbbccc[$=ff0000ab]redcolorsabalpha"
	 * 前6位为颜色，后2位为透明度(可省略)
	 * 初始默认绘制颜色白色
	 */

	//初始设定
	draw_set_alpha(alpha);
	draw_set_font(font);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	//有边框背景
	if(stroke!=-1){
		//过滤颜色标识
		var str_filter=string_filter(txt, "[$=%{?}%]");
		scr_draw_text_ext(stroke,alpha,0,font,0,0,str_filter,xx-strokew,yy-strokew,1,1,sep,1000000,-1, 0);
		scr_draw_text_ext(stroke,alpha,0,font,0,0,str_filter,xx-strokew,yy,1,1,sep,1000000,-1, 0);
		scr_draw_text_ext(stroke,alpha,0,font,0,0,str_filter,xx-strokew,yy+strokew,1,1,sep,1000000,-1, 0);
		scr_draw_text_ext(stroke,alpha,0,font,0,0,str_filter,xx,yy-strokew,1,1,sep,1000000,-1, 0);
		scr_draw_text_ext(stroke,alpha,0,font,0,0,str_filter,xx,yy+strokew,1,1,sep,1000000,-1, 0);
		scr_draw_text_ext(stroke,alpha,0,font,0,0,str_filter,xx+strokew,yy-strokew,1,1,sep,1000000,-1, 0);
		scr_draw_text_ext(stroke,alpha,0,font,0,0,str_filter,xx+strokew,yy,strokew,1,sep,1000000,-1, 0);
		scr_draw_text_ext(stroke,alpha,0,font,0,0,str_filter,xx+strokew,yy+strokew,1,1,sep,1000000,-1, 0);
	}

	//设置临时计算参数
	var 
	_txt_x=0,//目前绘制横向偏移
	_txt_y=0;//目前绘制纵向偏移

	draw_set_color(col);//从边框色设置为默认色

	//如果没有颜色标示符，直接绘制
	if(string_pos("[$=", txt)<=0){
		scr_draw_text_ext(col,alpha,0,font,0,0,txt,xx,yy,1,1,sep,1000000,stroke, strokew);
		return;
	}

	if(sep==-1) sep=scr_draw_get_font_sep(font);

	//利用换行切分字符串，一行一行绘制
	var _txt_rows = string_split(txt, "\n"),
	_txt_rows_count = array_length(_txt_rows);
	for(var i=0;i<_txt_rows_count;i++){
		var _txt_row = _txt_rows[i];
		_txt_x = 0;//每行需要清空横向偏移
		//利用颜色标签切分字符串，第一句不含标签，第二句开始解析头部标签
		var _txt_row_parts = string_split(_txt_row, "[$="),
		_txt_row_parts_count = array_length(_txt_row_parts);
		for(var j=0;j<_txt_row_parts_count;j++){
			var _txt_row_part = _txt_row_parts[j];
			var _txt_draw;//要绘制的文本
		
			if(j==0){//第一部分，不需要获取颜色
				_txt_draw = _txt_row_part;
			}else{//后面的部分，需要获取颜色
				var _color_pos_end = string_pos("]", _txt_row_part);//颜色文本结束位置
				var _txt_color = string_copy(_txt_row_part, 1, _color_pos_end-1);//颜色文本
				_txt_draw = string_copy(_txt_row_part, _color_pos_end+1, string_length(_txt_row_part)-_color_pos_end);//去除颜色文本和一位]
				var _color_alpha = color_from_string(_txt_color);
				draw_set_color(_color_alpha[0]);
				if(array_length(_color_alpha)>1) draw_set_alpha(_color_alpha[1]);
			}
			draw_text(xx+_txt_x, yy+_txt_y, _txt_draw);
			_txt_x += string_width(_txt_draw);
		}
	
		_txt_y += sep;
	}
}
