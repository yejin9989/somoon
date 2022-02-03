<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% session.setAttribute("page", "signup.jsp"); %>
<!Doctype html>
<html>
<head>
<style>
form{
    width: 394px;
    margin: auto;
    background: #fbfbfb;
    border-radius: 5px;
    padding: 41px;
    box-sizing: border-box;
    box-shadow: 0px 0px 3px 0px #44444440;
}
form input[type="text"],form input[type="password"]{
	width:100%;
    height: 30px;
    border: solid 1px #dadada;
}
#birthday{
	display:table;
	width: 100%;
	table-layout: fixed;
	border-spacing: 3px;
}
#birthday div{
	display: table-cell;
	width: 100%;
}
#birthday div input, #birthday div select{
	width:100%;
	height:30px;
	vertical-align: middle;
	padding: 0;
	margin: 0;
    border: solid 1px #dadada;
}
span{
	display:block;
}
</style>
<title>소문난집 회원가입</title>
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
	<div>
		<form action="_signup.jsp" method="post">
			<div>
				<span>아이디</span>
				<input type="text" name="id">
			</div>
			<div>
				<span>비밀번호</span>
				<input type="password" name="pw">
			</div>
			<div>
				<span>성함</span>
				<input type="text" name="name">
			</div>
			<div>
				<span>이메일주소</span>
				<input type="text" name="email">
			</div>
			<div>
				<span>별명</span>
				<input type="text" name="nickname">
			</div>
			<div>
				<span>생년월일</span>
				<div id="birthday">
					<div>
						<input type="text" name="year" placeholder="년(4자)">
					</div>
					<div>
     					<select name="month">
     						<option value="" disabled selected hidden>월</option>
       							<%for(int i=1; i<=12; i++){ 
       								if(i<10){%>
       									<option value="0<%=i %>"><%=i %></option>
       								<%}
       								else{%>
       									<option value="<%=i %>"><%=i %></option>
       								<%}
       							} %>
     					</select>
     				</div>
     			<div>
     				<input type="text" name="date" placeholder="일">
     			</div>
     			</div>
     		</div>
     		<div>
				<span>성별</span>
				<input type="radio" name="gender" value="0" id="gend0"><label for="gend0">여</label>
				<input type="radio" name="gender" value="1" id="gend1"><label for="gend1">남</label>
			</div>
			<input type="hidden" name="sns_id" value="-1">
			<input type="hidden" name="sns_type" value="-1">
			<input type="submit">
		</form>
	</div>
</body>
</html>