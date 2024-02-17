<%@ page language="java" import="java.sql.*" import="java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>删除测站</title>
</head>
<body>
				
<%	
				//连接数据库
	request.setCharacterEncoding("utf-8");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/三峡","root","password");
	Statement stmt=con.createStatement();
	String Scode=request.getParameter("Scode");
    
				//仅仅删除 StationInfo的数据,不删除其他四个基表
	int i=stmt.executeUpdate("delete from StationInfo where Scode="+Scode);
	
	if(i==1){
		out.print("<script>alert('删除成功！');</script>");
		response.setHeader("refresh","1;url=index.jsp");
	}else{
		out.print("<script>alert('删除失败，单击确定后返回首页')</script>");
		response.setHeader("refresh","1;url=index.jsp");
	}
	stmt.close();
	con.close();
%>
</body>
</html>
