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
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="css/etc_license_upload.css">
    <title>배너 수정</title>
        <%
        // get banner id
        String id = request.getParameter("id")+"";
        %>
    <!-- 사용자 행동 정보 수집 코드 시작 - Meta, GA -->
    <!-- 모든 페이지에 하나씩만 포함되어 있어야 합니다. 위치는 </head> 바로 위로 통일 -->
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
        fbq('init', '483692416470707');
        fbq('track', 'PageView');
    </script>
    <noscript><img height="1" width="1" style="display:none"
                   src="https://www.facebook.com/tr?id=483692416470707&ev=PageView&noscript=1"
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
    <!-- 사용자 행동 정보 수집 코드 끝 - Meta, GA -->
</head>
<body>
<div class="upload-popup-header">
    <h3>배너 수정</h3>
    <div class="upload-popup-header-desc">
        <span>배너 이미지 또는 url을 수정해주세요.</span>
        <span class="text-red">이미지(JPEG, PNG) 외의 파일 선택 시 반려될 수 있습니다.</span>
    </div>
</div>
<form name="form" id="form" method="post" enctype="multipart/form-data" action="_banner_edit.jsp?id=<%=id%>">
    <div id="banner-edit-form" class="etc-license-upload-form" style="margin-top:20px">
        <div style="margin-bottom: 10px;">
            <span class="upload-form-left">url</span>
            <input class="text" name="url" type="text">
        </div>
        <div style="margin-bottom: 30px;">
            <span class="upload-form-left">배너 이미지</span>
            <input class="file" name="file" type="file">
        </div>
    </div>
    <div>
        <input type="submit" class="submitBtn" value="제출하기">
    </div>
</form>
</body>
</html>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%--<script>--%>
<%--</script>--%>
