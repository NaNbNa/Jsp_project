<%@ page language="java" import="java.net.URLEncoder" import="java.util.*" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加书籍</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8");%>
<table  style="width:100%;">  
  <tr>  
    <td align="center"><h3>添加测站信息</h3></td>  
  </tr>  
</table>
<form action="add.jsp" method="post">
<div style="text-align:center;">  
<table style="width:100%; border: 1px solid red; background-color: #f0f0f0; ">
<tr style=" text-align: center;">
<th>测站编码：</th>
<td><input name="Scode" type="text" required="required"></td>
</tr>
<tr style=" text-align: center;">
<th>测站名称：</th>
<td><input name="Sname" type="text"></td>
</tr>
<tr style=" text-align: center;">
<th>测站类型：</th>
<td><input name="Stype" type="text"></td>
</tr>
<tr style=" text-align: center;">
<th>测站所属单位：</th>
<td><input name="Department" type="text"></td>
</tr>
<tr style=" text-align: center;">
<th>河流：</th>
<td><input name="River" type="text"></td>
</tr>
<tr style=" text-align: center;">
</tr>
<tr style=" text-align: center;">
<th>地址：</th>
<td><input name="address" type="text"></td>
</tr>
<tr style=" text-align: center;">
<th>经度：</th>
<td><input name="el" type="number"></td>
</tr>
<tr style=" text-align: center;">
<th>纬度：</th>
<td><input name="nl" type="number"></td>
</tr>
<tr style=" text-align: center;">
<th>建站年月：</th>
<td><input name="Time" type="Date"></td>
</tr>
<tr style=" text-align: center;">
<th colspan="2">
	<input type="submit" type="submit"style="display: inline-block; padding: 10px 20px; 
	color: red;  cursor: pointer;" name="submit" value="添加">
	<input type="reset" type="submit"style="display: inline-block; padding: 10px 20px; 
	color: red;  cursor: pointer;" value="重置">
</th>
</tr>
<tr style=" text-align: center;">
<th colspan="1"><a href='index.jsp'>返回首页</a></th></tr>
</table>
</div>
</form>
<%
					//接受 添加的信息的参数
String submit=request.getParameter("submit");
if(!"".equals(submit)&&submit!=null){
	String Sname=request.getParameter("Sname");
	String Scode=request.getParameter("Scode");
	String Stype=request.getParameter("Stype");
	String Department=request.getParameter("Department");
	String River=request.getParameter("River");
	String address=request.getParameter("address");
	float el=Float.parseFloat(request.getParameter("el"));
	float nl=Float.parseFloat(request.getParameter("nl"));
	String BuildTime=request.getParameter("Time");
	
				//连接数据库,执行插入四个基表语句
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/三峡","root","password");
		Statement stmt=con.createStatement();
		String sql="insert IGNORE into StationType(Station)values('"+Stype+"')";
		String sql1="insert IGNORE into Department(Department)values('"+Department+"')";
		String sql2="insert IGNORE into River(River)values('"+River+"')";
		String sql3="insert IGNORE into location(site,el,nl)values('"+address+"','"+el+"','"+nl+"')";
		int a=stmt.executeUpdate(sql);
		int a1=stmt.executeUpdate(sql1);
		int a2=stmt.executeUpdate(sql2);
		int a3=stmt.executeUpdate(sql3);
		
				//执行插入StationInfo语句
		String sql4 = "SELECT T.TypeID, D.DepartmentID, R.RiverID, L.LocationID "  
		            + "FROM Department D, River R, StationType T, location L "  
		            + "WHERE T.Station = ? AND R.River = ? AND D.Department = ? AND L.site = ? AND L.el = ? AND L.nl = ?";  
		PreparedStatement pstmt = con.prepareStatement(sql4);  
		pstmt.setString(1, Stype);  
		pstmt.setString(2, River);  
		pstmt.setString(3, Department);  
		pstmt.setString(4, address);  
		pstmt.setDouble(5, el);  
		pstmt.setDouble(6, nl);
		ResultSet rs = pstmt.executeQuery();  // 直接调用，不需要传递SQL查询字符串  
		rs.next();
		
		String sql5="insert IGNORE into StationInfo(Scode,Sname,TypeID,RiverID,LocationID,DepartmentID,BuildTime)values('"
		+Scode+"','"+Sname+"','"+rs.getString(1)+"','"+rs.getString(3)+"','"+rs.getString(4)+"','"+rs.getString(2)+"','"+BuildTime+"')";
		int j=stmt.executeUpdate(sql5);
		if((a==1||a1==1||a2==1||a3==1)||j==1){
			out.print("<script>alert('添加成功，单击确定返回主页面！');</script>");
			response.setHeader("refresh", "1;url=index.jsp");
		}else{
			out.println("<script>alert('添加失败，单击确定返回');</script>");
			
								//失败返回时, 不清空已填写信息
			//避免URLEncoder.encode的参数为空
			String encodedDepartment ="";
			if (Department != null) 
			    encodedDepartment = URLEncoder.encode(Department, "UTF-8"); 
			String encodedSname ="";
			if (Sname != null) 
			    encodedSname = URLEncoder.encode(Sname, "UTF-8"); 
			String encodedRiver="";
			if (River != null) 
			    encodedRiver = URLEncoder.encode(River, "UTF-8"); 
			String encodedaddress="";
			if (address != null) 
			    encodedaddress = URLEncoder.encode(address, "UTF-8"); 
			
			String refreshHeaderValue = "1; url=add.jsp?Scode=" + Scode + "&Sname=" + encodedSname  
	        + "&Stype=" + Stype +"&Department=" + encodedDepartment +"&River="+ encodedRiver +"&address="
			+ encodedaddress+"&el="+el+"&nl="+nl+"&Time="  + BuildTime;  
			response.setHeader("Refresh", refreshHeaderValue);
		}
		con.close();
		stmt.close();
	}catch(Exception e){
		out.println("<script>alert('添加失败,请重试');</script>");
		out.println(e);
		
							//失败返回时, 不清空已填写信息
		//避免URLEncoder.encode的参数为空
				String encodedDepartment ="";
				if (Department != null) 
				    encodedDepartment = URLEncoder.encode(Department, "UTF-8"); 
				String encodedSname ="";
				if (Sname != null) 
				    encodedSname = URLEncoder.encode(Sname, "UTF-8"); 
				String encodedRiver="";
				if (River != null) 
				    encodedRiver = URLEncoder.encode(River, "UTF-8"); 
				String encodedaddress="";
				if (address != null) 
				    encodedaddress = URLEncoder.encode(address, "UTF-8"); 
				
				String refreshHeaderValue = "1; url=add.jsp?Scode=" + Scode + "&Sname=" + encodedSname  
		        + "&Stype=" + Stype +"&Department=" + encodedDepartment +"&River="+ encodedRiver +"&address="
				+ encodedaddress+"&el="+el+"&nl="+nl+"&Time="  + BuildTime;  
				response.setHeader("Refresh", refreshHeaderValue);
			}
	}
%>
</body>
</html>
