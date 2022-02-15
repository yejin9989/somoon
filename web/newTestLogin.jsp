<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "remodeling_form.jsp"); %>
<%

/*로그인된 세션 아이디(추후개발) 가져오기, 현재 페이지 저장
String id = session.getAttribute("s_id")+"";
String now = "_remodeling_form.jsp";*/

//DB에 사용 할 객체들 정의
Connection conn = DBUtil.getMySQLConnection();
PreparedStatement pstmt = null;
Statement stmt = null;
String query = "";
String sql = "";
ResultSet rs = null;

//세션 생성 create session
session.setAttribute("page", "company_login.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";

//로그인 할 회사번호 받아오기
String company_num = request.getParameter("company_num");
//회사번호로 회사이름 가져오기
String company_name = null;

if(company_num != null){
query = "select Name from COMPANY where Id = " + company_num;
pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	while(rs.next()){
		company_name = rs.getString("Name");
	}
}
%>

<!DOCTYPE html>
<html>
<head>
<link rel="SHORTCUT ICON" href="img/favicon.ico" />
<link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick-theme.css"/>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
@font-face{
font-family:'Nanum Gothic',sans-serif;
}
*{
font-family:'Nanum Gothic',sans-serif;
font-size: 11pt;
color: #313131;
-webkit-appearance: none;
-webkit-border-radius: 0;
	padding:0;
	margin:0;
	box-sizing: border-box;
}
body{
}
input[type="checkbox"] {
    display:none;
}
input[type="checkbox"] + label span {
    display: inline-block;
    width: 24px;
    height: 24px;
    margin: -2px 10px 0 0;
    vertical-align: middle;
    background: url(img/checkbox.svg) left top no-repeat;
    cursor: pointer;
    background-size: cover;
}
input[type="checkbox"]:checked + label span {
    background:url(img/checkbox.svg)  -26px top no-repeat;
     background-size: cover;
}
#container {
	display:flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
    width: 100%;
	min-height: calc(100vh - 250px);
	height: 100%;
	background-color: #f5f5f5;
}
#content{
    max-width: 600px;
    height: fit-content;
    width: fit-content;
    padding: 58px 30px;
    box-shadow: 0px 0px 9px 5px #00000014;
    border-radius: 7px;
	background-color: #fafafa;
}
#content-div{
	width: 100%;
    display: inline-block;
    border-radius: 5px;
}
#company_name{
    text-align: center;
    font-size: 15pt;
}
#password_area{
	width: fit-content;
    margin: 0 auto;
    padding: 17px;
}
#password_label{
    padding-bottom: 5px;
}
input[name="password"]{
    border: 0px solid #bebebe;
    border-radius: 6px;
    height: 28px;
    background: #f2f2f2;
}
input[type="submit"]{
	width: 40px;
    height: 30px;
    border: 0;
    border-radius: 6px;
    background: #5C86F5;
    color: white;
	font-weight: 600;
}
</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title>소문난집</title>
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
	<!-- Google Tag Manager -->
	<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
				new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
			j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
			'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
	})(window,document,'script','dataLayer','GTM-TQFGN2T');</script>
	<!-- End Google Tag Manager -->
	<!-- 사용자 행동 정보 수집 코드 끝 - Meta, GA -->
</head>
<body>
<jsp:include page="/newTestHeader.jsp" flush="false" />
<div id="container">
	<div id="content">
		<div id="content-div">
			<div>
				<form action="_company_login.jsp" method="POST">
					<div id="company_name"><%=company_name%></div>
					<div id="password_area">
						<div id="password_label">비밀번호</div>
						<input type="password" name="password">
						<input type="hidden" name="company_num" value="<%=company_num%>">
						<input type="submit" value="확인">
					</div>
				</form>
			</div>
		</div>
	</div>
<%
//DB개체 정리
/*
pstmt.close();
rs.close();
query="";
conn.close();
*/
%>
<script>
window.onload = function() {
	if("<%=company_name%>" == null){
		alert("유효하지 않은 접근입니다!");
		location.href = "index.jsp";
	}
};
</script>
<script type="text/javascript" src="slick-1.8.1/slick/slick.min.js"></script>
</div>
<jsp:include page="/newTestFooter.jsp" flush="false" />
</body>
</html>