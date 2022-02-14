<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    //필요한 변수 선언
    int i, j;
    String mylog = "";
    //파라미터 가져오기
    String reason_id = request.getParameter("reason_id");
    String stop_reason = request.getParameter("stop_reason");

    if (reason_id.equals("1")) {
        stop_reason = "신청 과정이 너무 번거로움";
    } else if (reason_id.equals("2")) {
        stop_reason = "아직 구체적인 계획이 없음";
    }

    //DB 관련 객체 선언
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String sql = "";
    //DB insert
    sql = "INSERT INTO apply_stop_reason (reason_id, stop_reason) values (?, ?)";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, reason_id);
    pstmt.setString(2, stop_reason);
    pstmt.executeUpdate();
    pstmt.close();
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newindex.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
    <title>소문난집</title>
</head>
<body>
<%=mylog%>
<%
    if (pstmt != null) {
        pstmt.close();
        sql = "";
        conn.close();
    }
%>
<script>
    alert('더 나은 서비스로 찾아뵙겠습니다. 감사합니다.');
    location.href = "homepage.jsp";
</script>


<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    //새 스크립트 작성
    //window.close();
</script>
</body>
</html>