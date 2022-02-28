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
    //String param = request.getParameter("param");
    String company = request.getParameter("companySelect") + "";
    String[] ability = request.getParameterValues("abilitySelect");

    //DB 관련 객체 선언
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
    String sql = "";

    //DB update

    query = "DELETE FROM SPECIALIZED WHERE Company_num = ?";
    pstmt = conn.prepareStatement(query);
    pstmt.setString(1,company);
    pstmt.executeUpdate();

    if(ability != null){
        for(String abil : ability){
            query = "INSERT INTO SPECIALIZED(company_num, ability_num) VALUES (?, ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, company);
            pstmt.setString(2,abil);
            pstmt.executeUpdate();
        }
    }



    pstmt.close();
%>
<html>
<head>
    <title>_add_badge(data_insert)</title>
</head>
<body>
<script>
    alert('반영 완료 되었습니다.');
    history.back();
</script>
</body>
</html>
