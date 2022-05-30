<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

request.setCharacterEncoding("utf-8");
String u_id = request.getParameter("u_id");
String category = request.getParameter("category");
String t_content = request.getParameter("t_content");

String url_mysql = "jdbc:mysql://localhost/semitodo?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
String id_mysql = "root";
String pw_mysql = "qwer1234";

PreparedStatement ps = null;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
    Statement stmt_mysql = conn_mysql.createStatement();

    String act1 = "insert into todolist (u_id, category, t_content";
    String act2 = ") values (?,?,?)";

    ps = conn_mysql.prepareStatement(act1+act2);
    ps.setString(1, u_id);
    ps.setString(2, category);
    ps.setString(3, t_content );
 
    ps.executeUpdate();
    conn_mysql.close();
%>
    {"result":"OK"}
<%
} catch(Exception e){
%>
    {"result":"ERROR"}
<%
}
%>
