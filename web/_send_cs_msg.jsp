<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar,java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page language="java" %>
<%@ page language="java" %>
<%@ page language="java" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" %>
<%@ page import="myPackage.*" %>
<%@ page import="myPackage.MessageSend3" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="css/etc_license_upload.css">
    <title>소문난집</title>
</head>
</html>

<%
    String name = request.getParameter("name")+"";
    String phone = request.getParameter("phone")+"";
    String cnt = request.getParameter("cnt")+"";
%>
<%
    MessageSend3 msg = new MessageSend3();
	String msg_str = "[소문난집]\n"+name+"님, 현재 미상담 건수가 "+cnt+"건 있습니다. 상담 완료 및 상담 상태 변경 부탁드립니다.";


//    실제 업체에 문자 보내기
//    msg.send(phone, msg_str, "lms");
%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    alert("<%=name%>님께 문자 전송을 완료하였습니다.");
    self.close();
</script>
