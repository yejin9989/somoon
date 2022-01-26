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
%>
<%
    ArrayList<String> imgs = new ArrayList<String>();
    query = "SELECT * FROM ALERT order by Id asc";
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
    <!-- Meta Pixel Code -->
    <script>
        !function(f,b,e,v,n,t,s)
        {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
            n.callMethod.apply(n,arguments):n.queue.push(arguments)};
            if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
            n.queue=[];t=b.createElement(e);t.async=!0;
            t.src=v;s=b.getElementsByTagName(e)[0];
            s.parentNode.insertBefore(t,s)}(window, document,'script',
            'https://connect.facebook.net/en_US/fbevents.js');
        fbq('init', '333710951988229');
        fbq('track', 'PageView');
    </script>
    <noscript><img height="1" width="1" style="display:none"
                   src="https://www.facebook.com/tr?id=333710951988229&ev=PageView&noscript=1"
    /></noscript>
    <!-- End Meta Pixel Code -->
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', 'G-PC15JG6KGN');
    </script>
    <!-- END Global site tag (gtag.js) - Google Analytics -->
</head>
<body>
<div id="container">
    <div>
        <span id="topBtn">top</span>
        <span id="applyBtn"><div>상담<br>신청</div></span>
    </div>
    <div id="somun_navbar">
        <div id="somun_logo"><a href="index.jsp"><img style="height:30px;"src="https://somoonhouse.com/otherimg/index/somunlogo.jpg"></a></div>
        <div id="alert"><a href="alert.jsp"><img style="height:30px;"src="https://somoonhouse.com/otherimg/index/alert.jpg"></a></div>
    </div>
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
<!-- jsp:include page="footer.jsp" flush="false"/ -->
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'G-PC15JG6KGN');
</script>
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
        window.open("alert_change_img.jsp", "_blank", "width=334px, height=600px")
    })
</script>
<script>
    $('#alert_img').click(function(){
        location.href="remodeling_form.jsp?item_num=0";
    })
</script>
</body>
</html>