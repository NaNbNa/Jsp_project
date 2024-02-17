<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table  style="width:100%; border: 1px solid red; background-color: #f0f0f0; ">
<tr><td>测站编码</td><td>测站名称</td><td>地址</td><td>经度</td><td>纬度</td><td>备注</td></tr>
<%
										//连接数据库,接受参数
try{
	Class.forName("com.mysql.jdbc.Driver");
	//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/三峡","root","password");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/三峡","root","password");
	Statement stmt=con.createStatement();
	String LocationID=request.getParameter("id");
	String Scode=request.getParameter("Scode");
	String Sname=request.getParameter("Sname");
	
										//查询详细地址信息 
	String sql="select L.site, L.el, L.nl, L.nt  "
			+" from location L "
			+" where L.LocationID="+LocationID;
	ResultSet rs=stmt.executeQuery(sql);
	
	while(rs.next()){
		out.println("<tr><td>"+Scode+"</td><td>"+Sname+"</td><td>"
		+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)
		+"</td></tr>");
	}
	rs.close();
	stmt.close();
	con.close();
}catch(Exception e){
	out.println("<tr><td>"+e+"</td></tr>");
}
%>
<tr style=" text-align: center;">
<th colspan="1"><a href='index.jsp'>返回首页</a></th></tr>
</table>
</body>
</html>