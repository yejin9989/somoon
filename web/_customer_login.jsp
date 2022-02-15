<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "_customer_login.jsp"); %>
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
//session.setAttribute("page", "remodeling_request.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";

//로그인 할 회사번호, 비밀번호 받아오기
String customer_num = request.getParameter("customer_num");
String pw = request.getParameter("password");

//해당 아디비번 매치하는지 확인
String customer_name = null;

if(pw != null){
	query = "select * from REMODELING_APPLY where Number = ? and Pw = password(?)";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, customer_num);
	pstmt.setString(2, pw);
	rs = pstmt.executeQuery();
	while(rs.next()){
		customer_name = rs.getString("Name");
	}
	//일치하는 회원정보가 있을 시
	if(customer_name != null){
		//세션설정
		session.setAttribute("s_id", "cu"+customer_num);
		session.setAttribute("name", customer_name);
		session.setMaxInactiveInterval(120*60);
		
		//개인페이지로
		response.sendRedirect("customer_request.jsp");
		//test
	}
	else{
	}
}
//DB개체 정리
/*
pstmt.close();
rs.close();
query="";
conn.close();
*/
%>
<!DOCTYPE html>
<head>
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
<script>
window.onload = function() {
	if("<%=pw%>" == ""){
		alert("비밀번호를 입력해주세요!");
		history.back();
	}
	else if("<%=customer_name%>" == "null" || "<%=customer_name%>" == "" ){
		alert("비밀번호를 재확인 해주세요.");
		history.back();
	}
};
</script>
</body>
</html>