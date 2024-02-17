<%@ page language="java" import="java.util.*" import="java.util.Timer, java.util.TimerTask"  import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查找结果</title>
</head>
<body>
<table  style="width:100%;">  
  <tr>  
    <td align="center"><h2>查找结果</h2></td>  
  </tr>  
</table>
<table style="width:100%; border: 1px solid red; background-color: #f0f0f0; " >
<tr style=" text-align: center;">
<th colspan="1"><a href='index.jsp'>返回首页</a></th></tr>
<tr><td>测站编码</td><td>测站名称</td><td>测站类型</td><td>测站所属单位</td><td>河流</td><td>建站时间</td><td>操作</td></tr>
<%
								//连接数据库
request.setCharacterEncoding("utf-8");
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/三峡","root","password");
Statement stmt=con.createStatement();
Statement stmt1=con.createStatement();
								//获取6个查询条件
String Sname=request.getParameter("Sname");
String Scode=request.getParameter("Scode");
String Stype=request.getParameter("Stype");
String Department=request.getParameter("Department");
String River=request.getParameter("River");
String BuildTime=request.getParameter("Time");
StringBuilder sql = new StringBuilder(); 
StringBuilder sql1 = new StringBuilder(); 
									//根据所填写查询的条件,编写查询语句(比较复杂)
									// sql1是为了得到LocationID,为超链接“详细地址信息”提供ID
sql.append("SELECT * FROM final WHERE "); 
sql1.append("SELECT LocationID FROM StationInfo S WHERE S.Scode IN(select Scode FROM final WHERE "); 
int i = 0;
if (Scode != null && Scode != "") {  
	i = i + 1;
    sql.append("Scode = '").append(Scode).append("'"); 
    sql1.append("Scode = '").append(Scode).append("'"); 
}  
if (Sname != null && Sname != "") {  
	if(i>0){
		sql.append(" OR ");
		sql1.append(" OR ");
	}
	sql.append("Sname = '").append(Sname).append("'"); 
	sql1.append("Sname = '").append(Sname).append("'"); 
    i = i + 1;
}  
if (Stype != null && Stype != "") {  
	if(i>0){
		sql.append(" OR ");
		sql1.append(" OR ");
	}
	sql.append("Station = '").append(Stype).append("'"); 
	sql1.append("Station = '").append(Stype).append("'"); 
	i = i + 1;
}  
if (Department != null && Department != "") { 
	if(i>0){
		sql.append(" OR ");
		sql1.append(" OR ");
	}
	sql.append("Department = '").append(Department).append("'"); 
	sql1.append("Department = '").append(Department).append("'"); 
    i = i + 1;
}  
if (River != null && River != "") {
	if(i>0){
		sql.append(" OR ");
		sql1.append(" OR ");
	}
	sql.append("River = '").append(River).append("'");
	sql1.append("River = '").append(River).append("'");
    i = i + 1;
}  
if (BuildTime != null && BuildTime !="") { 
	if(i>0){
		sql.append(" OR ");
		sql1.append(" OR ");
	}
	sql.append("BuildTime >= '").append(BuildTime).append("'"); 
	sql1.append("BuildTime >= '").append(BuildTime).append("'"); 
}
// sql内嵌结束
sql1.append(")");
						//查询语句到此编写完成
						//执行查询语句,展示结果
try{
ResultSet rs1=stmt1.executeQuery(sql1.toString());
ResultSet rs=stmt.executeQuery(sql.toString());
int flag=0;
while(rs.next()){
	//默认地址id不存在
	String str1 = "";
	if (rs1.next())
		str1 = rs1.getString(1);
	
	flag=1;
	out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"
	+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)
	+"</td><td><a href='detail.jsp?id="+str1+"&Sname="+rs.getString(2)+"&Scode="+rs.getString(1)+"'>详细地址信息</a>&nbsp;<a href='edit.jsp?Scode="
	+rs.getString(1)+"&Sname="+rs.getString(2)+"'>修改</a>&nbsp;<a href='delete.jsp?Scode="+rs.getString(1)+"'>删除</a></td></tr>");
}
if(flag==1){
	out.println("<script>alert('查找完成！');</script>");
}else{
	out.println("<script>alert('没有找到！');</script>");
	response.setHeader("refresh","1;url=index.jsp");
}
rs.close();
stmt.close();
con.close();
}catch (Exception e){
	out.println("<script>alert('请输入信息！');</script>");
}
%>

</table>
</body>
</html>

