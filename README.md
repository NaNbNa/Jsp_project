<div align="center">
  
# (Java)基于tomcat和navicat的简单jsp数据库项目
  
## 三峡水库测站信息  
</div>


项目文件和代码统计:  
![屏幕截图 2024-02-17 203936](https://github.com/NaNbNa/Jsp_project/assets/144761706/947d28e0-c1b9-4e32-b32a-8daf537b0035)  
---------------------------------------------------------------------------------------------------------------------------------  
项目实现详情(已做数据处理):     
### 一.数据库实现  
#### 1.1 数据库结构和sql说明:  
1. 一共建立5个表,除了StationInfo四个表之间相互独立无依赖关系,StationInfo表包含其余四个表的所有主键,即自身的外键.  
2. 相互独立的四个表的主键是自增列,满足自增规则.StationInfo表的主键是测站编码Scode,非自增属性,需人为按照规则插入.  
3. StationInfo表的外键选择的约束是not delete null 和not update null,允许外键置空.不使用级联和禁止这两种方式约束外键.  
4. 增查改操作基于四个基表(排除StationInfo)进行操作.删除操作基于Station表进行操作.系统的页面结构通过sql选择语句和视图final共同展示.
#### 1.2 数据库技术实现和功能
1. 环境:tomcat8.5 +eclipse(23年12月最新版), mysql +navicat两个组合.编写jsp文件打造系统.  
连接数据库:  
//jdbc连接工具声明  
Class.forName("com.mysql.jdbc.Driver");  
//连接开始  
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/三峡","root","password");  
2. 前后端的数据交换方法:使用form结构,例如:  
<form action="result.jsp" method="post">...</form>  
3. 数据库系统功能介绍:  
增:点击 “增加测站” 按钮,填写信息即可添加.  
删:直接点击删除键(无第二次确认)即可删除.  
查:一共有6种查询框,填写其一即可(填写多个查询框,查询条件是彼此独立的,所查询的结果会结合在一起展示).  
改:点击 “修改” 按钮,填写所需修改的信息的信息即可查询.   

-------------------------------------------------------------------------------------------------------------  
### 二.jsp文件层次展示  
![WPS图片(1)](https://github.com/NaNbNa/Jsp_project/assets/144761706/842ae701-5e53-40d9-a433-4d83a8652d5c)  

### 三.数据库效果展示
![WPS图片(2)](https://github.com/NaNbNa/Jsp_project/assets/144761706/2429ae4c-1671-4f41-9915-898d5cac11a0)  
![WPS图片(1)](https://github.com/NaNbNa/Jsp_project/assets/144761706/7217e9d8-c64f-410e-9cad-e0dd584963ad)  










