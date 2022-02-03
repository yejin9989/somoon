<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
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

//세션 생성 create session
session.setAttribute("page", "company_home.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";

String company_id = request.getParameter("company");
company_id = request.getParameter("company_id");

String company_name = "";
String company_area = "";
String company_as_warranty = "";
String company_as_fee = "";
String company_as_provide = "";
String company_career = "";
String company_img = "";
String company_cs_cnt = "";
ArrayList<String> company_abilities = new ArrayList<String>();
String company_introduction = "";

query = "select * from COMPANY where Id = ?";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, company_id);
rs = pstmt.executeQuery();

while(rs.next()){
	company_name = rs.getString("Name");
	company_area = rs.getString("Address");
	company_as_warranty = rs.getString("As_warranty");
	company_as_fee = rs.getString("As_fee");
	company_as_provide = rs.getString("As_provide");
	company_career = rs.getString("Career");
	company_img = rs.getString("Profile_img");
	company_introduction = rs.getString("introduction");
}

int i =0;
query = "select A.Title from SPECIALIZED S, COMPANY_ABILITIES A where S.Company_num = ? and S.Ability_num = A.Id";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, company_id);
rs = pstmt.executeQuery();
while(rs.next()){
	company_abilities.add(rs.getString("A.Title"));
}

	query = "SELECT COUNT(*) cnt from ASSIGNED where Company_num = ? and State > 3 and State < 9;";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, company_id);
	rs = pstmt.executeQuery();

	while(rs.next()) {
		company_cs_cnt = rs.getString("cnt");
	}
%>

<!DOCTYPE html>
<html>
<head>
<%
if(s_id.equals("")){
	%><script>
		history.back(-1);
	</script><%
}

//기타 자격증 가져오기
	LinkedList<String> cert = new LinkedList<String>();
query = "";
%>
<link rel="SHORTCUT ICON" href="img/favicon.ico" />
<link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick-theme.css"/>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/company_home.css">
<style type="text/css">

</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title>소문난집</title><!-- 사용자 행동 정보 수집 코드 시작 - Meta, GA -->
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
	<div id="container">
		<div id="profile_img"></div>
		<div id="company_name"><%=company_name%></div>
		<div id="company_cs_cnt">🔥 최근 상담 건수 <%=company_cs_cnt%>건 🔥</div>
<%--			<div class="as_provide<%=company_as_provide%>">A/S <%if(company_as_provide.equals("0")){%>미<%}%>제공</div>--%>
			<div id="company_address"><%=company_area%></div>
		<% if(company_as_provide.equals("1")){ %>
			<div id="company_address">A/S 기간  <%=company_as_warranty%><%if(company_as_warranty.equals("5")){%>년 이상<%}else{%>년<%}%></div>
			<div id="company_address">A/S 금액  <%if(company_as_fee != null && !company_as_fee.equals("null")){%><%=company_as_fee%>만원<%}else{%>미입력<%}%></div>
		<%}%>
		<div id="company_address">경력 기간 <%if(company_career != null && !company_career.equals("null")){%><%=company_career%>년<%}else{%>미입력<%}%></div>
		<div id="company_abilities">
			<%
			for(i=0;i<company_abilities.size();i++){
				%>
				<div>
				<%out.print(company_abilities.get(i));%>
				</div>
				<%
			}
			%>
		</div>
		<hr>
		<div id="introduction">
			<div>
			<%if(company_introduction == null || company_introduction.equals("null")){
				out.println("회사 소개글을 작성해주세요.");
			}
			else{
				out.println(company_introduction);
			}%>
			</div>
		</div>
		<div id="request_btn" <%if(s_id.equals(company_id)){%>style="display: none !important";<%}%>>견적상담받기</div>
		<%
		if(s_id.equals(company_id)){
			%>
			<div id="edit_info">정보 수정하기</div>
			<div id="company_remodeling">내 사례 관리</div>
			<%
		}
		%>
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
	$("#edit_info").click(function(){
		location.href="company_edit.jsp";
	})
	$("#company_remodeling").click(function(){
		location.href="company_remodeling.jsp";
	})
	$("#request_btn").click(function() {
		// location.href="" 해야행
	})
$(document).ready(function(){
	$('#profile_img').css("background", "url(<%=company_img%>) 50% 50% / 198px");
})
</script>
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "3602e31fd32c7e";
wcs_do();
</script>
<script type="text/javascript" src="slick-1.8.1/slick/slick.min.js"></script>
</body>
</html>