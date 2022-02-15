<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 31536000);
%>
<%
    int i;
    String mylog = "";
%>
<%
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newindex.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>내 회사 사례 관리</title>
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
    <div>
        <span id="topBtn">top</span>
        <span id="applyBtn"><div>상담<br>신청</div></span>
    </div>
    <div id="somun_navbar">
        <div id="somun_logo"><a href="index.jsp"><img style="height:30px;"src="https://somoonhouse.com/otherimg/index/somunlogo.jpg"></a></div>
        <div id="alert"><a href="alert.jsp"><img style="height:30px;"src="https://somoonhouse.com/otherimg/index/alert.jpg"></a></div>
    </div>
    <div>
        <form id="form" name="form" method="POST" action="index.jsp">
            <div id="searcharea">
                <input type="text" id="bdNm"  name="bdNm" placeholder="아파트명으로 사례를 찾아보세요"/>
                <input type="button" onClick="goPopup();" value="주소찾기" id="jusobtn"/>
                <input id="search" type="submit" value="" style="top:65%;transform:translate(0, 0);">
            </div>
            <%String classes = "0"; %>
            <input type="hidden" style="width:40px;height:30px;" id="building" name="building" />
            <input type="hidden"  style="width:500px;" id="jibunAddr"  name="jibunAddr" />
            <input type="hidden"  style="width:500px;" id="roadFullAddr"  name="roadFullAddr" />
            <input type="hidden"  style="width:500px;" id="roadAddrPart1"  name="roadAddrPart1" />
            <input type="hidden"  style="width:500px;" id="addrDetail"  name="addrDetail" />
            <input type="hidden"  style="width:500px;" id="roadAddrPart2"  name="roadAddrPart2" />
            <input type="hidden"  style="width:500px;" id="engAddr"  name="engAddr" />
            <input type="hidden"  style="width:500px;" id="zipNo"  name="zipNo" />
            <input type="hidden"  style="width:500px;" id="admCd"  name="admCd" />
            <input type="hidden"  style="width:500px;" id="rnMgtSn"  name="rnMgtSn" />
            <input type="hidden"  style="width:500px;" id="bdMgtSn"  name="bdMgtSn" />
            <input type="hidden"  style="width:500px;" id="detBdNmList"  name="detBdNmList" />
            <input type="hidden"  style="width:500px;" id="bdKdcd"  name="bdKdcd" />
            <input type="hidden"  style="width:500px;" id="siNm"  name="siNm" />
            <input type="hidden"  style="width:500px;" id="sggNm"  name="sggNm" />
            <input type="hidden"  style="width:500px;" id="emdNm"  name="emdNm" />
            <input type="hidden"  style="width:500px;" id="liNm"  name="liNm" />
            <input type="hidden"  style="width:500px;" id="rn"  name="rn" />
            <input type="hidden"  style="width:500px;" id="udrtYn"  name="udrtYn" />
            <input type="hidden"  style="width:500px;" id="buldMnnm"  name="buldMnnm" />
            <input type="hidden"  style="width:500px;" id="buldSlno"  name="buldSlno" />
            <input type="hidden"  style="width:500px;" id="mtYn"  name="mtYn" />
            <input type="hidden"  style="width:500px;" id="lnbrMnnm"  name="lnbrMnnm" />
            <input type="hidden"  style="width:500px;" id="lnbrSlno"  name="lnbrSlno" />
            <input type="hidden"  style="width:500px;" id="emdNo"  name="emdNo" />
            <input type="hidden"  style="width:500px;" id="entX"  name="entX" />
            <input type="hidden"  style="width:500px;" id="entY"  name="entY" />
        </form>
        <div id="content">
                <%
    String clientId = "G8MVoxXfGciyZW5dF4p1";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://somoonhouse.com/callback.jsp", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 %>
                <%
// 세션 생성 create session
session.setAttribute("page", "company_remodeling.jsp"); // 현재 페이지 current page
// 세션 가져오기 get session
String pagenumstr = request.getParameter("pagenumstr")+"";
if(pagenumstr == null || pagenumstr.equals("null") || pagenumstr.equals("undefined")) pagenumstr = "1";
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";
String attr = request.getParameter("attr")+"";
String itemname = request.getParameter("itemname")+"";
String tag = request.getParameter("tag")+"";
%>
                <%
