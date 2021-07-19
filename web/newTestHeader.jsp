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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newTestHeader.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
<%=mylog%>
<%

%>
<div class="body_container">
    <div class="body_header">
        <div class="upper_header">
            <div class="left_header">
                <span>소문난집</span>
            </div>
            <div class="right_header">
                <div class="img_container">
                    <img class="graph"
                         src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/graph2.png?raw=true" />
                </div>
                <div class="img_container" id="menu_slide" onclick="slide()">
                    <img class="menu"
                         src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/menu3.png?raw=true" />
                </div>
            </div>
        </div>
        <div class="lower_header">
            <a href="newTest0.jsp" target="_self">
                <div class="menu" id="new_customer">
                    <div class="menu_text"><span>신규</span></div>
                    <div class="menu_underbar"></div>
                </div>
            </a>
            <a href="newTest.jsp" target="_self">
                <div class="menu" id="ing_customer">
                    <div class="menu_text"><span>진행 중</span></div>
                    <div class="menu_underbar"></div>
                </div>
            </a>
            <a href="newTest1.jsp" target="_self">
                <div class="menu" id="fin_customer">
                    <div class="menu_text"><span>완료</span></div>
                    <div class="menu_underbar"></div>
                </div>
            </a>
            <a href="newTest2.jsp" target="_self">
                <div class="menu" id="stop_customer">
                    <div class="menu_text"><span>중단</span></div>
                    <div class="menu_underbar"></div>
                </div>
            </a>
        </div>
    </div>
    <div id="navigation_container">
        <div id="navigation">
            <div>공지사항</div>
            <div>고객센터</div>
            <div>공식홈페이지</div>
            <div></div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
<script>
    function slide(){
        var nav = document.getElementById("navigation_container");
        var nav_bar = document.getElementById("navigation");
        if(nav.style.display == "none"){
            nav.style.display = "grid";
        }
        else{
            nav.style.display = "none";
        }
    }
</script>
</body>
</html>