<%@ page language="java" import="java.sql.*"   import="java.net.URLEncoder" import=" java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
					//连接数据库,接受参数
					
	request.setCharacterEncoding("utf-8");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/三峡","root","password");
	Statement stmt=con.createStatement();
	String Sname=request.getParameter("Sname");
	String Scode=request.getParameter("Scode");
	String Stype=request.getParameter("Stype");
	String Department=request.getParameter("Department");
	String River=request.getParameter("River");
	String address=request.getParameter("address");
	String el=request.getParameter("el");
	String nl=request.getParameter("nl");
	String BuildTime=request.getParameter("Time");
	
				//四个基表是最基础的表,不能用update更新基表
				//使用insert代替update,当修改后的信息完全不同于已存在的信息时,就插入基表中
				//插入四个基表
	String sql="insert IGNORE into StationType(Station)values('"+Stype+"')";
	String sql1="insert IGNORE into Department(Department)values('"+Department+"')";
	String sql2="insert IGNORE into River(River)values('"+River+"')";
	String sql3="insert IGNORE into location(site,el,nl)values('"+address+"','"+el+"','"+nl+"')";
	int a=stmt.executeUpdate(sql);
	int a1=stmt.executeUpdate(sql1);
	int a2=stmt.executeUpdate(sql2);
	int a3=stmt.executeUpdate(sql3);
		
				//查询各个ID值
	String sql4 = "SELECT T.TypeID, D.DepartmentID, R.RiverID, L.LocationID "  
            + "FROM Department D, River R, StationType T, location L "  
            + "WHERE T.Station = ? AND R.River = ? AND D.Department = ? AND L.site = ? AND L.el= ? AND L.nl= ?";  
	PreparedStatement stmt1 = con.prepareStatement(sql4);  
	stmt1.setString(1, Stype); // 设置第一个参数  
	stmt1.setString(2, River); // 设置第二个参数  
	stmt1.setString(3, Department); // 设置第三个参数  
	stmt1.setString(4, address); // 设置第四个参数  
	stmt1.setString(5, el); // 设置第5个参数  
	stmt1.setString(6, nl); // 设置第6个参数 
	ResultSet rs = stmt1.executeQuery();
	rs.next();
	String str1=rs.getString(1);
	String str2=rs.getString(2);
	String str3=rs.getString(3);
    String str4=rs.getString(4);
    
    			// 更新StationInfo表
    			
    String sql5 = "update StationInfo set Sname=?, BuildTime=?, TypeID=?, DepartmentID=?, RiverID=?, LocationID=? where Scode=?";  
    PreparedStatement pstmt = con.prepareStatement(sql5);  
    pstmt.setString(1, Sname);  
    pstmt.setString(2, BuildTime);  
    pstmt.setString(3, str1);  
    pstmt.setString(4, str2);  
    pstmt.setString(5, str3);  
    pstmt.setString(6, str4);  
    pstmt.setString(7, Scode);  
    int a4 = pstmt.executeUpdate();
    rs.close();
	stmt.close();
	con.close();
	if(a4==1&&(a==1||a1==1||a2==1||a3==1)){
		out.print("<script>alert('修改成功');</script>");
		String refreshHeaderValue = "1; url=edit.jsp?Scode=" + Scode + "&Sname=" + URLEncoder.encode(Sname, "UTF-8");  
		response.setHeader("Refresh", refreshHeaderValue);
	}else{
		out.print("<script>alert('修改失败');</script>");
		String refreshHeaderValue = "1; url=edit.jsp?Scode=" + Scode + "&Sname=" + URLEncoder.encode(Sname, "UTF-8");  
		response.setHeader("Refresh", refreshHeaderValue);
	}
%>
</body>
</html>