conn = DBUtil.getMySQLConnection();
rs = null;
pstmt = null;
query = "";
query="";
%>
            <!-- jsp:include page="navbar.jsp" flush="false"/ -->
                <%
//CSRF 방지를 위한 상태 토큰 검증
//세션 또는 별도의 저장 공간에 저장된 상태 토큰과 콜백으로 전달받은 state 파라미터 값이 일치해야 함

//콜백 응답에서 state 파라미터의 값을 가져옴
state = request.getParameter("state");
%>
                <%
String xx = request.getParameter("entX");
String yy = request.getParameter("entY");
float x = 0;
float y = 0;
if (xx != null && !xx.equals("")) x = Float.parseFloat(xx);
if (yy != null && !yy.equals("")) y = Float.parseFloat(yy);
pstmt = null;
query = "";
conn = DBUtil.getMySQLConnection();
rs = null;
String build = null;
build = request.getParameter("bdNm");
query = "Select * from REMODELING";
if(build != "" && build != null && !build.equals("all")){
	query += " where Apart_name Like \"%"+build+"%\"";
	query += " or Title Like \"%"+build+"%\"";
}
query += " where Company_num = " + s_id;
query += " order by Apart_name asc"; //limit 10
pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
String item[][] = new String[100000][20];
i = 0;
while(rs.next()){
	item[i][0] = rs.getString("Number");
	item[i][1] = rs.getString("Id");
	item[i][2] = rs.getString("Title");
	item[i][3] = rs.getString("Write_date");
	item[i][4] = rs.getString("Company");
	item[i][5] = rs.getString("Fee");
	item[i][6] = rs.getString("Address");
	item[i][7] = rs.getString("Apart_name");
	item[i][8] = rs.getString("Building");
	item[i][9] = rs.getString("Xpos");
	item[i][10] = rs.getString("Ypos");
	item[i][11] = rs.getString("Content");
	item[i][12] = "0";
	item[i][13] = rs.getString("URL");
	item[i][14] = rs.getString("Price_area");
	item[i][15] = rs.getString("Period");
	item[i][16] = rs.getString("Part");
	item[i][17] = rs.getString("Hit");
	if(item[i][4].indexOf("남다른") == -1
			&& item[i][4].indexOf("이노") == -1
			&& item[i][4].indexOf("태웅") == -1
			&& item[i][4].indexOf("그레이") == -1
			&& item[i][4].indexOf("JYP") == -1
			&& item[i][4].indexOf("솔트") == -1
			&& item[i][4].indexOf("바르다") == -1
			&& item[i][4].indexOf("굿") == -1
			&& item[i][4].indexOf("AT") == -1
			&& item[i][4].indexOf("아이비") == -1
			&& item[i][4].indexOf("지온") == -1
			&& item[i][4].indexOf("다온") == -1
			&& item[i][4].indexOf("영") == -1
			&& item[i][4].indexOf("상상") == -1)
		continue;
	i++;
}
int itemnum = i;
if(itemnum > 0) {
	for (i = 0; i < itemnum; i++) {
		query = "select * from COMPANY where Name Like \"%" + item[i][4] + "%\"";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			item[i][18] = rs.getString("As_provide");
			item[i][19] = rs.getString("As_warranty");
		}
	}
} else { %>
            <div id="no-result-div" style="text-align:center;">
                <img src="https://somoonhouse.com/otherimg/noun_Astronaut_3328551.svg" />
                <br/>아직은 사례가 없어요.<br/>새로운 사례를 등록해주세요!
            </div>
<% } %>
        </div>
        <%
            //itemnum -> 아이템 개수
            //pageitemnum -> 페이지 총 개수
            //pagenum -> 현재 페이지
            int pageitemnum = 0;
            if(itemnum != 1) pageitemnum = ((itemnum-1)/10)+1;
            else pageitemnum = 1;

            int pagenum = Integer.parseInt(pagenumstr);

        %>
        <%
            int startnum; //시작하는 번호
            int endnum; //끝나는 번호
            if(pagenum == pageitemnum){ //현재페이지 == 페이지 총 개수
                startnum = (10*pagenum)-10;
                endnum = itemnum;
            }
            else{
                startnum = (10*pagenum)-10;
                endnum = 10*pagenum;
            }
            for(i=startnum; i<endnum; i++){
        %>
        <div class="item">
            <%
                pstmt = null;
                query = "SELECT * FROM RMDL_IMG WHERE Number = ? order by Number2 Limit 1";
                rs = null;
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, item[i][0]);
                rs = pstmt.executeQuery();
            %><div class="notslider<%=classes%>" style="overflow:hidden;height:100%;border-radius:7px;"><%
            while(rs.next()){
        %>
            <div class="itemdiv">
                <a href = "_hit1.jsp?num=<%=item[i][0]%>" target="_self">
                    <img src="<%
    		if(rs.getString("Path") == null){
    			out.print("img/not_found.png");
    		}
    		else{
    			out.print(rs.getString("Path").replaceAll("%25", "%").replaceAll("%", "%25"));
    		}
    		%>">
                </a>
            </div>
            <%
                }
            %>
        </div>
        </div>
        <!-- 견적요청버튼 -->
        <a href = "_hit1.jsp?num=<%=item[i][0]%>" target="_self">
            <div class="item">
                <div class="itemdiv">
                    <%classes = Integer.toString(Integer.parseInt(classes)+1);%>
                    <div style="font-size:10px;color:#999999"><%=item[i][4]%></div><!-- 닉넴 -->
                    <%
                        if(item[i][18] != null && item[i][18].equals("1")){%>
                    <div id="as">A/S <%=item[i][19]%></div>
                    <%}%>
                    <div style="font-size:14px;font-weight:bold;margin:8px 0;color:#3d3d3d"><%=item[i][2]%></div>
                    <div style="font-size:9px;color:#363636">조회수 <%=item[i][17]%></div>
                    <!-- div style="font-size:9px;color:#363636">스크랩 12개</div-->
                    <!-- div style="font-size:9px;margin:5px 0;">평당 <%=item[i][14]%>/시공기간 <%=item[i][15]%> 이상</div-->
                    <!-- -->
                    <% if(item[i][5] != null && !(item[i][5].equals("")) && !(item[i][5].equals("NULL"))){%>
                    <div style="font-size:19px;font-weight:bold;margin:25px 0 15px 0;color:#3d3d3d"><%=item[i][5]%>만원</div>
                    <%}%>
                    <!-- div style="font-size:10px;"><span style="border-radius:3px;padding:2px;color:white;background-color:orange"><%/*if(item[i][16].equals("1")) out.println("부분시공불가"); else out.println("부분시공가능");*/%></span></div-->
                    <!-- div>
    	<h2 style="padding:20px;line-height:1.5em;"><%=item[i][2]%></h2>
    	작성일시 : <%=item[i][3]%><br>
    	시공사 : <%=item[i][4]%><br>
    	시공비용 : <%=item[i][5]%><br>
    	상세주소 : <%=item[i][6]%><br>
    	<%=item[i][7]%>
    	<%=item[i][8]%> 동<br>
    	거리 : <%=item[i][12] %><br>
    item[i][14] = rs.getString("Price_area");
	item[i][15] = rs.getString("Period");
	item[i][16] = rs.getString("Part");
    	</div-->
                    <a href="_dropremodeling.jsp?num=<%=item[i][0]%>" target="_blank" style="color:red; text-decoration:underline;">X삭제</a>
                    <a href="remodeling_edit.jsp?num=<%=item[i][0]%>" target="_blank" style="color:blue;text-decoration:underline;">수정</a>
