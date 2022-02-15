<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<%
    String clientId = "G8MVoxXfGciyZW5dF4p1";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://somoonhouse.com/callback.jsp", "UTF-8");
    SecureRandom random = new SecureRandom();
    String s_state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&state=" + s_state;
    apiURL += "&redirect_uri=" + redirectURI;
    session.setAttribute("state", s_state);
%>
<%
    //DB에 사용 할 객체들 정의
    Connection conn = DBUtil.getMySQLConnection();
    PreparedStatement pstmt = null;
    Statement stmt = null;
    String query = "";
    String sql = "";
    ResultSet rs = null;

    //세션 생성 create session
    session.setAttribute("page", "new_company_request.jsp"); // 현재 페이지 current page

    //세션 가져오기 get session
    String now = session.getAttribute("page")+""; // 현재 페이지 current page
    String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
    String name = session.getAttribute("name")+"";

    int cnt = 0;
    String apply_num = "";
    String state_eng = "";
    String state = "";
    String item_number = "";
    String item_itemnum = "";
    String item_name = "";
    String item_phone = "";
    String item_address = "";
    String item_building = "";
    String item_area = "";
    String item_due = "";
    String item_budget = "";
    String item_consulting = "";
    String item_compare = "";
    String item_modifydate = "";
    String item_state = "";
    String item_memo = "";
    String item_detail1 = "";
    String item_detail2 = "";
    String[] building_types = {"아파트", "빌라", "주택", "원룸"};
%>

