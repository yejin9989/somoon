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
    session.setAttribute("page", "remodeling_request.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
    String now = session.getAttribute("page")+""; // 현재 페이지 current page
    String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
    String name = session.getAttribute("name")+"";

//신청내용들 받아오기
    String state = request.getParameter("state")+"";
    /*
    if(!s_id.equals("100"))
        query = "select * from REMODELING_APPLY where Number < 0";
    else
     */
    query = "select * from REMODELING_APPLY";

//특정상태에 대한 결과를 받아오는 탭일 경우
    if(!state.equals("null") && !state.equals("NULL") && !state.equals("Null") && state != null && !state.contains("6")){
        query += " where State = " + state;
    }
    query += " order by State asc, Number desc";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    out.print(query);
    LinkedList<HashMap<String, String>> itemlist = new LinkedList<HashMap<String, String>>();
    HashMap<String, LinkedList<HashMap<String, String>>> totalstatemap = new HashMap<String, LinkedList<HashMap<String, String>>>();
    while(rs.next()){
        HashMap<String, String> itemmap = new HashMap<String, String>();

        String item_number = rs.getString("Number")+"";
        String item_itemnum = rs.getString("Item_num")+"";
        //String agree = rs.getString("agree");
        String item_name = rs.getString("Name")+"";
        String item_phone = rs.getString("Phone")+"";
        String item_address = rs.getString("Address")+"";
        String item_building = rs.getString("Building_type")+"";
        String item_area = rs.getString("Area")+"";
        String item_due = rs.getString("Due")+"";
        String item_budget = rs.getString("Budget")+"";
        String item_consulting = rs.getString("Consulting")+"";
        String item_compare = rs.getString("compare")+"";
        String item_applydate = rs.getString("Apply_date")+"";
        String item_state = rs.getString("State")+"";
        String item_company = "";
        String item_title = "";
        String item_url = "";
        String item_calling = rs.getString("Calling")+"";
        String item_assigned_time = rs.getString("Assigned_time")+"";
        LinkedList statelist = new LinkedList<HashMap<String, String>>();

        //통합 신청일 경우(item number가 0임)
        if(item_itemnum.equals("0")){
            item_company = "";
            item_title = "통합 신청 버튼으로 신청한 사례";
            item_url = "#";
        }
        //블로그 신청일 경우
        else if(item_itemnum.equals("1")){
            item_company = "";
            item_title = "블로그를 통해 신청한 사례";
            item_url = "#";
        }
        // 일반 사례 신청일 경우
        else{
            //신청한 사례 원본 가져오기
            String query2 = "select * from REMODELING where Number = ?";
            pstmt = conn.prepareStatement(query2);
            pstmt.setString(1, item_itemnum);
            ResultSet rs2 = pstmt.executeQuery();
            while(rs2.next()){
                item_company = rs2.getString("Company");
                item_title = rs2.getString("Title");
                item_url = rs2.getString("URL");
            }
        }
        //빌딩타입 한글로 변경
        if(item_building != null && !item_building.equals("null")){
            String[] building_types = {"아파트", "빌라", "주택", "원룸"};
            item_building = building_types[Integer.parseInt(item_building)];
        }
        else {
            item_building = "정보없음";
        }
        //업체전달 완료일 경우
        if(item_state.equals("1")){
            String status[] = {"신규(대기)", "신규(거절)", "진행중(상담예정)", "진행중(부재중)", "진행중(상담중)", "진행중(미팅예정)", "진행중(계약진행중)", "진행중(계약완료)", "완료(공사완료)", "중단(통화불가)", "중단(사유입력)", "상담취소"};
            String query2 = "select C.Name, A.State from COMPANY C, ASSIGNED A where A.Company_num = C.Id and Apply_num = ?";

            pstmt = conn.prepareStatement(query2);
            pstmt.setString(1, item_number);
            ResultSet rs2 = pstmt.executeQuery();
            while(rs2.next()){
                HashMap<String, String> statemap = new HashMap<String, String>();
                statemap.put("name", rs2.getString("Name"));
                statemap.put("state", status[Integer.parseInt(rs2.getString("State"))]);
                statelist.add(statemap);
            }

        }


        itemmap.put("company", item_company);
        itemmap.put("title", item_title);
        itemmap.put("url", item_url);
        itemmap.put("number", item_number);
        itemmap.put("itemnum", item_itemnum);
        itemmap.put("name", item_name);
        itemmap.put("phone", item_phone);
        itemmap.put("address", item_address);
        itemmap.put("building", item_building);
        itemmap.put("area", item_area);
        itemmap.put("due", item_due);
        itemmap.put("budget", item_budget);
        itemmap.put("consulting", item_consulting);
        itemmap.put("compare", item_compare);
        itemmap.put("applydate", item_applydate);
        itemmap.put("state", item_state);
        itemmap.put("calling", item_calling);
        itemmap.put("assigned_time", item_assigned_time);

        totalstatemap.put(item_number.toString(), statelist);
        itemlist.add(itemmap);
    }

//회사 받아오기
    query = "Select * from COMPANY where State = 1";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    LinkedList<HashMap<String, String>> company = new LinkedList<HashMap<String, String>>();
    while(rs.next()){
        HashMap<String, String> mymap = new HashMap<String, String>();
        mymap.put("id", rs.getString("Id"));
        mymap.put("name", rs.getString("Name"));
        company.add(mymap);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'G-PC15JG6KGN');
    </script>
    <link rel="SHORTCUT ICON" href="img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
    <link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick-theme.css"/>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <style type="text/css">
        @import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
        @font-face{
            font-family:'Nanum Gothic',sans-serif;
        }
        *{
            font-family:'Nanum Gothic',sans-serif;
            font-size: 11pt;
            color: #313131;
            -webkit-appearance: none;
            -webkit-border-radius: 0;
        }
        input[type="checkbox"] {
            display:none;
        }
        input[type="checkbox"] + label span {
            display: inline-block;
            width: 24px;
            height: 24px;
            margin: -2px 10px 0 0;
            vertical-align: middle;
            background: url(https://somoonhouse.com/img/checkbox.svg) left top no-repeat;
            cursor: pointer;
            background-size: cover;
        }
        input[type="checkbox"]:checked + label span {
            background:url(https://somoonhouse.com/img/checkbox.svg)  -26px top no-repeat;
            background-size: cover;
        }
        #container {
            width: 100%;
            max-width: 700px;
            margin: 0 auto;
            box-shadow: 0px 0px 20px #f4f4f4;
        }
        #somun_navbar {
            /*border-bottom: 1px solid #c8c8c8;*/
            display: inline-block;
            height: fit-content;
            width: 100%;
            padding: 39px 0 11px;
        }
        #divider{
            width:100%;
            height:20px;
            border-top: 1px solid black;
            border-radius: 5px;
        }
        #content{
            margin: 60px auto;
            max-width: 600px;
        }
        .item {
            width: 43%;
            display: inline-block;
            margin: 1%;
            border-radius: 5px;
            padding: 2%;
            background: #fbfbfb;
            box-shadow: 0px 0px 6px #e2e2e2;
            height: 1000px;
            float:left;
        }
        .item .no{
            color: #909090;
            font-size: 10pt;
        }
        .item_wrapper{
            padding:20px;
        }
        .item_wrapper div.info{
            margin-bottom: 15px;
            padding-bottom: 4px;
            border-bottom: 3px dotted #e5e5e5;
            width: 91%;
        }
        .phone :after{
            content:"";
        }
        .item_wrapper span{
            display: block;
            font-size:9pt;
            margin-bottom: 5px;
            color:gray;
        }
        #stt0, #stt1, #stt2, #stt3{
            color: white;
            font-size: 9pt;
            border-radius: 5px;
            padding: 1px 4px;
            width: fit-content
        }
        #stt0{
            background: #476aba;
        }
        #stt1{
            background: #ba4747;
        }
        #stt2{
            background: #47ba47;
        }
        #stt3{
            background: #8e47ba;
        }
        .submit_btn{
            text-align:center;
            padding:10px;

        }
        .submit_btn input{
            width: 100%;
            border: none;
            border-radius: 5px;
            height: 32px;
            background: #eaeaea;
        }
        textarea{
            width: 100%;
            font-size: 9pt;
            overflow: hidden;
        }
        .toggle_area{
            position:relative;
            cursor: pointer;
        }
        .assign_company{
            display:none;
        }
        .assign_company div{
            padding-top: 10px;
        }
        #toggle_title{
            left: 13px;
            position: relative;
        }
        #toggle{
            display: inline-block;
            padding: 0 4px 0 0;
            font-size: 7pt;
            color: gray;
            position: absolute;
            top: 50%;
            transform: translate(0, -50%);
        }
        .company_status td, .company_status b{
            font-size: 13px;
        }
        .manager_cancel{
            width: 100%;
            background: #b7b7b7;
            color: white;
            text-align: center;
            padding: 10px 0;
            border-radius: 7px;
            margin: 10px 0;
        }
        .manager_cancel span{
            text-decoration: underline;
            display: inline-block;
            color: white;
            padding: 0 3px 0 0px;
        }
        @media (max-width : 400px){
            /*반응형*/
            .item {
                width: 93%;
            }
        }
    </style>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
