<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<% 

Class.forName("oracle.jdbc.OracleDriver");
int[] num = new int[10];
int[] value = new int[10];
try{
Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
String sql ="select * from ardu where sensor_number > (select MAX(sensor_number) from ardu)-7";
PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
int count =0;
while(rs.next()){
	num[count]=rs.getInt(1);
	value[count]=rs.getInt(3);
	count++;
}
%>
{"label":["<%=Integer.toString(num[0]) %>","<%=Integer.toString(num[1]) %>","<%=Integer.toString(num[2]) %>","<%=Integer.toString(num[3]) %>","<%=Integer.toString(num[4]) %>","<%=Integer.toString(num[5]) %>","<%=Integer.toString(num[6]) %>"],
"temp":["<%=Integer.toString(value[0]) %>","<%=Integer.toString(value[1]) %>","<%=Integer.toString(value[2]) %>","<%=Integer.toString(value[3]) %>","<%=Integer.toString(value[4]) %>","<%=Integer.toString(value[5]) %>","<%=Integer.toString(value[6]) %>"]}
<%
}
catch(Exception e){
	e.printStackTrace();
}
%>