<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
<%--    <link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick.css"/>--%>
<%--    <link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick-theme.css"/>--%>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/company_request.css">
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
        <!-- nav -->
        <div id="somun_navbar">
            <div id="somun_logo"><a href="index.jsp"><img style="height:30px;"src="https://somoonhouse.com/otherimg/index/somunlogo.jpg"></a></div>
            <div id="alert"><a href="alert.jsp"><img style="height:30px;"src="https://somoonhouse.com/otherimg/index/alert.jpg"></a></div>
        </div>

        <!-- tab -->
        <tab class="nav-tabs nav-justify">
            <div>
                <a class="nav-item nav-link" href="#new">신규</a>
                <a class="nav-item nav-link" href="#ongoing">진행중</a>
                <a class="nav-item nav-link" href="#done">완료</a>
                <a class="nav-item nav-link" href="#aborted">중단</a>
            </div>
        </tab>

        <div class="tab-content">
            <!-- 신규 페이지 -->
            <div id="new" class="tab-pane fade show active">
                <div class="new_container">
                <%
                    cnt = 0;
                    query = "select * from ASSIGNED WHERE Company_num = '" + s_id + "' AND State < 2";
                    pstmt = conn.prepareStatement(query);
                    rs = pstmt.executeQuery();
                    while(rs.next()) {
                        cnt ++;
                    }
                    if(cnt == 0) {
                %>
                    <div class="no_cases">
                        <img src="https://somoonhouse.com/otherimg/cute_animal.png" style="width: 300px;"/>
                        <div class="no_case_desc">신규 견적이 없네요.</div>
                    </div>
                <%} else {%>
                있습니당
                <%}%>
                </div>
            </div>
            <!-- 진행중 페이지 -->
            <div id="ongoing" class="tab-pane fade">
                <div class="ongoing_container">
                <%
                    cnt = 0;
                    query = "select * from ASSIGNED WHERE Company_num = '" + s_id + "' AND State < 8 AND State > 2";
                    pstmt = conn.prepareStatement(query);
                    rs = pstmt.executeQuery();
                    while(rs.next()) {
                        cnt ++;
                    }
                    if(cnt == 0) {
                %>
                    <div class="no_cases">
                        <img src="https://somoonhouse.com/otherimg/cute_animal.png" style="width: 300px;"/>
                        <div class="no_case_desc">아직 진행중인 상담이 없네요.</div>
                    </div>
                <%} else {%>
                있습니당
                <%}%>
                </div>
            </div>
            <!-- 완료 페이지 -->
            <div id="done" class="tab-pane fade">
                <div class="done_container">
                    <div class="search_item1">
                        <form id="form_done" name="form" method="POST" action="new_company_request.jsp#done">
                            <div class="search_area">
                                <img src="https://somoonhouse.com/img/search_btn.png" style="margin-left: 20px; width: 25px;"/>
                                <input type="text" name="done" style="width: 60%;" placeholder="전화, 고객명, 주소"/>
                                <input type="submit" value="검색" />
                            </div>
                        </form>
                    </div>
                    <%
                        cnt = 0;
                        String done_search = request.getParameter("done");
                        LinkedList<LinkedHashMap<String, String>> donelist = new LinkedList<LinkedHashMap<String, String>>();

                        query = "select * from ASSIGNED WHERE Company_num = '" + s_id + "' AND State = 8";
                        pstmt = conn.prepareStatement(query);
                        rs = pstmt.executeQuery();
                        LinkedHashMap<String, String> donemap = new LinkedHashMap<String, String>();
                        while(rs.next()) {
                            cnt ++;
                            apply_num = rs.getString("Apply_num");
                            item_modifydate = rs.getString("Modify_date");
                            if(item_modifydate == null) item_modifydate = "-";
                            donemap.put(apply_num, item_modifydate);
                        }
                        if(cnt == 0) {
                    %>
                    <div class="no_cases">
                        <img src="https://somoonhouse.com/otherimg/cute_animal.png" style="width: 300px;"/>
                        <div class="no_case_desc">아직 완료된 공사가 없네요.</div>
                    </div>
                    <%} else {
                        donelist.clear();
                        if(done_search != null && done_search != "") {
                            query = "select * from REMODELING_APPLY r, ASSIGNED a where r.Number = a.Apply_num AND a.State = 8 AND a.Company_num = '" + s_id + "' AND (r.Name Like \"%" + done_search + "%\" OR r.Phone Like \"%" + done_search + "%\" OR r.Address Like \"%" + done_search + "%\")";
                            pstmt = conn.prepareStatement(query);
                            rs = pstmt.executeQuery();
                            while(rs.next()) {
                                LinkedHashMap done = new LinkedHashMap<String, String>();

                                item_number = rs.getString("r.Number");
                                item_name = rs.getString("r.Name");
                                item_phone = rs.getString("r.Phone");
                                item_address = rs.getString("r.Address");
                                item_area = rs.getString("r.Area");
                                item_due = rs.getString("r.Due");
                                item_budget = rs.getString("r.Budget");
                                item_building = rs.getString("r.Building_type");
                                //빌딩타입 한글로 변경
                                if(item_building != null && !item_building.equals("null")){
                                    item_building = building_types[Integer.parseInt(item_building)];
                                }
                                else {
                                    item_building = "정보없음";
                                }
                                item_modifydate = rs.getString("a.Modify_date");
                                if(item_modifydate == null) item_modifydate = "-";


                                done.put("number", item_number);
                                done.put("name", item_name);
                                done.put("phone", item_phone);
                                done.put("address", item_address);
                                done.put("building", item_building);
                                done.put("area", item_area);
                                done.put("due", item_due);
                                done.put("budget", item_budget);
                                done.put("modified_date", item_modifydate);

                                donelist.add(done);
                            }
                            for(LinkedHashMap<String, String> dn : donelist) {
                                query = "select * from REMODELING_APPLY ra, REMODELING_APPLY_DIV2 rad, RMDL_DIV1 rd, RMDL_DIV2 rd2 where ra.Number = " + dn.get("number") + " and ra.Number = rad.Apply_num And rad.Div2_num = rd2.Id and rd2.Parent_id = rd.Id";
                                pstmt = conn.prepareStatement(query);
                                rs = pstmt.executeQuery();

                                while(rs.next()){
                                    item_detail1 = rs.getString("rd.Name");
                                    item_detail2 = rs.getString("rd2.Name");
                                    dn.put("detail", item_detail1+"/"+item_detail2);
                                }
                            }
                        } else {
                            for (String key : donemap.keySet()) {
                                LinkedHashMap done = new LinkedHashMap<String, String>();

                                query = "select * from REMODELING_APPLY where Number = ?";
                                pstmt = conn.prepareStatement(query);
                                pstmt.setString(1, key);
                                rs = pstmt.executeQuery();
                                while (rs.next()) {
                                    item_number = rs.getString("Number");
                                    item_name = rs.getString("Name");
                                    item_phone = rs.getString("Phone");
                                    item_address = rs.getString("Address");
                                    item_area = rs.getString("Area");
                                    item_due = rs.getString("Due");
                                    item_budget = rs.getString("Budget");
                                    item_building = rs.getString("Building_type");
                                    //빌딩타입 한글로 변경
                                    if(item_building != null && !item_building.equals("null")){
                                        item_building = building_types[Integer.parseInt(item_building)];
                                    }
                                    else {
                                        item_building = "정보없음";
                                    }
                                    item_modifydate = donemap.get(key);


                                    done.put("number", item_number);
                                    done.put("name", item_name);
                                    done.put("phone", item_phone);
                                    done.put("address", item_address);
                                    done.put("building", item_building);
                                    done.put("area", item_area);
                                    done.put("due", item_due);
                                    done.put("budget", item_budget);
                                    done.put("modified_date", item_modifydate);

                                    donelist.add(done);
                                }
                            }
                            for(LinkedHashMap<String, String> dn : donelist) {
                                query = "select * from REMODELING_APPLY ra, REMODELING_APPLY_DIV2 rad, RMDL_DIV1 rd, RMDL_DIV2 rd2 where ra.Number = " + dn.get("number") + " and ra.Number = rad.Apply_num And rad.Div2_num = rd2.Id and rd2.Parent_id = rd.Id";
                                pstmt = conn.prepareStatement(query);
                                rs = pstmt.executeQuery();

                                while(rs.next()){
                                    item_detail1 = rs.getString("rd.Name");
                                    item_detail2 = rs.getString("rd2.Name");
                                    dn.put("detail", item_detail1+"/"+item_detail2);
                                }
                            }
                        }

                        for(LinkedHashMap<String, String> dn : donelist) {
                    %>
                        <div class="done_card" id="dn<%=dn.get("number")%>">
                            <div class="done_card_left">
                                <div class="done_info">
                                    <span class="done_name"><%=dn.get("name")%></span>
                                    <span class="vertical_divider">|</span>
                                    <span class="done_address"><%=dn.get("address")%></span>
                                </div>
                                <div class="done_date">공사 완료: <%=dn.get("modified_date")%></div>
                            </div>
                            <div class="done_card_right"><div class="right-arrow">></div></div>
                        </div>
                    <%}
                    }%><%
                    for(LinkedHashMap<String, String> dn : donelist){
                %>
                    <div class="done_modal" id="done_modal<%=dn.get("number")%>">
                        <div class="close">X</div>
                        <div class="modal_info" style="font-size: large; line-height: normal;"><span style="font-weight: bold; font-size: large !important;"><%=dn.get("name")%> | </span><%=dn.get("address")%> (<%=dn.get("area")%> 평)</div>
                        <div class="modal_info"><span class="modal_info_left">건물종류</span><%=dn.get("building")%></div>
                        <div class="modal_info"><span class="modal_info_left">예정일</span><%=dn.get("due")%></div>
                        <div class="modal_info"><span class="modal_info_left">예산</span><%=dn.get("budget")%></div>
                        <div class="modal_info"><span class="modal_info_left">상세내용</span><%=dn.get("detail")%></div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
            <!-- 중단 페이지 -->
            <div id="aborted" class="tab-pane fade">
                <div class="aborted_container">
                    <div class="search_item1">
                        <form id="form_aborted" name="form" method="POST" action="new_company_request.jsp#aborted">
                            <div class="search_area">
                                <img src="https://somoonhouse.com/img/search_btn.png" style="margin-left: 20px; width: 25px;"/>
                                <input type="text" name="aborted" style="width: 60%;" placeholder="전화, 고객명, 주소"/>
                                <input type="submit" value="검색" />
                            </div>
                        </form>
                    </div>
                    <%
                        cnt = 0;
                        String aborted_search = request.getParameter("aborted");
                        LinkedList<LinkedHashMap<String, String>> abortedlist = new LinkedList<LinkedHashMap<String, String>>();

                        query = "select * from ASSIGNED WHERE Company_num = '" + s_id + "' AND State > 8";
                        pstmt = conn.prepareStatement(query);
                        rs = pstmt.executeQuery();
                        LinkedHashMap<String, String> abortedmap = new LinkedHashMap<String, String>();
                        while(rs.next()) {
                            cnt ++;
                            apply_num = rs.getString("Apply_num");
                            item_modifydate = rs.getString("Modify_date");
                            if(item_modifydate == null) item_modifydate = "-";
                            abortedmap.put(apply_num, item_modifydate);
                        }

                        if(cnt == 0) {
                    %>
                    <div class="no_cases">
                        <img src="https://somoonhouse.com/otherimg/cute_animal.png" style="width: 300px;"/>
                        <div class="no_case_desc">아직 중단된 신청이 없네요.</div>
                    </div>
                    <%} else {
                            abortedlist.clear();
                            if(aborted_search != null && aborted_search != "") {
                                query = "select * from REMODELING_APPLY r, ASSIGNED a where r.Number = a.Apply_num AND a.State > 8 AND a.Company_num = '" + s_id + "' AND (r.Name Like \"%" + aborted_search + "%\" OR r.Phone Like \"%" + aborted_search + "%\" OR r.Address Like \"%" + aborted_search + "%\")";
                                pstmt = conn.prepareStatement(query);
                                rs = pstmt.executeQuery();
                                while(rs.next()) {
                                    LinkedHashMap aborted = new LinkedHashMap<String, String>();

                                    item_number = rs.getString("r.Number");
                                    item_name = rs.getString("r.Name");
                                    item_phone = rs.getString("r.Phone");
                                    item_address = rs.getString("r.Address");
                                    item_area = rs.getString("r.Area");
                                    item_due = rs.getString("r.Due");
                                    item_budget = rs.getString("r.Budget");
                                    item_building = rs.getString("r.Building_type");
                                    //빌딩타입 한글로 변경
                                    if(item_building != null && !item_building.equals("null")){
                                        item_building = building_types[Integer.parseInt(item_building)];
                                    }
                                    else {
                                        item_building = "정보없음";
                                    }
                                    item_modifydate = rs.getString("a.Modify_date");
                                    if(item_modifydate == null) item_modifydate = "-";
                                    item_memo = rs.getString("a.Memo");
                                    if(item_memo == null) item_memo = "";
                                    item_state = rs.getString("a.state");


                                    aborted.put("number", item_number);
                                    aborted.put("name", item_name);
                                    aborted.put("phone", item_phone);
                                    aborted.put("address", item_address);
                                    aborted.put("building", item_building);
                                    aborted.put("area", item_area);
                                    aborted.put("due", item_due);
                                    aborted.put("budget", item_budget);
                                    aborted.put("modified_date", item_modifydate);
                                    aborted.put("memo", item_memo);
                                    aborted.put("state", item_state);

                                    abortedlist.add(aborted);
                                }
                                for(LinkedHashMap<String, String> ab : abortedlist) {
                                    query = "select * from REMODELING_APPLY ra, REMODELING_APPLY_DIV2 rad, RMDL_DIV1 rd, RMDL_DIV2 rd2 where ra.Number = " + ab.get("number") + " and ra.Number = rad.Apply_num And rad.Div2_num = rd2.Id and rd2.Parent_id = rd.Id";
                                    pstmt = conn.prepareStatement(query);
                                    rs = pstmt.executeQuery();

                                    while(rs.next()){
                                        item_detail1 = rs.getString("rd.Name");
                                        item_detail2 = rs.getString("rd2.Name");
                                        ab.put("detail", item_detail1+"/"+item_detail2);
                                    }
                                }
                            } else {
                                for(String key : abortedmap.keySet()){
                                    LinkedHashMap aborted = new LinkedHashMap<String, String>();

                                    query = "select * from REMODELING_APPLY ra, ASSIGNED a where Number = ? AND ra.Number= a.Apply_num AND a.Company_num = '" + s_id + "'";
                                    pstmt = conn.prepareStatement(query);
                                    pstmt.setString(1, key);
                                    rs = pstmt.executeQuery();
                                    while(rs.next()){
                                        item_number = rs.getString("ra.Number");
                                        item_name = rs.getString("ra.Name");
                                        item_phone = rs.getString("ra.Phone");
                                        item_address = rs.getString("ra.Address");
                                        item_area = rs.getString("ra.Area");
                                        item_due = rs.getString("ra.Due");
                                        item_budget = rs.getString("ra.Budget");
                                        item_building = rs.getString("ra.Building_type");
                                        item_state = rs.getString("a.State");
                                        //빌딩타입 한글로 변경
                                        if(item_building != null && !item_building.equals("null")){
                                            item_building = building_types[Integer.parseInt(item_building)];
                                        }
                                        else {
                                            item_building = "정보없음";
                                        }
                                        item_modifydate = abortedmap.get(key);


                                        aborted.put("number", item_number);
                                        aborted.put("name", item_name);
                                        aborted.put("phone", item_phone);
                                        aborted.put("address", item_address);
                                        aborted.put("building", item_building);
                                        aborted.put("area", item_area);
                                        aborted.put("due", item_due);
                                        aborted.put("budget", item_budget);
                                        aborted.put("modified_date", item_modifydate);
                                        aborted.put("state", item_state);

                                        abortedlist.add(aborted);
                                    }
                                }
                                for(LinkedHashMap<String, String> ab : abortedlist) {
                                    query = "select * from REMODELING_APPLY ra, REMODELING_APPLY_DIV2 rad, RMDL_DIV1 rd, RMDL_DIV2 rd2 where ra.Number = " + ab.get("number") + " and ra.Number = rad.Apply_num And rad.Div2_num = rd2.Id and rd2.Parent_id = rd.Id";
                                    pstmt = conn.prepareStatement(query);
                                    rs = pstmt.executeQuery();

                                    while(rs.next()){
                                        item_detail1 = rs.getString("rd.Name");
                                        item_detail2 = rs.getString("rd2.Name");
                                        ab.put("detail", item_detail1+"/"+item_detail2);
                                    }
                                }
                            }
                            for(LinkedHashMap<String, String> ab : abortedlist) {
                    %>
                    <div id="ab<%=ab.get("number")%>" class="aborted_card">
                        <div class="aborted_card_left">
                            <div class="aborted_info">
                                <span class="aborted_name"><%out.println(ab.get("name"));%></span>
                                <span class="vertical_divider">|</span>
                                <span class="aborted_address"><%out.println(ab.get("address"));%></span>
                            </div>
                            <div class="aborted_date">계약 미성사: <%=ab.get("modified_date")%></div>
                        </div>
                        <div class="aborted_card_right"><div class="right-arrow">></div></div>
                    </div>
                    <%}
                    }%><%
                    for(LinkedHashMap<String, String> ab : abortedlist){
                %>
                    <div class="aborted_modal" id="aborted_modal<%=ab.get("number")%>">
                        <div class="close">X</div>
                        <div class="modal_info" style="font-size: large; line-height: normal;"><span style="font-weight: bold; font-size: large !important;"><%=ab.get("name")%> | </span><%=ab.get("address")%> (<%=ab.get("area")%> 평)</div>
                        <div class="modal_info"><span class="modal_info_left">건물종류</span><%=ab.get("building")%></div>
                        <div class="modal_info"><span class="modal_info_left">예정일</span><%=ab.get("due")%></div>
                        <div class="modal_info"><span class="modal_info_left">예산</span><%=ab.get("budget")%></div>
                        <div class="modal_info"><span class="modal_info_left">상세내용</span><%=ab.get("detail")%></div>
                        <div class="modal_info">
                            <form action="_company_request_state.jsp" method="GET" target="_self">
                                <input type="hidden" name="apply_num" value="<%out.print(ab.get("number"));%>">
                                <div class="selectbox">
                                    <select name="state" id="select<%=ab.get("number")%>-<%=ab.get("state")%>">
                                        <option value="9">통화불가</option>
                                        <option value="10">사유입력</option>
                                    </select>
                                </div>
                                <input id="reason<%=ab.get("number")%>" class="reason" type="text" name="reason" value="<%=ab.get("memo")%>">
                                <div class="submit_btn">
                                    <input type="submit" value="수정">
                                </div>
                            </form>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>

        <footer>
            <jsp:include page="footer.jsp" flush="false"/>
        </footer>

        <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
        <script type="text/javascript">
            // 탭 관련 js 코드
            function onLocationChangeHandler() {
                if (location.hash == "#new"){
                    $('.nav-tabs').find('a').eq(0).addClass('active').siblings().removeClass('active');
                    $('.tab-content').find('#new').addClass('show active').siblings().removeClass('show active');
                } else if(location.hash == "#ongoing"){
                    $('.nav-tabs').find('a').eq(1).addClass('active').siblings().removeClass('active');
                    $('.tab-content').find('#ongoing').addClass('show active').siblings().removeClass('show active');
                } else if(location.hash == "#done"){
                    $('.nav-tabs').find('a').eq(2).addClass('active').siblings().removeClass('active');
                    $('.tab-content').find('#done').addClass('show active').siblings().removeClass('show active');
                } else if(location.hash == "#aborted"){
                    $('.nav-tabs').find('a').eq(3).addClass('active').siblings().removeClass('active');
                    $('.tab-content').find('#aborted').addClass('show active').siblings().removeClass('show active');
                }
            }
            window.onhashchange = onLocationChangeHandler;

            $(document).ready(function(){
                onLocationChangeHandler();
            });
        </script>
        <script>
            // modal
            $(".aborted_card").click(function(){
                var div_id = $(this).attr('id');
                var ab_id = div_id.replace("ab", "");
                var modal = $('#aborted_modal'+ab_id);
                var select = modal.find("select").attr('id');
                var state = select.split("-");
                $("#select"+ab_id+"-"+state[1]).val(state[1]);
                if(state[1] == "10") $('#reason'+ab_id).show();
                else $('#reason'+ab_id).hide();
                modal.css("display", "block");
                modal.center();
                $('#'+select).change(function(){
                    var selected = $('option:selected', this).val();
                    if(selected == "10"){
                        $('#reason'+ab_id).show();
                    }else{
                        $('#reason'+ab_id).hide();
                    }
                });
            })
            $(".done_card").click(function(){
                var div_id = $(this).attr('id');
                var ab_id = div_id.replace("dn", "");
                var modal = $('#done_modal'+ab_id);
                modal.css("display", "block");
                modal.center();
            })
            $(".close").click(function(){
                $(this).parent().css("display", "none");
            })
            /*center 함수 재정의*/
            jQuery.fn.center = function () {
                this.css('top', Math.max(0,(($(window).height()-$(this).outerHeight())/2) + $(window).scrollTop())+'px');
                this.css('left', Math.max(0,(($(window).width()-$(this).outerWidth())/2) + $(window).scrollLeft())+'px');
                return this;
            }
        </script>
        <script></script>
    </div>
</body>
</html>