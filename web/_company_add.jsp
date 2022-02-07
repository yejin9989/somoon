<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    //필요한 변수 선언
    int i, j;
    String mylog = "";

    //파라미터 가져오기
    //String param = request.getParameter("param");

    //DB 관련 객체 선언
    Connection conn = DBUtil.getMySQLConnection();
    PreparedStatement pstmt = null;
    String sql = "";

    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String introduction = request.getParameter("introduction");
    String state = "1";
    String phone = request.getParameter("phone");
    String profile_img = "https://somoonhouse.com/sources/anonymous.jpg";
    String pw = request.getParameter("pw");

    //DB 가져오기 예시
    sql = "insert into COMPANY (Name, Address, Introduction, State, Phone, Profile_img, Pw) values " +
            "(?, ?, ?, ?, ?, ?, password(?))";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, name);
    pstmt.setString(2, address);
    pstmt.setString(3, introduction);
    pstmt.setString(4, state);
    pstmt.setString(5, phone);
    pstmt.setString(6, profile_img);
    pstmt.setString(7,pw);
    pstmt.executeUpdate();
    pstmt.close();

%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newindex.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
<%=mylog%>
<%
    if(pstmt != null) {
        pstmt.close();
        sql = "";
        conn.close();
    }
%>



<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    //새 스크립트 작성
    //window.close();
    $("document").ready(function(){
        history.back();
    })
</script>
</body>
</html>