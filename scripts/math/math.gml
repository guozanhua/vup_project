#region 三角函数
/// @arg degtorad_angle
function sin_de(angle) {
	return sin(degtorad(angle))
}
/// @arg degtorad_angle
function cos_de(angle) {
	return cos(degtorad(angle))
}
/// @arg degtorad_angle
function tan_de(angle) {
	return tan(degtorad(angle))
}
/// @arg cos
function arccos_de(cosval) {
	return degtorad(arccos(cosval))
}
/// @arg sin
function arcsin_de(sinval) {
	return degtorad(arcsin(sinval))
}
/// @arg tan
function arctan_de(tanval) {
	return degtorad(arctan(tanval))
}
#endregion
#region 几何运算
/// @desc xy偏移经过转动
/// @arg lenx
/// @arg leny
/// @arg rot
function shift_xy_angle(lenx, leny, rot) {
	var rtnxy=[0,0]
	rtnxy[0]=leny*sin_de(rot)+lenx*cos_de(rot)
	rtnxy[1]=leny*cos_de(rot)-lenx*sin_de(rot)
	return rtnxy
}
/// @desc 勾股定理
/// @arg side1
/// @arg side2
function triangle_hypotenuse(side1, side2) {
	return point_distance(side1,0,0,side2)
}
#endregion
#region 线运算
/// @function line_get_point(point1, point2, t)
/// @desc 获得某直线上某点的坐标
/// @arg point1[x_y]
/// @arg point2[x_y]
/// @arg t
function line_get_point(point1, point2, t) {
	var rtn_point = [0, 0];
	rtn_point[0] = point1[0] * (1 - t) + point2[0] * t;
	rtn_point[1] = point1[1] * (1 - t) + point2[1] * t;
	return rtn_point;
}
/// @desc 根据两点获得[A,B,C]，Ax+By+C=0
/// @arg point1[x_y]
/// @arg point2[x_y]
function line_get_abc_from_2point(point1, point2){
	var x1=point1[0], y1=point1[1],
		x2=point2[0], y2=point2[1],
		A=undefined, B=undefined, C=undefined;
	A = y2-y1;
	B = x2-x1;
	C = x2*y1-x1*y2;
	return [A, B, C];
}
/// @desc 根据极坐标获得[A,B,C]，Ax+By+C=0
/// @arg polar[x_y_dir]
function line_get_from_polar(polar){
	var x1=polar[0], y1=polar[1], dir=polar[2],
		A=undefined, B=undefined, C=undefined;
	//竖线
	if(dir mod 360 == 90) {
		A=1;
		B=0;
		C=-x1;
	} else {
		var k=tan(degtorad(-dir)),
			b=y1-k*x1;
		A=k;
		B=-1;
		C=b;
	}
	return [A, B, C];
}
/// @desc 根据y获得x
/// @arg line[A_B_C]
/// @arg y
function line_get_x(line, yy) {
	var a=line[0], b=line[1], c=line[2], xx;
	xx = -(b*yy+c)/a;
	return xx;
}
/// @desc 根据x获得y
/// @arg line[A_B_C]
/// @arg x
function line_get_y(line, xx) {
	var a=line[0], b=line[1], c=line[2], yy;
	yy = -(a*xx+c)/b;
	return xx;
}
/// @desc 沿方向获得极坐标位移长度后的坐标
/// @arg polar[x_y_dir]
/// @arg len
function polar_shift_point(polar, len) {
	var x1=polar[0], y1=polar[1], dir=polar[2],
		x2, y2;
	x2 = x1+lengthdir_x(len, dir);
	y2 = y1+lengthdir_y(len, dir);
	return [x2, y2];
}
/// @desc 返回两条线的交点
/// @arg line1[A_B_C]
/// @arg line2[A_B_C]
function lines_get_cross_point(line1, line2){
	var a1=line1[0], b1=line1[1], c1=line1[2],
		a2=line2[0], b2=line2[1], c2=line2[2];
	//如果同斜率
	if((b1==0 && b2==0) || (a1/b1==a2/b2)) {
		return undefined;
	} 
	var cx=(b1*c2-b2*c1)/(a1*b2-a2*b1),
		cy=(a2*c1-a1*c2)/(a1*b2-a2*b1);
	return [cx, cy];
}
/// @desc 返回经过圆心的直线与圆的交点
/// @arg line[A_B_C]
/// @arg circle[x_y_rad]
function line_get_cross_circle(line, circle) {
	var a=line[0], b=line[1], c=line[2], 
		cx=circle[0], cy=circle[1], rad=circle[2];
	var crosspoint1, crosspoint2;
	if(b==0) {
		crosspoint1[0] = cx;
		crosspoint2[0] = cy-rad;
		crosspoint1[1] = cx;
		crosspoint2[1] = cy+rad;
	} else {
		var k = -a/b;
		crosspoint1[0] = cx+rad/sqrt(1+sqr(k));
		crosspoint2[0] = cy+rad/sqrt(1+sqr(1/k));
		crosspoint1[1] = cx-rad/sqrt(1+sqr(k));
		crosspoint2[1] = cy-rad/sqrt(1+sqr(1/k));
	}
	return [crosspoint1, crosspoint2];
}
/// @desc 传入所有定位点和曲线位置，获得贝塞尔曲线坐标
/// @arg points[point[x_y]]
/// @arg t
function line_get_bezier_point(points, t) {
	var now_ptns = points,
		rtn_point = [0, 0];
	//使用迭代方法，不停减少点的个数
	//只剩下一个点时，贝塞尔曲线就求出来了
	while(array_length(now_ptns)>1) {
		var len = array_length(now_ptns),
			next_ptns = array_create(len-1, [0, 0]);
		//每两个点组成一个直线，获取此直线的位置点，最终位置点数量会比上一次减一
		for(var i=0;i<len-1;i++){
			next_ptns[i] = line_get_point(now_ptns[i], now_ptns[i+1], t);
		}
		now_ptns = next_ptns;
	}
	rtn_point = now_ptns[0];
	return rtn_point;
}
#endregion
#region 运算符
/// @desc 判断某值是否在某集合内
/// @arg val 判断值
/// @arg x1 可选值1/数组
/// @arg x2 可选值2
/// @arg ... 其他可选值
function in() {
	var val=argument[0];
	if(is_array(argument[1]) 
	&& argument_count==2) {
		var array=argument[1];
		for(var i=0;i<array_length(array);i++)
			if(val==array[i]) return true;
	}
	else{
		for(var i=1;i<argument_count;i++)
			if(val==argument[i]) return true;
	}
	return false;
}
/// @arg value
function sign_no0(value) {
	if value=0 return 1
	else return sign(value)
}
/// @arg x
/// @arg xL
/// @arg closeL
/// @arg xR
/// @arg closeR
function between(X, XL, closeL, XR, closeR) {
	var leftOK=false,
		rightOK=false;

	if((closeL && X>=XL)
	|| X>XL)
		leftOK=true;

	if((closeR && X<=XR)
	|| X<XR)
		rightOK=true;

	if(leftOK && rightOK) return true;
	else return false;
}
/// @function sigma_var(n,power)
/// @arg n
/// @arg power
function sigma_var(n, pw) {
	var sum=0;
	for(var i=1;i<=n;i++)
		sum+=power(i,pw)
	return sum
}

#endregion
