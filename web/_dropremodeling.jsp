<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar,java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page language="java" import="myPackage.DBUtil" %> 
<%@ page language="java" import="myPackage.Link" %> 
<%@ page language="java" import="myPackage.GetImage" %>
<%@ page language="java" import="java.io.File"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<%
	String num = request.getParameter("num")+"";
	String id = session.getAttribute("s_id")+"";
	String now = "_dropremodeling.jsp";
	 
	Connection conn = DBUtil.getMySQLConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// 서버 이미지 삭제
	String[] previmgs = {"", "", "", "", "", "", "", "", "", ""};
	String sql = "select * from RMDL_IMG where Number = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, num);
	rs = pstmt.executeQuery();
	int i = 0;
	while(rs.next()){
		previmgs[i] = rs.getString("Path");
		i++;
		if(i==10) break;
	}
	out.println("number : "+ num);
	//이미지들 다 삭제
	for(i=0; i<previmgs.length; i++){
		File file = new File("/somunhouse/tomcat/webapps/ROOT/"+previmgs[i]); 
		if(file.exists()) {
			if(file.delete()){ 
				out.println("파일삭제 성공"+i+"번째 : " + previmgs[i]); 
				}
			else {
				out.println("파일삭제 실패"+i+"번째: " + previmgs[i]); 
				}
			}
		else {
			out.println("파일이 존재하지 않습니다."+i+"번째: " + previmgs[i]);
			}
	}
	//디비 삭제
	for(i=0; i<previmgs.length; i++){
		sql = "delete from RMDL_IMG where Path = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, previmgs[i]);
		pstmt.executeUpdate();
	}
	
	sql = "Delete from REMODELING where Number = ?";
	pstmt = null;
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, num);
	pstmt.executeUpdate();
	pstmt.close();
	conn.close();
	%>
	<script>
	alert('삭제를 완료했습니다.');
	//self.close();
	</script>
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
</body>
</html>