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
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
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
	
	//처리에 에러정보가 있으면 롤백
	int error = 0;
	
	//신청폼으로 부터 받은 데이터 불러오기, 필요한 정보 정의
	int num = 0;
	String item_num = request.getParameter("item_num");
	String agree = request.getParameter("agree"); 
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	String area = request.getParameter("area");
	String due = request.getParameter("due");
	String budget = request.getParameter("budget");
	String visit = request.getParameter("visit");
	String compare = request.getParameter("compare");
	java.sql.Date d = null;
	String state = "0"; //처리상태 - 0:신청완료 1:업체전달완료 2:상담완료 3:거래성사
	
	//받을 때 숫자형태가 아닌데 숫자로 입력해야하는경우 변환해주기
	//필드를 다 채웠는지의 여부를 확인해본다. 덜 채웠으면 다시 채우라하기
	if(item_num == null || item_num.equals("null")){
	%>
		<script>
		alert('잘못 된 접근입니다!');
		</script>
	<%
	error++;
	}
	else if(agree == null){
	%>
		<script>
		alert('개인정보 활용동의에 체크해주세요.');
		</script>
	<%
	error++;
	}
	else if(name == null || 
			phone == null || 
			address == null || 
			area == null || 
			due == null || 
			budget == null ||
			visit == null ||
			compare == null){
		%>
		<script>
		alert('모든항목에 답변 해주세요.');
		</script>
	<%	
	error++;
	}
	
	//몇번째 신청 정보인지
	query = "select case when count(*)=0 then 1 else max(Number) + 1 end as num FROM REMODELING_APPLY";
	stmt = conn.createStatement();
	rs = stmt.executeQuery(query);
	while(rs.next()){
		num = rs.getInt("num");
	}
	
	//현재날짜 받아오기
	Calendar cal = Calendar.getInstance();
	String year = Integer.toString(cal.get(Calendar.YEAR));
	String month = Integer.toString(cal.get(Calendar.MONTH)+1);
	String date = Integer.toString(cal.get(Calendar.DATE));
	String todayformat = year+"-"+month+"-"+date;
	d = java.sql.Date.valueOf(todayformat);

	//업데이트하기
	sql = "INSERT INTO REMODELING_APPLY(Number, Item_num, Name, Phone, Address, Building_type, Area, Due, Budget, Consulting, Compare, Apply_date, State, Calling, Pw) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, num);
	pstmt.setString(2, item_num);
	pstmt.setString(3, name);
	pstmt.setString(4, phone);
	pstmt.setString(5, address);
	pstmt.setString(6, area);
	pstmt.setString(7, due);
	pstmt.setString(8, budget);
	pstmt.setString(9, visit);
	pstmt.setString(10, compare);
	pstmt.setDate(11, d);
	pstmt.setString(12, state);
	
	if(error == 0){
		pstmt.executeUpdate();
		%>
		<script>
		alert('등록을 완료했습니다.');
		self.close();
		</script>
		<%
	}
	else{
		%>
		<script>
		history.back();
		</script>
		<%
	}
	
	//확인
	//out.println(pstmt);
	
	//DB객체 종료
	stmt.close();
	pstmt.close();
	conn.close();
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
</body>
</html>