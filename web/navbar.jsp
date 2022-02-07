<%--
  Created by IntelliJ IDEA.
  User: YejinLEE
  Date: 2021-05-07
  Time: 오후 5:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        #somun_navbar{
            float: left;
            width: 100%;
            height: 38px;
            text-align: center;
            padding: 16px 0 6px;
            /*line-height:30px;*/
        }
        #somun_logo{
            /*border: 1px solid blue;*/
            display: inline-block;
            /*background: url("https://somoonhouse.com/img/somunhouselogo.png") no-repeat;*/
            width: max-content;
            float:left;
            position: relative;
            font-weight: bold;
            color: #31b1f2;
            font-size: 36px;
            left: 4%;
        }
        #alert{
            display: inline-block;
            float:right;
            right: 4%;
            position: relative;
        }
        #somun_logo a{
            color: #31b1f2;
        }
        #somun_logo a:visited{
            color: #31b1f2;
        }
        #somun_logo a:hover{
            color: #31b1f2;
        }
        #somun_logo a:active{
            color: #31b1f2;
        }
    </style>
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
<div id="somun_navbar">
    <div id="somun_logo"><a href="index.jsp"><img style="height:30px;"src="https://somoonhouse.com/otherimg/index/somunlogo.jpg"></a></div>
    <div id="alert"><a href="alert.jsp"><img style="height:30px;"src="https://somoonhouse.com/otherimg/index/alert.jpg"></a></div>
</div>
</body>
</html>
