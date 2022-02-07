<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 31536000);
%>
<%
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
%>
<%
    String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
    // get banner id
    String id = request.getParameter("id")+"";
%>
<%
    ArrayList<String> imgs = new ArrayList<String>();
    query = "SELECT * FROM BANNER_IMG WHERE Id =" + id;
    pstmt = conn.prepareStatement(query);
    //pstmt.setString(1, );
    rs=pstmt.executeQuery();
    while(rs.next()){
        imgs.add(rs.getString("Path"));
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/alert.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
<div id="container">
    <jsp:include page="/homepage_pc_header.jsp" flush="false" />
    <jsp:include page="/homepage_mob_header.jsp" flush="false" />

    <div id="main">
        <div id="full-image">
            <%
                for(String img_path : imgs){
            %><img id="alert_img" src="<%=img_path%>"><%
            }
        %>
        </div>
        <%if(s_id.equals("100")){
        %>
        <div id="change_btn">사진교체</div>
        <%
            }%>
    </div>
</div>
<%
    if(pstmt != null) {
        pstmt.close();
        rs.close();
        query = "";
        conn.close();
    }
%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    var topEle = $('#topBtn');
    var delay = 1000;
    topEle.on('click', function(){
        $('html, body').stop().animate({scrollTop:0}, delay);
    })
</script>
<script>
    var applyEle = $('#applyBtn');
    applyEle.on('click', function(){
        location.href = "remodeling_form.jsp?item_num=0";
    })
</script>
<script>
    $('#change_btn').click(function(){
        window.open("banner_change_img.jsp?id=<%=id%>", "_blanck", "width=334px, height=600px")
    })
</script>
<script>
    $('#alert_img').click(function(){
        location.href="remodeling_form.jsp?item_num=0";
    })
</script>
</body>
</html>