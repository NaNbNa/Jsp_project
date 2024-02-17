<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改信息</title>
</head>
<body>
<table  style="width:100%;">  
  <tr>  
    <td align="center"><h3>当前信息</h3></td>  
  </tr>  
</table>
<table style="width:100%; border: 1px solid red; background-color: #f0f0f0; ">
<tr><th>测站名称</th><th>测站编码</th><th>测站类型</th><th>测站所属单位</th><th>河流</th><th>地址</th><th>经度</th><th>纬度</th><th>建站年月</th></tr>
<%
					//连接数据库
try{
	request.setCharacterEncoding("utf-8");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/三峡","root","password");
	Statement stmt=con.createStatement();
	String Sname=request.getParameter("Sname");
	String Scode=request.getParameter("Scode");
	
				//查询需要编辑的信息
	Statement stmt1=con.createStatement();
	ResultSet rs=stmt1.executeQuery("select * from StationInfo where Scode="+ Scode);
	rs.next();
	String str1=rs.getString(3);
	String str2=rs.getString(4);
	String str3=rs.getString(5);
    String str4=rs.getString(6);
    String value7 = rs.getString(7); 
  
    		
    ResultSet rs1=stmt.executeQuery("select * from StationType where TypeID="+ str1);
    rs1.next();
    String value1 = rs1.getString(2);  
    rs1.close();
    
    ResultSet rs2=stmt.executeQuery("select * from Department where DepartmentID="+ str4);
    rs2.next();
    String value2 = rs2.getString(2); 
    rs2.close();
    
    ResultSet rs3=stmt.executeQuery("select * from River where RiverID="+ str2);
    rs3.next();
    String value3 = rs3.getString(2);  
    rs3.close();
    
    ResultSet rs4=stmt.executeQuery("select * from location where LocationID="+ str3);
    rs4.next();
    String value4 = rs4.getString(2);  
    String value5 = rs4.getString(3);  
    String value6 = rs4.getString(4); 
	rs4.close();

	
    if (value1 == null || value1.isEmpty()) {  
        value1 = "null"; // 设置默认值为"null"  
    }  
    if (value2 == null || value2.isEmpty()) {  
        value2 = "null"; // 设置默认值为"null"   
    }  
    if (value3 == null || value3.isEmpty()) {  
        value3 = "null"; // 设置默认值为"null"  
    }  
    if (value4 == null || value4.isEmpty()) {  
        value4 =  "null"; // 设置默认值为"null"  
    }  
    if (value5 == null || value5.isEmpty()) {  
        value5 = "null"; // 设置默认值为"null"  
    }  
    if (value6 == null || value6.isEmpty()) {  
        value6 = "null"; // 设置默认值为"null"   
    }  
    if (value7 == null || value7.isEmpty()) {  
        value7 = "null"; // 设置默认值为"null"  
    }  
    out.println("<tr style='text-align:center;'><td>" + Sname + "</td><td>" + Scode + "</td><td>"
				+ value1 + "</td><td>" + value2 + "</td><td>" + value3 + "</td><td>"
    			+ value4 + "</td><td>" + value5 + "</td><td>" + value6 + "</td><td>" + value7 + "</td></tr>");
    			// 查询所要编辑的信息--------结束
%>
</table>
<form action="update.jsp" method="post">
<table  style="width:100%;">  
  <tr>  
    <td align="center"><h3>修改信息</h3></td>  
  </tr>  
</table>
<table style="width:100%; border: 1px solid red; background-color: #f0f0f0; ">
<tr style=" text-align: center;" >
<th>测站名称:</th>
<td><input name="Sname" type="text" value="<%=Sname%>"></td>
</tr>
<tr style=" text-align: center;" >
<th>测站编码:</th>
<td><input name="Scode" type="text" value="<%=Scode%>" readonly="readonly"></td>
</tr>
<tr style=" text-align: center;" >
<th>测站类型</th>
<td><input name="Stype" type="text" value="<%=value1%>"></td>
</tr>
<tr style=" text-align: center;">
<th>测站所属单位</th>
<td><input name="Department" type="text" value="<%=value2%>"></td>
</tr>
<tr style=" text-align: center;">
<th>河流</th>
<td><input name="River" type="text" value="<%=value3%>"></td>
</tr >
<tr style=" text-align: center;">
<th>地址</th>
<td><input name="address" type="text" value="<%=value4%>"></td>
</tr >
<tr style=" text-align: center;">
<th>经度</th>
<td><input name="el" type="number" value="<%=value5%>"></td>
</tr >
<tr style=" text-align: center;">
<th>纬度</th>
<td><input name="nl" type="number" value="<%=value6%>"></td>
</tr >
<tr style=" text-align: center;">
<th >建站年月</th>
<td><input name="Time" type="Date" value="<%=value7%>"></td>
</tr>
<tr>
	<th colspan="2">
	<input type="submit"style="display: inline-block; padding: 10px 20px; 
	color: red;  cursor: pointer;" value="修改">
	<input type="reset" style="display: inline-block; padding: 10px 20px; 
	color: red;  cursor: pointer;" value="重置">
	</th>	
</tr>
<tr style=" width:100%;text-align: center;">
<td><a href='index.jsp'>返回首页</a></td></tr>
</table>
</form>
<%
									//该form提交所填写信息转到update.jsp文件处理更新功能
	rs.close();
	con.close();
}catch(Exception e){
	out.println(e);
	out.println("<script>alert('编辑失败,请重试');</script>");
	out.println("<table style=\"width:100%; border: 1px solid red; background-color: #f0f0f0;\">");  
	out.println("<tr style=\" text-align: center;\">");  
	out.println("<th colspan=\"1\"><a href='index.jsp'>返回首页</a></th>");  
	out.println("</tr>");  
	out.println("</table>");
} 
%>
</body>
</html>
