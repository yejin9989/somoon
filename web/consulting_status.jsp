<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "consulting_status.jsp"); %>
<%
    //DB에 사용 할 객체들 정의
    Connection conn = DBUtil.getMySQLConnection();
    PreparedStatement pstmt = null;
    Statement stmt = null;
    String query = "";
    String sql = "";
    ResultSet rs = null;

//세션 생성 create session
    session.setAttribute("page", "consulting_status.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
    String now = session.getAttribute("page")+""; // 현재 페이지 current page
    String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
    String name = session.getAttribute("name")+"";

    query = "SELECT a.Company_num company_id, c.Name name, c.Phone phone, COUNT(*) cnt FROM ASSIGNED a, COMPANY c WHERE a.Company_num = c.Id AND a.State = 0 AND c.State = 1 GROUP BY a.Company_num;";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
%>
<%
    LinkedList<MsgCompany> company_list = new LinkedList<MsgCompany>();

    while(rs.next()){ //BL : Business License

        String company_id = rs.getString("company_id");
        String company_name = rs.getString("name");
        String phone = rs.getString("phone");
        String cnt = rs.getString("cnt");

        MsgCompany temp_company = new MsgCompany(company_id, company_name, phone, cnt);

        company_list.add(temp_company);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
<%--    <script>--%>
<%--        window.dataLayer = window.dataLayer || [];--%>
<%--        function gtag(){dataLayer.push(arguments);}--%>
<%--        gtag('js', new Date());--%>

<%--        gtag('config', 'G-PC15JG6KGN');--%>
<%--    </script>--%>
    <link rel="SHORTCUT ICON" href="img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
    <link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick-theme.css"/>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/company_home.css">
    <link rel="stylesheet" type="text/css" href="css/license_check.css">
    <style type="text/css">

    </style>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
<div id="container" style="overflow: scroll">
    <h2>📋 업체별 상담 현황</h2>
    <div id="btn_area" style="margin-top: 30px;">
<%--        <form id="form" method="post" enctype="multipart/form-data" action="_send_cs_msg.jsp">--%>
<%--            <%--%>
<%--                request.setAttribute("company_list", company_list);--%>
<%--            %>--%>
<%--&lt;%&ndash;            <input type="submit" class="submitBtn" id="sendMsg" value="문자 일괄 전송" />&ndash;%&gt;--%>
<%--        </form>--%>
    </div>
    <table>
        <thead>
        <tr>
            <td>회사</td>
            <td>미상담 건수</td>
            <td>문자 전송</td>
        </tr>
        </thead>
        <tbody>
        <%
            for(MsgCompany com : company_list){
        %>
        <tr class="company-list" id="com<%=com.getCompanyId()%>">
            <td><%=com.getName()%><br><%=com.getPhone()%></td>
            <td><%=com.getCnt()%></td>
            <td><input type="button" class="sendMsg" id="sendMsg" value="보내기" onclick="alertMsgDone('<%=com.getName()%>', '<%=com.getPhone()%>', '<%=com.getCnt()%>');"/></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
<%
    //DB개체 정리
    pstmt.close();
    rs.close();
    query="";
    conn.close();
%>
<script>
    // $(".company-list").click(function(){
    //     var div_id = $(this).attr('id');
    //     var company_id = div_id.replace("com", "");
    //     alertMsgDone()
    // })
    function alertMsgDone(name, phone, cnt) {
        window.open("_send_cs_msg.jsp?name="+name+"&phone="+phone+"&cnt="+cnt,"pop","width=400,height=200");
    }
</script>
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
    if(!wcs_add) var wcs_add = {};
    wcs_add["wa"] = "3602e31fd32c7e";
    wcs_do();
</script>
<script type="text/javascript" src="slick-1.8.1/slick/slick.min.js"></script>
</body>
</html>