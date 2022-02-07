<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
  
  <%
  	int error = 0;

  	String id = request.getParameter("id");
  	String pw = request.getParameter("pw");
	Connection conn = DBUtil.getMySQLConnection();
  	PreparedStatement pstmt = null;
  	ResultSet rs = null;
  	String query = "Select * from USERS where SITE_ID = ? and PW = password(?)";
  	pstmt = conn.prepareStatement(query);
  	pstmt.setString(1, id);
  	pstmt.setString(2, pw);
  	rs = pstmt.executeQuery();
  	String name = null;
  	String s_id = null;
  	while(rs.next()){
  		name = rs.getString("USERNAME");
  		s_id = rs.getString("ID");
  	}
  	if(s_id == null){
  		error++;
  	}
  %>
<!DOCTYPE html>
<html>
<head><!-- 사용자 행동 정보 수집 코드 시작 - Meta, GA -->
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
<script>
	if("<%=error%>" == "0"){
		confirm("<%=name%>님 환영합니다.");
		location.href="index.jsp";
	}
	else{
		alert("아이디와 비밀번호를 확인해주세요.");
		history.back();
	}
</script>
</body>
</html>