<div id="container">
    <div id="somun_navbar">
        <div id="somun_menu"></div>
        <div style="float:left;width:100%;height:max-content;margin-bottom:10px;text-align:center;">
            <div id="somun_logo"><a href="index.jsp"><img style="width:128px;"src="img/somunlogo.png"></a></div>
            <div style="margin:auto;width:max-content;color: #31b1f2;font-size:10pt;">대구 1등 리모델링 플랫폼</div>
        </div>
    </div>
    <div>
        <a href="manage_request.jsp?state=0">미배분</a>
        <a href="manage_request.jsp?state=1">재배분필요</a>
        <a href="manage_request.jsp?state=2">배분중</a>
        <a href="manage_request.jsp?state=3">전체수락</a>
        <a href="manage_request.jsp?state=4">고객취소</a>
        <a href="manage_request.jsp?state=5">관리자삭제</a>
        <a href="manage_request.jsp?state=6">전체보기</a>
    </div>
    <a href="_refresh_request.jsp">새로고침</a>
    <div id="content">
        <div id="sample"></div>
        <div style="width:100%;display:inline-block;border-radius:5px;">
            <%
            %>
            <!------------ 내용물  --------------->
            <div>
                <%
                    //Arraylist- itemlist에 있는 개수만큼 반복하기
                    for(HashMap<String, String> hm : itemlist){
                %>
                <div class="item">
                    <div class="no">no.<%out.println(hm.get("number"));%></div>
                    <div class="item_wrapper">
                        <div class="info"><span><%out.print(hm.get("company"));%></span><a href="<%out.println(hm.get("url"));%>"><%out.println(hm.get("title"));%></a></div>
                        <div class="info"><span>이름</span> <%out.println(hm.get("name"));%></div>
                        <div class="info phone"><span>전화번호</span> <%out.println(hm.get("phone"));%></div>
                        <div class="info"><span>주소</span> <%out.println(hm.get("address"));%></div>
                        <div class="info"><span>건물종류</span> <%out.println(hm.get("building"));%></div>
                        <div class="info"><span>평수</span> <%out.println(hm.get("area"));%></div>
                        <div class="info"><span>예정일</span> <%out.println(hm.get("due"));%></div>
                        <div class="info"><span>예산</span> <%out.println(hm.get("budget"));%></div>
                        <div class="info"><span>방문상담</span> <%if(hm.get("consulting").equals("1")) out.println("예"); else out.println("아니오");%></div>
                        <div class="info"><span>비교견적</span> <%if(hm.get("compare").equals("1")) out.println("예"); else out.println("아니오");%></div>
                        <div class="info"><span>신청날짜</span> <%out.println(hm.get("applydate"));%></div>
                        <div class="info"><span>연락방식</span> <%if(hm.get("calling").equals("1")) out.println("업체의 전화를 기다리고 있습니다."); else out.println("고객님이 직접 전화하실 예정입니다.");%></div>
                        <div class="info"><span>처리상태</span> <div class="state"><%if(hm.get("state").equals("0")){%><div id="stt0"><% out.println("미배분");%></div><%}%>
                            <%if(hm.get("state").equals("1")){%><div id="stt1"><% out.println("재배분필요");%></div><%}%>
                            <%if(hm.get("state").equals("2")){%><div id="stt2"><% out.println("배분중");%></div><%}%>
                            <%if(hm.get("state").equals("3")){%><div id="stt3"><% out.println("전체수락");%></div><%}%>
                            <%if(hm.get("state").equals("4")){%><div id="stt3"><% out.println("고객취소");%></div><%}%>
                            <%if(hm.get("state").equals("4")){%><div id="stt3"><% out.println("관리자삭제");%></div><%}%>
                        </div>
                        </div>
                        <div class="info"><span>배분시간</span><div id="timer<%=hm.get("number")%>"></div><%=hm.get("assigned_time")%></div>
                        <div class="info"><span>고객페이지</span>
                            <textarea id="textarea<%out.print(hm.get("number"));%>">https://somoonhouse.com/customer_login.jsp?customer_num=<%out.print(hm.get("number"));%></textarea>
                            <input type="button" value="링크복사" onclick="myFunction('textarea<%out.print(hm.get("number"));%>')">
                        </div>
                        <%// 처리상태 - 0:신청완료 1:업체전달완료 %>
                        <!-- 처리상태가 0 신청완료일 시, 어느회사?
                              처리상태가 1 전달 완료일 시, 상태보여주기-->
                        <table class="company_status">
                            <%LinkedList<HashMap<String, String>> statelist = totalstatemap.get(hm.get("number"));
                                for(HashMap<String, String> statemap : statelist){%>
                            <tr>
                                <td><%out.print(statemap.get("name"));%></td>
                                <td><b><%out.print(statemap.get("state"));%></b></td>
                            </tr>
                            <%}%>
                        </table>

                        <% if(hm.get("state").equals("0") || hm.get("state").equals("1")){%>
                        <div class="company">
                            <div class="toggle_area">
                                <div id="toggle">▶</div>
                                <div id="toggle_title">어느 회사로 넘길까요?</div>
                            </div>
                            <form action="_assign_company.jsp" class="assign_company" method="GET" target="_self">
                                <input type="hidden" name="apply_num" value="<%out.print(hm.get("number"));%>">
                                <%
                                    for(HashMap<String, String> hm2 : company){
                                %>
                                <div><input type="checkbox" name="company" value="<%out.print(hm2.get("id"));%>" id="<%out.println(hm.get("number"));%>company<%out.print(hm2.get("id"));%>"><label for="<%out.println(hm.get("number"));%>company<%out.print(hm2.get("id"));%>" ><span></span><%out.print(hm2.get("name"));%></label></div>
                                <%
                                    }
                                %>
                                <div class="submit_btn">
                                    <input type="submit" value="넘기기">
                                </div>
                            </form>
                        </div>
                        <%}%>

                        <div class="manager_cancel" id="<%out.println(hm.get("number"));%>">
                            <span>X</span>관리자삭제
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
            <!------------ 내용물  --------------->








        </div>
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
        function myFunction(a) {
            var copyText = document.getElementById(a);
            copyText.select();
            copyText.setSelectionRange(0, 99999); /*For mobile devices*/
            document.execCommand("copy");
            alert("복사되었습니다");
        }
    </script>
    <script>
        const countDownTimer = function (id, date){
            const _vvDate = new Date(date);
            const _vDate = _vvDate.setHours(_vvDate.getHours()+3);
            const _second = 1000;
            const _minute = _second * 60;
            const _hour = _minute * 60;
            const _day = _hour * 24;
            let timer;

            function showRemaining(){
                const now = new Date();
                const distDt = _vDate - now;

                if(distDt < 0){
                    clearInterval(timer);
                    document.getElementById(id).textContent = "배분시간종료";
                    return;
                }

                const days = Math.floor(distDt / _day);
                const hours = Math.floor((distDt % _day) / _hour);
                const minutes = Math.floor((distDt % _hour) / _minute);
                const seconds = Math.floor((distDt % _minute) / _second);

                document.getElementById(id).textContent = days + '일 ';
                document.getElementById(id).textContent += hours + '시간 ';
                document.getElementById(id).textContent += minutes + '분 ';
                document.getElementById(id).textContent += seconds + '초 ';

            }

            timer = setInterval(() => showRemaining(), 1000); // 나 동노간다 - 이현로 -

        }


        <%
        for(HashMap<String, String> hm : itemlist){
            %>
            var str = "<%=hm.get("assigned_time")%>";
            var date = str.split("-"); //{2021}, {06}, {23 17:32:09.0}
            var time = (date[2].substring(date[2].indexOf(" ")+1, date[2].length)).split(":");
            date[2] = date[2].substring(0, date[2].indexOf(" "));
            alert("date : " + date + " time : " + time);
            countDownTimer("timer"+"<%=hm.get("number")%>", date[1]+"/"+date[2]+"/"+date[0]+" "+time[0]+":"+time[1]);
            //countDownTimer("timer"+"<%=hm.get("number")%>", '06/29/2021 00:00 AM');
            <%
        }
        %>
    </script>
    <script>
        window.onload = function(){
            /*
            if("<%=s_id%>" != "100" || "<%=s_id%>" == null){
                history.back();
            }
            */
        }
        $(".toggle_area").click(function(){
            if($(this).siblings("form").css("display") == "none"){
                $(this).siblings("form").css("display", "block");
                $(this).siblings("form").css("z-index", "10");
                $(this).siblings("form").css("position", "relative");
                $(this).siblings("form").css("background", "white");
                $(this).siblings("form").css("box-shadow", "1px 3px 3px 0px #00000045");
            }
            else{
                $(this).siblings("form").css("display", "none");
            }
        });
        $(".manager_cancel").click(function(){
            var req_id = $(this).attr("id");
            location.href = "_delete_request.jsp?id="+req_id;
        })
        /*
        function toggle_company(){
            if($(".assign_company").css("display") == "none"){
                $(".assign_company").css("display", "block");
                $(".assign_company").css("z-index", "10");
                $(".assign_company").css("position", "relative");
                $(".assign_company").css("background", "white");
                $(".assign_company").css("box-shadow", "1px 3px 3px 0px #00000045");
            }
            else{
                $(".assign_company").css("display", "none");
            }
        }
        $(".toggle_area").click(function(){
            toggle_company();
        })
         */
    </script>
    <script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
    <script type="text/javascript">
        if(!wcs_add) var wcs_add = {};
        wcs_add["wa"] = "3602e31fd32c7e";
        wcs_do();
    </script>
    <script type="text/javascript" src="slick-1.8.1/slick/slick.min.js"></script>
</div>
</div>
</body>
</html>