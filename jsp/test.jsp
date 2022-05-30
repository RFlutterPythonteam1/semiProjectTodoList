<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Base64.Decoder"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.*"%>
<%@page import="java.io.File"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>





<%
	request.setCharacterEncoding("utf-8");
	
	String root = pageContext.getServletContext().getRealPath("/");
	String path = root + "pds" + File.separator + "savaData";
	

	out.print(path);
    
    out.print(root);
    out.print("좀 되라");

	File dir = new File(path);
	if(!dir.exists())
		dir.mkdir();
	
	try{
		MultipartRequest req = null;
        req = new MultipartRequest(request, path,100* 1024*1024,"utf-8",new DefaultFileRenamePolicy());		
		File file = req.getFile("upload");
		if(file != null)
			out.print("파일 길이 : " + file.length() + "<br>" );
        out.print("됫다.");
	}catch(Exception e ){
		e.printStackTrace();
		out.print("안됫다.");

	}
	
	
	
	
%>