<%--                    <a href="remodeling_form.jsp?item_num=<%=item[i][0]%>"><div class="req_btn"></div></a>--%>
                </div>
            </div>
        </a>
        <%
            }
        %>
    </div>
</div>
</div>
        <div class="pagenumber"> <%
            if(pageitemnum == 0){
        %>사례를 준비중 입니다.<%
            }
            if(pageitemnum == 1){ // 총 페이지 개수 :1
        %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1" style="color:blue;"><b>1</b></a> <!-- index.jsp?pagenumstr=1 -->
            <%
            }
            else if(pageitemnum == 2){ // 총 페이지 개수 :2
                if(pagenum == 1){
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1" style="color:blue;"><b>1</b></a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=2 -->
            <%
            }
            else{
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2" style="color:blue;"><b>2</b></a> <!-- index.jsp?pagenumstr=2 -->
            <%
                }
            }
            else if(pageitemnum == 3){ //총 페이지 개수 :3
                if(pagenum == 1){
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1" style="color:blue;"><b>1</b></a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
            <%
            }
            else if(pagenum == 2){
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2" style="color:blue;"><b>2</b></a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
            <%
            }
            else{
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3" style="color:blue;"><b>3</b></a> <!-- index.jsp?pagenumstr=2 -->
            <%
                }
            }
            else if(pageitemnum == 4){//총 페이지 개수 :4
                if(pagenum == 1){
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1" style="color:blue;"><b>1</b></a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
            <%
            }
            else if(pagenum == 2){
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2" style="color:blue;"><b>2</b></a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
            <%
            }
            else if(pagenum == 3){
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3" style="color:blue;"><b>3</b></a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
            <%
            }
            else{
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="4" style="color:blue;"><b>4</b></a> <!-- index.jsp?pagenumstr=2 -->
            <%
                }
            }
            else if(pageitemnum == 5){//총 페이지 개수 :5
                if(pagenum == 1){
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1" style="color:blue;"><b>1</b></a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="5">5</a> <!-- index.jsp?pagenumstr=2 -->
            <%
            }
            else if(pagenum == 2){
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2" style="color:blue;"><b>2</b></a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="5">5</a> <!-- index.jsp?pagenumstr=2 -->
            <%
            }
            else if(pagenum == 3){
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3" style="color:blue;"><b>3</b></a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="5">5</a> <!-- index.jsp?pagenumstr=2 -->
            <%
            }
            else if(pagenum == 4){
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="4" style="color:blue;"><b>4</b></a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="5">5</a> <!-- index.jsp?pagenumstr=2 -->
            <%
            }
            else{
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="5" style="color:blue;"><b>5</b></a> <!-- index.jsp?pagenumstr=2 -->
            <%
                }
            }
            //전체 5페이지이상
            else if(pagenum == 1){//맨 앞%>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1" style="color:blue;"><b>1</b></a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="5">5</a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>">다음</a>
            <%
            }
            else if(pagenum == 2){//두번째%>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1">이전</a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="2" style="color:blue;"><b>2</b></a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="5">5</a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>">다음</a>
            <%
            }
            else if(pagenum == pageitemnum){ //맨 뒤
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-1%>">이전</a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-4%>"><%=pagenum-4%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-3%>"><%=pagenum-3%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-2%>"><%=pagenum-2%></a> <!-- index.jsp?pagenumstr=<%=pagenum%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-1%>"><%=pagenum-1%></a> <!-- index.jsp?pagenumstr=<%=pagenum+1%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum%>" style="color:blue;"><b><%=pagenum%></b></a> <!-- index.jsp?pagenumstr=<%=pagenum%> -->
            <%
            }
            else if(pagenum == pageitemnum-1){ //맨 뒤에서 두번째
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-1%>">이전</a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-3%>"><%=pagenum-3%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-2%>"><%=pagenum-2%></a> <!-- index.jsp?pagenumstr=<%=pagenum%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-1%>"><%=pagenum-1%></a> <!-- index.jsp?pagenumstr=<%=pagenum+1%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum%>" style="color:blue;"><b><%=pagenum%></b></a> <!-- index.jsp?pagenumstr=<%=pagenum%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>"><%=pagenum+1%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>">다음</a>
            <%
            }
            else{ //중간
            %>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-1%>">이전</a>
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-2%>"><%=pagenum-2%></a> <!-- index.jsp?pagenumstr=<%=pagenum%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-1%>"><%=pagenum-1%></a> <!-- index.jsp?pagenumstr=<%=pagenum+1%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum%>" style="color:blue;"><b><%=pagenum%></b></a> <!-- index.jsp?pagenumstr=<%=pagenum%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>"><%=pagenum+1%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+2%>"><%=pagenum+2%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
            <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>">다음</a>
            <%
                }
            %>
        </div>
    </div>
    <%
        pstmt.close();
        rs.close();
        query="";
        conn.close();
    %>
</div>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
    function ajax_click(obj){
        var pagenumber = $(obj).attr("title");
        if(pagenumber == null) pagenumber=1;
        location.href = "company_remodeling.jsp?pagenumstr="+pagenumber;
    }
</script>
</body>
</html>