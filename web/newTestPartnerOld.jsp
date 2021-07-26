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
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
    String sql = "";

    //DB 가져오기 예시
    /*query = "select * from KEYWORD";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    HashMap<String, String> keyword = new HashMap<String, String>();
    while(rs.next()) {
        keyword.put(rs.getString("Id"), rs.getString("Name"));
    }
    pstmt.close();
     */
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newTestPartnerOld.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
<%=mylog%>
<%
%>
<div class="body_container">
    <jsp:include page="/newTestHeader.jsp" flush="false" />
    <div class="body_main">
        <div class="main_header">
            <span>제이와이피엔터님</span>
        </div>
        <div class="main_container">
            <div class="sub_text"><span>이용중인 상품</span></div>
            <div class="goods_container">
                <div class="text_area">
                    <span class="upper_text">주거 프라임</span>
                </div>
                <div class="text_area">
                    <span class="mid_text">기간 <span class="mid_date_text">2021.06.01 ~ 2021.06.30</span></span>
                </div>
                <div class="text_area">
                    <span class="lower_text">배분 10건</span>
                </div>
            </div>
            <div class="sub_text"><span>이용 끝난 상품</span></div>
            <div class="goods_container">
                <div class="text_area">
                    <span class="upper_text">주거 프라임</span>
                </div>
                <div class="text_area">
                    <span class="mid_text">기간 <span class="mid_date_text">2021.06.01 ~ 2021.06.30</span></span>
                </div>
                <div class="text_area">
                    <span class="lower_text">배분 10건</span>
                </div>
            </div>
            <div class="goods_container">
                <div class="text_area">
                    <span class="upper_text">주거 프라임</span>
                </div>
                <div class="text_area">
                    <span class="mid_text">기간 <span class="mid_date_text">2021.06.01 ~ 2021.06.30</span></span>
                </div>
                <div class="text_area">
                    <span class="lower_text">배분 10건</span>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/newTestFooter.jsp" flush="false" />
</div>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
<script>
</script>
</body>
</html>