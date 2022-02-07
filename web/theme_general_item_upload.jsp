<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 31536000);
%>
<%
    int i;
    String classes = "0";
%>
<%
    String[] request_areas = request.getParameterValues("Daegu");
    if(request_areas==null || request_areas[0].equals("undefined")){
        request_areas = new String[9];
        request_areas[0] = "all";
    }

    String apartment = request.getParameter("Apart")+"";
    if(apartment == null || apartment.equals("null")){
        apartment = "";
        session.setAttribute("apartment", "");
    }
    else{
        session.setAttribute("apartment", apartment);
    }
%>
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
    session.setAttribute("page", "theme_display_upload.jsp"); // 현재 페이지 current page
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
    //CSRF 방지를 위한 상태 토큰 검증
    //세션 또는 별도의 저장 공간에 저장된 상태 토큰과 콜백으로 전달받은 state 파라미터 값이 일치해야 함
    //콜백 응답에서 state 파라미터의 값을 가져옴
    state = request.getParameter("state");
%><%
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
    String theme = null;
    build = request.getParameter("bdNm");
    theme = request.getParameter("theme_id");
    query = "Select * from REMODELING";

    if(theme != "" && theme != null){
        query = "Select *" +
                " From REMODELING" +
                " Where Number NOT IN (" +
                " Select Item_id" +
                " From THEME_ASSIGNED" +
                " Where theme_id = ?)";
        //query = "select * from REMODELING R, THEME_ASSIGNED A where R.Number = A.Item_id and A.theme_id = ?";
    }
    if(build != "" && build != null && !build.equals("all")){
        query += " and Apart_name Like \"%"+build+"%\"";
        query += " or Title Like \"%"+build+"%\"";
        query += " or Company Like \"%"+build+"%\"";
    }

    else if(request_areas != null && !request_areas[0].equals("all")){
        if(request_areas[0].equals("15")){
            query += " Where Root_area = " + request_areas[0];
        }
        else{
            query += " Where Second_area = " + request_areas[0];
        }
        for(i = 1; i < request_areas.length; i++){
            query += " Or Second_area = " + request_areas[i];
        } //147
        if(apartment != "" && apartment != null && !apartment.equals("all")){
            query += " And Apart_name Like \"%"+apartment+"%\"";
        }
    }
    query += " order by Apart_name asc"; //limit 10
    pstmt = conn.prepareStatement(query);
    pstmt.setString(1, theme);
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
                && item[i][4].indexOf("상상하우징") == -1)
            continue;
        //거리계산//item[i][12] = String.valueOf(Math.sqrt(((x-Float.parseFloat(item[i][10]))*(x-Float.parseFloat(item[i][10])))+((y-Float.parseFloat(item[i][9]))*(y-Float.parseFloat(item[i][9])))));
        //if(item[i][4].indexOf("오픈하우스") == -1) continue; 오픈하우스를 오픈함
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
    }
    else {

    }

    //itemnum -> 아이템 개수
    //pageitemnum -> 페이지 총 개수
    //pagenum -> 현재 페이지
    int pageitemnum = 0;
    if(itemnum != 1) pageitemnum = ((itemnum-1)/20)+1;
    else pageitemnum = 1;
    int pagenum = Integer.parseInt(pagenumstr);
    int startnum; //시작하는 번호
    int endnum; //끝나는 번호
    if(pagenum == pageitemnum){ //현재페이지 == 페이지 총 개수
        startnum = (20*pagenum)-20;
        endnum = itemnum;
    }
    else{
        startnum = (20*pagenum)-20;
        endnum = 20*pagenum;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/attach_keyword.css"/>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
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
    <div id="main">
        <form action="index.jsp" method="GET">

        </form>
        <div>
            <form id="form" name="form" method="POST" action="theme_general_item_upload.jsp">
                <input type="hidden" name="theme_id" value="<%=theme%>">
                <div id="searcharea">
                    <input type="text" id="bdNm"  name="bdNm" placeholder="아파트명, 회사명으로 사례를 찾아보세요"/>
                    <input type="button" onClick="goPopup();" value="주소찾기" id="jusobtn"/>
                    <input id="search" type="submit" value="">
                </div>
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
            <div id="content" style="float:left;width:100%;">
                <!-- jsp:include page="navbar.jsp" flush="false"/ -->
                <%if(itemnum < 0) { %>
                <div id="no-result-div" style="text-align:center;">
                    <img src="https://somoonhouse.com/otherimg/noun_Astronaut_3328551.svg" />
                    <br/>아직은 사례가 없어요.<br/>
                    <h2 id="user-input">"<%
                        out.println(build);
                    %>"</h2>
                    정확한 아파트명/화사명으로 검색했나요?
                </div>
                <% }
                    if(s_id.equals("100"))
                    {%>
                <div style="width:100%;text-align:center;margin-bottom:20px;">
                    <button onclick="goRecItemUpload();" style="width:150px;height:45px;margin:40px 15px;border-radius:5px; background-color:#29aef2; color:white; font-size:17px; border:none;">추천사례등록  ></button>
                    <button onclick="goItemUpload();" style="width:150px;height:45px;margin:40px 15px;border-radius:5px; background-color:#29aef2; color:white; font-size:17px; border:none;">사례등록  ></button>
                </div>
                <%}%>
                <form action="_theme_general_item_upload.jsp">
                    <input type="hidden" name="theme_id" value="<%=theme%>">
                    <%
                        for(i=startnum; i<endnum; i++){
                    %>
                    <div class="checking" style="display:inline-block; height: 170px">
                        <input type="checkbox" name="attach" value="<%=item[i][0]%>">
                    </div>
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
                                <img src="<%=rs.getString("Path").replaceAll("%25", "%").replaceAll("%", "%25")%>">
                            </a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                        <script>
                            $(document).ready(function(){slicky(".slider<%=classes%>")});
                        </script>
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
                                <!--
    	<%
    	if(item[i][5] == null){
    		%><div style="font-size:19px;font-weight:bold;margin:25px 0 15px 0;color:#3d3d3d"><%=item[i][5]%>만원</div><%
    	}
    	%> -->
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

                                <%
                                    if(s_id.equals("100") || s_id.equals(item[i][1]))//관리자 계정이거나 본인 글 일 경우
                                    {%>
                                <a href="_dropremodeling.jsp?num=<%=item[i][0]%>" target="_blank" style="color:red; text-decoration:underline;">X삭제</a>
                                <a href="remodeling_edit.jsp?num=<%=item[i][0]%>" target="_blank" style="color:blue;text-decoration:underline;">수정</a>
                                <%}%>
                                <a href="remodeling_form.jsp?item_num=<%=item[i][0]%>"><div class="req_btn"></div></a>
                            </div>
                        </div>
                    </a>
                    <%
                        }
                    %>
                    <input type="submit" id="attach_submit" value="이 사례 추가">
                    <span id="attach_desc">페이지를 넘어가면 체크된 사례가 저장되지 않습니다!</span>
                </form>
            </div>
        </div>
    </div>
    <div class="pagenumber"><%
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
        <a class="pageidx" onClick="ajax_click(this)" href="#" title="1"ㄲ style="color:blue;"><b>1</b></a> <!-- index.jsp?pagenumstr=1 -->
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
        <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-2%>"><%=pagenum-2%></a>dff <!-- index.jsp?pagenumstr=<%=pagenum%> -->
        <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-1%>"><%=pagenum-1%></a> <!-- index.jsp?pagenumstr=<%=pagenum+1%> -->
        <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum%>" style="color:blue;"><b><%=pagenum%></b></a> <!-- index.jsp?pagenumstr=<%=pagenum%> -->
        <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>"><%=pagenum+1%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
        <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+2%>"><%=pagenum+2%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
        <a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>">다음</a>
        <%
            }
        %>
    </div>
    <%
        pstmt.close();
        rs.close();
        query="";
        conn.close();
    %>
    <!-- jsp:include page="footer.jsp" flush="false"/ -->
    <script>
        function ajax_click(obj){
            var a = $(obj).attr("class");
            <%String ApArt = session.getAttribute("apartment") + "";%>
            var Daegu = $("input[name='Daegu']:checked").val();
            var pagenumber = $(obj).attr("title");
            var apartment = "<%=build%>";
            if(apartment == "null") apartment="";
            if(pagenumber == null) pagenumber=1;
            if(a=="pageidx"){
                location.href = "attach_keyword.jsp?Daegu="+Daegu+"&pagenumstr="+pagenumber+"&bdNm="+apartment+"&keyword="+keyword;
            }
            else{
                location.href = "index.jsp?Daegu="+Daegu+"&pagenumstr="+pagenumber;
            }
        }
    </script>
    <script>
        function frame(){
            var div = $(".center div"); // 이미지를 감싸는 div
            var img = $(".eotkd"); // 이미지
            var divWidth = div[0].offsetWidth
            var divHeight = div[0].offsetHeight-10;
            if(divWidth >= 510){
                divHeight -= 10;
                divWidth -= 120;
                //alert("넓");
            }
            else{
                divWidth -= 110;
                //alert("안넓");
            }
            var divAspect = divHeight / divWidth; // div의 가로세로비는 알고 있는 값이다 세로/가로
            //alert("divWidth : "+ divWidth);
            //alert("divHeight : " + divHeight);
            for(var i=0; i<img.length; i++){
                var imgAspect = img[i].height / img[i].width;
                if (imgAspect <= divAspect) {
                    // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
                    var imgWidthActual = divHeight / imgAspect;
                    var imgWidthToBe = divHeight / divAspect;
                    var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2);
                    img[i].style.cssText = 'width: auto; height: 100%; margin-left: '
                        + marginLeft + 'px;';
                    //alert('납');
                    //alert('imgWidthToBe' + imgWidthToBe);
                    //alert('imgWidthActual' + imgWidthActual);
                } else {
                    // 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
                    var imgHeightActual = divWidth * imgAspect;
                    var imgHeightToBe = divWidth * divAspect;
                    //alert("imgHeightActual" + imgHeightActual);
                    //alert("imgHeightToBe" + imgHeightToBe);
                    var marginTop = -Math.round((imgHeightActual - imgHeightToBe) / 2);
                    img[i].style.cssText = 'width: 100%; height: auto; margin-left: 0; margin-top: '
                        + marginTop + 'px;';
                    //alert("길");
                }
            }
        }

        $(window).resize(function(){
            frame()
        });
        $(document).ready(function(){
            frame()
        });
    </script>
    <script>
        $(document).ready(function(){
            $('.center').slick({
                centerMode: true,
                centerPadding: '50px',
                slidesToShow: 1,
                autoplay: true,
                autoplaySpeed: 3000,
                arrows: false
            });
        })
    </script>
    <script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
    <script type="text/javascript">
        if(!wcs_add) var wcs_add = {};
        wcs_add["wa"] = "3602e31fd32c7e";
        wcs_do();

        function goRecItemUpload(){
            window.open("recommend_item_upload.jsp","pop");
        }

        function goItemUpload(){
            window.open("item_upload.jsp","pop");
        }
    </script>
    <script>
        function slicky(a){
            if( $(a).hasClass('slick-initialized') ){
                $(a).slick('unslick');//슬릭해제

            }
            else{
                $(a).slick({
                    lazyLoad: 'ondemand',
                    dots: true,
                    arrows:true,
                    //autoplay: true,
                    autoplaySpeed: 2000
                });
            }
        }
    </script>
    <script language="javascript">
        function goPopup(){
            // 주소검색을 수행할 팝업 페이지를 호출합니다.
            // 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrCoordUrl.do)를 호출하게 됩니다.
            var pop = window.open("jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
        }
        function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo,entX,entY){
            // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
            document.form.roadFullAddr.value = roadFullAddr;
            document.form.roadAddrPart1.value = roadAddrPart1;
            document.form.roadAddrPart2.value = roadAddrPart2;
            document.form.addrDetail.value = addrDetail;
            document.form.engAddr.value = engAddr;
            document.form.jibunAddr.value = jibunAddr;
            document.form.zipNo.value = zipNo;
            document.form.admCd.value = admCd;
            document.form.rnMgtSn.value = rnMgtSn;
            document.form.bdMgtSn.value = bdMgtSn;
            document.form.detBdNmList.value = detBdNmList;
            document.form.bdNm.value = bdNm;
            document.form.bdKdcd.value = bdKdcd;
            document.form.siNm.value = siNm;
            document.form.sggNm.value = sggNm;
            document.form.emdNm.value = emdNm;
            document.form.liNm.value = liNm;
            document.form.rn.value = rn;
            document.form.udrtYn.value = udrtYn;
            document.form.buldMnnm.value = buldMnnm;
            document.form.buldSlno.value = buldSlno;
            document.form.mtYn.value = mtYn;
            document.form.lnbrMnnm.value = lnbrMnnm;
            document.form.lnbrSlno.value = lnbrSlno;
            document.form.emdNo.value = emdNo;
            document.form.entX.value = entX;
            document.form.entY.value = entY;
        }
    </script>
    <script>
        var topEle = $('#topBtn');
        var delay = 1000;
        topEle.on('click', function(){
            $('html, body').stop().animate({scrollTop:0}, delay);
        })
    </script>
    <script>
        var applyEle = $('#applyBtn');
        applyEle.on('click', function(){
            location.href = "remodeling_form.jsp?item_num=0";
        })
    </script>
    <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
</div>
</body>
</html>