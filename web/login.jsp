<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% session.setAttribute("page", "login.jsp"); %>
<!DOCTYPE html>
<html>
<head>
<link rel="SHORTCUT ICON" href="img/favicon.ico" />
<link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick-theme.css"/>
<style type="text/css">
@font-face{
font-family:"Nanum";
src:url("fonts/NANUMBARUNGOTHIC.TTF");
}
*{
font-family:"Nanum";
}
a{
text-decoration: none;
}
#container{
margin:auto; 
max-width: 400px;
}
#somun_logo{
width: fit-content;
margin: auto;
margin-top: 80px; 
padding: 25px;
}
#somun_logo img{
width:128px;
}
.login_btn{
width: 297px;
height: 48px;
line-height: 48px;
text-align: center;
background-color: #52b2ff;
color: white;
border-radius: 5px;
font-size: 17px;
margin: 16px auto;
border:none;
}
.input_wrapper{
margin:auto;
width:fit-content;
}
#input_id{
width:275px;
height:28px;
font-size:15px;
padding:10px;
border-radius: 5px 5px 0px 0px;
border: 1px solid #d0d0d0;
border-bottom:0px;
}
#input_pw{
width:275px;
height:28px;
font-size:15px;
padding:10px;
border-radius: 0px 0px 5px 5px;
border: 1px solid #d0d0d0;
}
input :focus{
outline: blue auto 1px;
}
.signin_action{
text-align:center;
font-size:14px;
color: #4d4d4d;
}
.signin_action a{
padding: 3px 5px;
margin: -3px 10px;
}
.divider{
padding: 30px;
color: gray;
}
.divider_line{
width: 25%;
position: relative;
border-bottom: 1px solid gray;
float: left;
height: 9.2px;
}
.divider_text{
float: left;
width: 50%;
text-align: center;
font-size: 14px;
}
.social_login_btn{
width: 297px;
height: 48px;
line-height: 48px;
text-align: center;
background-color: #1bd136;
color: white;
border-radius: 5px;
font-size: 17px;
margin: 16px auto;
}
.social_login_btn span{
font-weight: bolder;
font-size: 28px;
}
.social_login_btn a{
color:white;
}
#signup, #signin{
cursor: pointer;
}
form{
text-align: center;
}
</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title>????????????</title>
	<!-- ????????? ?????? ?????? ?????? ?????? ?????? - Meta, GA -->
	<!-- ?????? ???????????? ???????????? ???????????? ????????? ?????????. ????????? </head> ?????? ?????? ?????? -->
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
	<!-- Google Tag Manager -->
	<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
				new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
			j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
			'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
	})(window,document,'script','dataLayer','GTM-TQFGN2T');</script>
	<!-- End Google Tag Manager -->
	<!-- ????????? ?????? ?????? ?????? ?????? ??? - Meta, GA -->
</head>
<%
String clientId = "G8MVoxXfGciyZW5dF4p1";//?????????????????? ??????????????? ????????????";
String redirectURI = URLEncoder.encode("http://somoonhouse.com/callback.jsp", "UTF-8");
SecureRandom random = new SecureRandom();
String state = new BigInteger(130, random).toString();
String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
apiURL += "&client_id=" + clientId;
apiURL += "&redirect_uri=" + redirectURI;
apiURL += "&state=" + state;
session.setAttribute("state", state);
%>
<body>
<div id="container">
	<div id="somun_logo"><a href="index.jsp"><img src="img/somunlogo.png"></a></div>
	<form action="_general_login.jsp" method="POST">
		<div class="input_wrapper"><input type="text" placeholder="ID" id="input_id" name="id"></div>
		<div class="input_wrapper"><input type="password" placeholder="PW" id="input_pw" name="pw"></div>
		<input type="submit" class="login_btn" value="?????????">
		<div class="signin_action">
			<!-- a>???????????? ?????????</a-->
			<a id="signup">????????????</a>
		</div>
	</form>
	<div class="divider">
		<div class="divider_line"></div>
		<div class="divider_text">?????????????????? ?????????</div>
		<div class="divider_line"></div>
	</div>
	<div class="social_login_btn"><a href="<%=apiURL%>"><span>N</span>????????? ???????????? ?????????</a></div>
	<div id="naver_id_login"></div>
<script type="text/javascript"
		src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
		charset="utf-8"></script>
</div>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
$("#signup").click(function(){
	location.href="signup.jsp";
})
</script>
</body>
</html>