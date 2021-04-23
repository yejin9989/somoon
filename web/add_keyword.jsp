<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar,java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page language="java" import="myPackage.DBUtil" %>
<%@ page language="java" import="myPackage.Link" %>
<%@ page language="java" import="myPackage.GetImage" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setCharacterEncoding("UTF-8"); %>
<%String s_id = session.getAttribute("s_id")+""; %>
<!DOCTYPE html>
<html>
<head><meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body>
<div class="upload-popup-header">
    <h3>키워드명 입력</h3>
</div>
<form action="_add_keyword.jsp" method="post">
    <input name="keyword_name" type="text">
    <input type="submit" class="submitBtn" value="키워드추가">
</form>
</body>
</html>