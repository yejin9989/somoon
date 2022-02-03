<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<%@ page import ="java.util.Calendar"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "remodeling_form.jsp"); %>
<%
//DB에 사용 할 객체들 정의
Connection conn = DBUtil.getMySQLConnection();
PreparedStatement pstmt = null;
Statement stmt = null;
String query = "";
String sql = "";
ResultSet rs = null;
ResultSet rs2 = null;

//세션 생성 create session
session.setAttribute("page", "_company_edit.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";

String company_id = request.getParameter("company");

String company_area = request.getParameter("company_area");
String company_as_warranty = request.getParameter("company_as_warranty");
String company_as_fee = request.getParameter("company_as_fee");
//String company_career = request.getParameter("company_career");
String[] company_abilities = request.getParameterValues("tag");
//ArrayList<String> company_abilities = new ArrayList<String>();
String company_introduction = request.getParameter("company_introduction");
String company_limit_fee = request.getParameter("company_limit_fee");
if(company_limit_fee.equals("null")) company_limit_fee = null;
String company_start_year = request.getParameter("company_start_year");
if(company_start_year.equals("null")) company_start_year = null;
String part = request.getParameter("part");
%><%

//A/S제공여부 boolean처리
String company_as_provide = "";
if(company_as_warranty.equals("null") || company_as_warranty.equals("0"))
	company_as_provide = "0";
else
	company_as_provide = "1";

//부분시공 가능 여부 boolean처리
if(part.equals("yes"))
	part = "1";
else part = "0";

//소개글 줄 바꿈 대치 시켜야함
company_introduction = company_introduction.replace("\n", "<br>");

//사업자 등록 연도로 부터 경력 계산
String career = "";
if(company_start_year != null && !company_start_year.equals("null") && !company_start_year.equals("")) {
	Calendar cal = Calendar.getInstance();
	int today = cal.get(Calendar.YEAR);
	int car = today - Integer.parseInt(company_start_year) + 1;
	career = Integer.toString(car);
}

query = "update COMPANY set Address=?, Career=?, Introduction=?, As_warranty=?, As_fee=?, As_provide = ?, Limit_fee = ?, Start_year=? where Id = ?";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, company_area);
pstmt.setString(2, career);
pstmt.setString(3, company_introduction);
pstmt.setString(4, company_as_warranty);
pstmt.setString(5, company_as_fee);
pstmt.setString(6, company_as_provide);
pstmt.setString(7, company_limit_fee);
pstmt.setString(8, company_start_year);
pstmt.setString(9, company_id);
pstmt.executeUpdate();

// 부분시공 가능 여부 업데이트하기
query = "select count(*) cnt from SPECIALIZED where Company_num = ? and Ability_num = 11";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, company_id);
rs = pstmt.executeQuery();
while(rs.next()) {
	query = "delete from SPECIALIZED where Company_num = ? and Ability_num = 11";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, s_id);
	pstmt.executeUpdate();
}
if(part.equals("1")) {
	query = "insert into SPECIALIZED values(?, ?)";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, s_id);
	pstmt.setString(2, "11");
	pstmt.executeUpdate();
}

//태그 처리
//태그가 있는 경우
if(company_abilities != null){
	int i =0;
	for(i=0; i<company_abilities.length; i++){
		//company_abilities 테이블에 있는지 확인 후, 없으면 넣기.
		//specialized에 해당 능력 넣기.
		query = "select Id from COMPANY_ABILITIES where Title = ?";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, company_abilities[i]);
		rs = pstmt.executeQuery();
		String ability_id = null;
		while(rs.next()){
			ability_id = rs.getString("Id");
		}
		if(ability_id == null){
			query = "insert into COMPANY_ABILITIES values(?, default)";	
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, company_abilities[i]);
			pstmt.executeUpdate();
			//방금 넣은 거 찾기..
			query = "select Id from COMPANY_ABILITIES where Title = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, company_abilities[i]);
			rs = pstmt.executeQuery();
			ability_id = null;
			while(rs.next()){
				ability_id = rs.getString("Id");
			}
		}
	
		//specialized에 해당 능력 넣기
		query = "insert into SPECIALIZED values(?, ?)";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, company_id);
		pstmt.setString(2, ability_id);
		pstmt.executeUpdate();
	}
}
%>

<!DOCTYPE html>
<html>
<head>
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
	<!-- 사용자 행동 정보 수집 코드 끝 - Meta, GA -->
</head>
<body>
<%
//DB개체 정리
pstmt.close();
//rs.close();
//query="";
conn.close();
%>
<script>
	alert('수정을 완료했습니다.');
	window.location.replace("https://somoonhouse.com/company_home.jsp?company_id="+<%=s_id%>);
</script>
</body>
</html>