<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>首页</title>
</head>
<body>

<table  style="width:100%;">  
  <tr>  
    <td align="center"><h1>三峡水库测站信息</h1></td>  
  </tr>  
</table>
<form action="result.jsp" method="post">
<table  style="width:100%; border: 1px solid red; background-color: #f0f0f0; ">
<tr><th colspan="2">
<input type="text" style="display: inline-block; padding: 10px 20px; 
	color: black;  cursor: pointer;" name="Scode" placeholder="请输入测站编码">
	<input type="text" style="display: inline-block; padding: 10px 20px; 
	color: black;  cursor: pointer;" name="Sname" placeholder="请输入测站名">
	<input type="text" style="display: inline-block; padding: 10px 20px; 
	color: black;  cursor: pointer;" name="Stype" placeholder="请输入测站类型">
	<input type="text" style="display: inline-block; padding: 10px 20px; 
	color: black;  cursor: pointer;" name="Department" placeholder="请输入所属单位">
	<input type="text" style="display: inline-block; padding: 10px 20px; 
	color: black;  cursor: pointer;" name="River" placeholder="请输入测站所测河流">
	<input type="Date" style="display: inline-block; padding: 10px 20px; 
	color: black;  cursor: pointer;" name="Time" placeholder="请输入建站时间">
<tr>
	<th colspan="2">
	<button type="submit" style="display: inline-block; padding: 10px 20px; 
	color: red;  cursor: pointer;">查找测站</button>
	</th>	
</tr>
</table>	
</form>
<form action="add.jsp" method="post">
<table  style="width:100%; border: 1px solid black; background-color: #f0f0f0; ">
<tr>
	<th colspan="2">
	<input type="submit" style="display: inline-block; padding: 10px 20px; 
	color: red;  cursor: pointer;" value="增加测站">
	</th>	
</tr>
</table>	
</form>

<table  style="width:100%; border: 1px solid red; background-color: #f0f0f0; ">
<tr><td>测站编码</td><td>测站名称</td><td>测站类型</td><td>测站所属单位</td><td>河流</td><td>建站时间</td><td>操作</td></tr>
<%
				//连接数据库
try{
	Class.forName("com.mysql.jdbc.Driver");
	//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/三峡","root","password");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/三峡","root","password");
	Statement stmt=con.createStatement();
	
				//执行查询语句,展示首页
	String sql="select S.Scode, S.Sname, T.Station, D.Department, R.River,S.BuildTime,S.LocationID  "
			+" from StationInfo S, Department D, River R, StationType T "
			+" where S.TypeID = T.TypeID AND S.RiverID = R.RiverID AND S.DepartmentID = D.DepartmentID ";
	ResultSet rs=stmt.executeQuery(sql);
	while(rs.next()){
		String Scode=rs.getString(1);
		String Sname=rs.getString(2);
		String LocationID = rs.getString(7);
		out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"
		+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)
		+"</td><td><a href='detail.jsp?id="+rs.getString(7)+"&Sname="+Sname+"&Scode="+Scode+"'>详细地址信息</a>&nbsp;<a href='edit.jsp?Scode="
		+Scode+"&Sname="+Sname+"'>修改</a>&nbsp;<a href='delete.jsp?Scode="+Scode+"'>删除</a></td></tr>");
	}
	rs.close();
	stmt.close();
	con.close();
}catch(Exception e){
	out.println("<tr><td>"+e+"</td></tr>");
}
%>
</table>


</body>
</html>
