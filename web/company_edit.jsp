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
ResultSet rs2 = null;

//세션 생성 create session
session.setAttribute("page", "company_home.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";

String company_id = request.getParameter("company");
company_id = s_id;


String company_img = "";
String company_name = "";
String company_area = "";
String company_as_warranty = "";
String company_as_fee = "";
//String company_career = "";
String company_as_provide = "";
//ArrayList<String> company_abilities = new ArrayList<String>();
HashMap<String, String> company_abilities = new HashMap<String, String>();
String company_introduction = "";
String company_limit_fee = "";
String company_start_year = "";

query = "select * from COMPANY where Id = ?";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, company_id);
rs = pstmt.executeQuery();

while(rs.next()){
	company_img = rs.getString("Profile_img");
	company_name = rs.getString("Name");
	company_area = rs.getString("Address");
	company_as_warranty = rs.getString("As_warranty");
	company_as_fee = rs.getString("As_fee");
//	company_career = rs.getString("Career");
	company_introduction = rs.getString("Introduction");
	company_as_provide = rs.getString("As_provide");
	company_limit_fee = rs.getString("Limit_fee");
	company_start_year = rs.getString("Start_year");
}
if(company_introduction != null && !company_introduction.equals("null")) company_introduction = company_introduction.replace("<br>", "\n");

//String checked = "";
//if(company_as_provide.equals("0")){
//	checked = "checked";
//}

int i =0;
String is_part_possible ="0";
query = "select A.Title, A.Id from SPECIALIZED S, COMPANY_ABILITIES A where S.Company_num = ? and S.Ability_num = A.Id";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, company_id);
rs = pstmt.executeQuery();
while(rs.next()){
	company_abilities.put(rs.getString("A.Id"), rs.getString("A.Title"));
}
query = "select count(*) cnt from SPECIALIZED where Company_num = ? and Ability_num = 11";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, company_id);
rs2 = pstmt.executeQuery();
while (rs2.next()) {
	if(!rs2.getString("cnt").equals("0"))  is_part_possible = "1";
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
	<div id="container">
		<form action="_company_edit.jsp" method="post">
		<div id="profile_img"></div>
		<div id="company_name"><%=company_name%></div>
<%--		<input type="checkbox" name="as_provide" class="mycheck" id="as_provide" value="1" <%=checked%>><label id="as_label" for="as_provide">A/S 제공</label>--%>
		<div id="btnArea">
			<input type="button" onClick="goLicenseUpload();" class="submitBtn" id="business_license" value="사업자등록증 제출하기"/>
			<input type="button" onClick="goCertificateUpload();" class="submitBtn" id="etc_license" value="기타 자격증 제출" />
		</div>
		<div id="company_address"><input type="text" name="company_area" value="<%=company_area%>"></div>
		<div id="as_warranty"><div class="input_label">A/S 기간</div>
			<select id="select_as_warranty" name="company_as_warranty">
				<option value="0" <%if(company_as_warranty == null || company_as_warranty.equals("0")){%>selected="selected"<%}%>>제공안함</option>
				<option value="1" <%if(company_as_warranty != null && company_as_warranty.equals("1")){%>selected="selected"<%}%>>1년</option>
				<option value="2" <%if(company_as_warranty != null && company_as_warranty.equals("2")){%>selected="selected"<%}%>>2년</option>
				<option value="3" <%if(company_as_warranty != null && company_as_warranty.equals("3")){%>selected="selected"<%}%>>3년</option>
				<option value="4" <%if(company_as_warranty != null && company_as_warranty.equals("4")){%>selected="selected"<%}%>>4년</option>
				<option value="5+" <%if(company_as_warranty != null && company_as_warranty.equals("5+")){%>selected="selected"<%}%>>5년 이상</option>
			</select>
		</div>
		<div id="as_fee"><div class="input_label">A/S 금액</div><input type="text" name="company_as_fee" <%if(company_as_fee != null && !company_as_fee.equals("") && !company_as_fee.equals("null")){%>value="<%=company_as_fee%>"<%}else{%>placeholder="만(원) 단위로 숫자만 입력하세요"<%}%>></div>
		<div id="company_career"><div class="input_label">사업자 등록 연도</div><input type="text" name="company_start_year" <%if(company_start_year != null && !company_start_year.equals("") && !company_start_year.equals("null")){%>value="<%=company_start_year%>"<%}else{%>placeholder="(년) 단위로 숫자만 입력하세요"<%}%>><div class="input_desc">* 사업자등록연도를 기준으로 경력이 반영됩니다. 실제 경력이 다를 경우 담당자에 연락 요망</div></div>
		<div id="company_limit_fee"><div class="input_label">최소 시공금액</div><input type="text" name="company_limit_fee" <%if(company_limit_fee != null && !company_limit_fee.equals("") && !company_limit_fee.equals("null")){%>value="<%=company_limit_fee%>"<%}else{%>placeholder="만(원) 단위로 숫자만 입력하세요"<%}%>></div>
		<div id="part"><div class="input_label">부분시공 가능 여부</div>
			<select id="select_part" name="part">
				<option value="default" <%if(is_part_possible.equals("0")){%>selected="selected"<%}%>>선택안함</option>
				<option value="yes" <%if(is_part_possible.equals("1")){%>selected="selected"<%}%>>가능</option>
			</select>
		</div>
		<div id="company_abilities">
			<%
			for(String key: company_abilities.keySet()){
				%>
				<div>
				<%out.print(company_abilities.get(key));%>
				<span class="delete_ability" id="<%=key%>">X</span>
				</div>
				<%
			}
			%>
<%--			<div id="add_ability"><span>+</span></div>--%>
		</div>
		<hr>
		<div id="introduction"><textarea cols=30 name="company_introduction"><%if(company_introduction != null && !company_introduction.equals("") && !company_introduction.equals("null")){%><%=company_introduction%><%}else{%>소개글을 작성해주세요.<%}%></textarea></div>
		<input type="submit" id="edit_btn" value="저장하기">
		</form>
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
$("#add_ability").click(function(){
	$(this).before("<div id=\"added\">+<input type=\"text\" class=\"tag\" name=\"tag\"></div>");
})
$(".delete_ability").click(function(){
	alert('hey');
	var url = "delete_ability.jsp?ability_id=";
	alert(url);
	var id = $(this).attr('id');
	url += id;
	location.href = url;
})
$("#select_as_warranty").change(function() {
	let val = -1;
	$("#select_as_warranty option:selected").each(function() {
		val = $(this).index();
	})
	if(val == 0) $("#as_fee").css("display","none");
	else $("#as_fee").css("display","block");
}).trigger("change");
$(document).ready(function(){
	// checking();
	$('#profile_img').css("background", "url(<%=company_img%>) 50% 0% / 198px");
})

function goLicenseUpload(){
	window.open("business_license_upload.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
}

function goCertificateUpload(){
	window.open("etc_license_upload.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
}
</script>
<script type="text/javascript" src="slick-1.8.1/slick/slick.min.js"></script>
</body>
</html>