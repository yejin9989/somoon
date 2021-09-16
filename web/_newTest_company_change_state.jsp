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
    String apply_num = request.getParameter("applyNum") + "";
    String state = request.getParameter("state") + "";
    String company_num = request.getParameter("companyNum") + "";
    //String apply_num = "1";
    //String company_num = "2";

    //DB 관련 객체 선언
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
    String sql = "";

    //DB update
    query = "UPDATE ASSIGNED SET State = ? WHERE Apply_num = ? AND Company_num = ?";
    pstmt = conn.prepareStatement(query);
    pstmt.setInt(1, Integer.parseInt(state));
    pstmt.setInt(2, Integer.parseInt(apply_num));
    pstmt.setInt(3, Integer.parseInt(company_num));
    pstmt.executeUpdate();

    //응답시간 설정
    query = "UPDATE ASSIGNED SET Modify_date = NOW() WHERE Apply_num = ? AND Company_num = ? AND Modify_date IS NULL AND Accept_time IS NOT NULL";
    pstmt = conn.prepareStatement(query);
    pstmt.setInt(1, Integer.parseInt(apply_num));
    pstmt.setInt(2, Integer.parseInt(company_num));
    pstmt.executeUpdate();

    //pstmt.close();
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
<%
    if(pstmt != null) {
        pstmt.close();
        //rs.close();
        query = "";
        conn.close();
    }
%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
<script>
    //새 스크립트 작성
    //window.close();
    $(document).ready(function(){
        location.href = document.referrer;
    })
</script>
</body>
</html>