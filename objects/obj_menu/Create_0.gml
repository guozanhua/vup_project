global.menu=0
#region 菜单操作变量
time=0
menutime=0 //不受暂停影响计时
menu_open_action=0 //开启菜单动作
menu_open_rate=0 //开启菜单黑屏
menu_page=0 //菜单当前页
menu_page_count=5 //菜单页数
menu_type=0 //菜单进度
menu_page_change=0 //页切换
menu_page_change_rate=0 //页切换进度
for(var page=0;page<=20;page+=1)
	for(var type=0;type<=2;type+=1)
		menu_select[page][type]=1
#endregion
#region 插卡操作变量
card_outsert_rate=0 //卡片拔出程度，0插卡中，1完全拔卡
#endregion