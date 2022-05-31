<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

    request.setCharacterEncoding("UTF-8");
    int t_id = Integer.parseInt(request.getParameter("t_id"));
    int t_state =Integer.parseInt(request.getParameter("t_state"));
  


    String url_mysql = "jdbc:mysql://localhost/semitodo?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
    String id_mysql="root";
    String pw_mysql="qwer1234";

    PreparedStatement ps =null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        String query ="update todolist set t_state = ?  where t_id = ?";
        

        ps=conn_mysql.prepareStatement(query);
        ps.setInt(1,t_state);
        ps.setInt(2,t_id);


        ps.executeUpdate();
        conn_mysql.close();
%>
       {"result":"OK"}
<%
    }catch(Exception e){
        %>
        {"result":"ERROR"}
<%
    }
%>