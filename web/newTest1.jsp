<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    //필요한 변수 선언
    String mylog = "";

    //파라미터 가져오기
    //String param = request.getParameter("param");
    String s_id = session.getAttribute("s_id")+"";
    //String s_id = "35";

    //DB 관련 객체 선언
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
    String done_search = request.getParameter("done")+"";
    if(done_search == "null" || done_search.equals("null")) done_search = "";

    //변수설정
    String[] buildingType = {"아파트", "빌라", "주택", "원룸"};
    class Dates{
        String date;
        HashMap<String, HashMap<String, String>> applies;
        HashMap<String, HashMap<String, String>> details;

        void setDate(String date){
            this.date = date;
        }
        void setApplies(HashMap applies){
            this.applies = applies;
        }
        void setDetails(HashMap details){
            this.details = details;
        }

        String getDate(){
            return this.date;
        }
        HashMap getApplies(){
            return this.applies;
        }
        HashMap getDetails(){
            return this.details;
        }
    }

    //DB 가져오기
    query = "SELECT distinct Apply_date FROM ASSIGNED A, REMODELING_APPLY R";
    query += " WHERE A.Company_num = " + s_id;
    query += " And R.Number = A.Apply_num";
    query += " And R.State != 5"; // 관리자 삭제건은 보이지 않도록리
    query += " And A.State = 8"; // 탭에따라 이 쿼리 바꾸어주기
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    LinkedList<Dates> datelist = new LinkedList<Dates>();

    while(rs.next()) {

        Dates date = new Dates();
        date.setDate(rs.getString("Apply_date"));

        HashMap<String, HashMap<String, String>> applies = new HashMap<String, HashMap<String, String>>();
        HashMap<String, HashMap<String, String>> details = new HashMap<String, HashMap<String, String>>();


        query = "SELECT *, DATE_FORMAT(A.Contract_date,'%Y-%m-%d') as C_date FROM ASSIGNED A, REMODELING_APPLY R";
        query += " WHERE A.Company_num = " + s_id;
        query += " And R.Number = A.Apply_num";
        query += " And A.State = 8";
        query += " And Date(Apply_date) = '" + rs.getString("Apply_date") + "'";
        if(done_search != null && done_search != "") {
            query += " And (R.Name Like \"%" + done_search + "%\" OR R.Phone Like \"%" + done_search + "%\" OR R.Address Like \"%" + done_search + "%\")";
        }
        pstmt = conn.prepareStatement(query);
        ResultSet rs2 = pstmt.executeQuery();

        while (rs2.next()) {
            HashMap<String, String> temp = new HashMap<String, String>();
            if(rs2.getString("Item_num").equals("0")){
                temp.put("Title", "통합 신청 버튼으로 신청했습니다.");
                temp.put("URL", "#");
            }
            else{
                query = "select * from REMODELING where Number = " + rs2.getString("Item_num");
                pstmt = conn.prepareStatement(query);
                ResultSet rs3 = pstmt.executeQuery();
                while(rs3.next()){
                    temp.put("Title", rs3.getString("Title"));
                    temp.put("URL", rs3.getString("URL"));
                }
            }
            temp.put("Number", rs2.getString("R.Number"));
            temp.put("Item_num", rs2.getString("R.Item_num"));
            temp.put("Name", rs2.getString("R.Name"));
            temp.put("Phone", rs2.getString("R.Phone"));
            temp.put("Address", rs2.getString("R.Address"));
            if(rs2.getString("R.Building_type")!=null && !rs2.getString("R.Building_type").equals("null"))
                temp.put("Building_type", buildingType[Integer.parseInt(rs2.getString("R.Building_type"))]);
            else
                temp.put("Building_type", "정보없음");
            temp.put("Area", rs2.getString("R.Area"));
            temp.put("Due", rs2.getString("R.Due"));
            temp.put("Budget", rs2.getString("R.Budget"));
            temp.put("Consulting", rs2.getString("R.Consulting"));
            temp.put("Apply_date", rs2.getString("R.Apply_date"));
            temp.put("State", rs2.getString("R.State"));
            temp.put("Calling", rs2.getString("R.Calling"));
            temp.put("Pw", rs2.getString("R.Pw"));
            temp.put("Assigned_time", rs2.getString("R.Assigned_time"));
            temp.put("State", rs2.getString("A.State"));
            temp.put("Assigned_id", rs2.getString("A.Assigned_id"));
            temp.put("Contract_date", rs2.getString("C_date"));
            temp.put("contract_price", rs2.getString("A.contract_price"));
            temp.put("contract_img_path", rs2.getString("A.contract_img_path"));
            temp.put("Memo", rs2.getString("A.Memo"));
            temp.put("Modify_date", rs2.getString("A.Modify_date"));
            applies.put(temp.get("Number"), temp);

            //details 값 넣기
            PreparedStatement pstmt2 = null;
            query = "select * from REMODELING_APPLY ra, REMODELING_APPLY_DIV2 rad, RMDL_DIV1 rd, RMDL_DIV2 rd2 where ra.Number = ? and ra.Number = rad.Apply_num And rad.Div2_num = rd2.Id and rd2.Parent_id = rd.Id";
            pstmt2 = conn.prepareStatement(query);
            pstmt2.setString(1, temp.get("Number"));
            ResultSet rs3 = pstmt2.executeQuery();
            HashMap<String, String> hm = new HashMap<String, String>();
            while (rs3.next()) {
                hm.put(rs3.getString("rd.Name"), rs3.getString("rd2.Name"));
            }
            details.put(temp.get("Number"), hm);
        }
        date.setApplies(applies);
        date.setDetails(details);

        datelist.add(date);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newTest1.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집 - 완료상담 관리</title>
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
%>
<div class="body_container">
    <jsp:include page="/newTestHeader.jsp?tab=Done" flush="false" />
    <div class="body_main">
        <div class="main_header">
            <div class="left_container">
                <form id="form_done" name="form_done" method="POST" action="newTest1.jsp">
                    <div id="searchBox" class="left_box">
                        <div class="img_container">
                            <img src="https://somoonhouse.com/otherimg/assets/magnifying.png?raw=true" />
                        </div>
                        <div class="text_container">
                            <input id="text_input" class="text_input" type="text" name="done" placeholder="전화, 고객명, 주소"
                                   value="<%=done_search%>"/>
                            <input type="submit" style="display:none;" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="main_body_none">
            <div class="img_container">
                <img src="https://somoonhouse.com/otherimg/assets/search2.png?raw=true" />
            </div>
            <div class="text_container">
                <span>완료된 공사가 없습니다.</span>
            </div>
        </div>
        <%
            for (int i = 0; i < datelist.size(); i++) {
                for(String key : datelist.get(i).applies.keySet()){
                    HashMap apply = datelist.get(i).applies.get(key);
        %>
        <div class="main_body_yes">
            <div class="main_container">
                <div class="main_box">
                    <div class="up">
                        <div class="left_box">
                            <div class="upper_container">
                                <div class="text_container">
                                    <span><%=apply.get("Name")%> | <span class="sub_text"><%=apply.get("Address")%></span></span>
                                </div>
                            </div>
                            <div class="under_container">
                                <div class="under_box" id="contract_date">
                                    <span>계약 성사 : <%=apply.get("Contract_date")%></span>
                                </div>
                                <div class="under_box" id="contract_price">
                                    <span>계약금 : <%=apply.get("contract_price")%>원</span>
                                </div>
                                <div class="under_box btn_modal" id="btn_modal<%=apply.get("Number")%>" onclick="modal_func(this)">
                                    <span>계약서보기</span>
                                </div>
                            </div>
                        </div>
                        <div class="right_box" id="btn<%=apply.get("Number")%>" onclick="fin_btn(this)">
                            <div class="img_container">
                                <img id="arrow<%=apply.get("Number")%>"
                                        src="https://somoonhouse.com/otherimg/assets/rightDirection.png?raw=true" />
                            </div>
                        </div>
                    </div>
                    <div class="slide_container" id="fin_slide<%=apply.get("Number")%>">
                        <div class="left">
<%--                            <div class="text"><span class="fir">주거 프라임</span></div>--%>
                            <div class="text">
                                <span class="sec_fir">성함</span>
                                <span class="sec_sec"><%=apply.get("Name")%></span><!--span class="sec_sec">정진성</span-->
                            </div>
                            <div class="text">
                                <span class="sec_fir">주거</span>
                                <span class="sec_sec"><%=apply.get("Building_type")%> <%=apply.get("Area")%>평</span><!--span class="sec_sec">아파트 32평</span-->
                            </div>
                            <div class="text">
                                <span class="sec_fir">주소</span>
                                <span class="thr"><%=apply.get("Address")%></span><!--span class="thr">대구 남구 어쩌구</span-->
                            </div>
                            <div class="text">
                                <span class="sec_fir">예정일</span>
                                <span class="thr"><%=apply.get("Due")%></span><!--span class="thr">1개월 이내</span-->
                            </div>
                            <div class="text">
                                <span class="sec_fir">예산</span>
                                <span class="thr"><%=apply.get("Budget")%></span><!--span class="thr">8천만원 이하</span-->
                            </div>
<%--                            <div class="text">--%>
<%--                                <span class="sec_fir">신청한 디자인</span>--%>
<%--                                <a href="<%=apply.get("URL")%>"><span class="for"><%=apply.get("Title")%></span></a>--%>
<%--                            </div>--%>
                        </div>
                        <div class="right">
                                <%
                                    HashMap<String, String> hm = datelist.get(i).details.get(apply.get("Number"));
                                    for(String name : hm.keySet()){
                                %>
                                <div class="text">
                                    <span class="sec_fir"><%=name%>></span>
                                    <span class="sec_sec"><%=hm.get(name)%></span><!--span class="sec_sec">정진성</span-->
                                </div>
                                <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
    <!--계약서 확인 모달창-->
    <%
        for (int i = 0; i < datelist.size(); i++) {
            for(String key : datelist.get(i).applies.keySet()){
                HashMap apply = datelist.get(i).applies.get(key);
    %>
    <div id="modal<%=apply.get("Number")%>" class="modal_overlay">
        <div id="contract_modal">
            <div class="modal_window">
                <div class="title">
                    <h2>계약서 확인</h2>
                </div>
                <div id="close_area<%=apply.get("Number")%>" class="close_area" onclick="modal_close(this)">X</div>
                <div class="content">
                    <div>계약서 이미지 :
                        <img src="<%=apply.get("contract_img_path")%>" onerror="this.src='https://somoonhouse.com/otherimg/assets/nocontract.svg?raw=true'">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
            }
        }
    %>
    <jsp:include page="/newTestFooter.jsp" flush="false" />
</div>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    const inputBox = document.getElementById("text_input"),
        searchBox = document.getElementById("searchBox");
        modals = document.getElementsByClassName("modal_overlay");
    inputBox.addEventListener('focus', (event) => {
        searchBox.style.background = "#fff";
        inputBox.style.background = "#fff";
    })
    inputBox.addEventListener('blur', (event) => {
        searchBox.style.background = "#fafafa";
        inputBox.style.background = "#fafafa";
    })

    //modal_window_controller//
    //modal_window_open
    function modal_func(obj){
        var modalNum = obj.id.slice(9);
        var contractModal = document.getElementById("modal" + modalNum);
        contractModal.style.display = "flex"
    }
    //modal_window_close
    function modal_close(obj){
        var modalNum = obj.id.slice(10);
        var contractModal = document.getElementById("modal" + modalNum);
        contractModal.style.display = "none"
    }
    //ESC 키를 눌렀을 때 종료
    window.addEventListener("keyup", e => {
        for(var i=0;i<modals.length;i++){
            var eachModals = modals[i];
            if(eachModals.style.display === "flex" && e.key === "Escape") {
                eachModals.style.display = "none"
            }
        }
    })
    //창 바깥쪽을 클릭했을 때 종료
    for (var i = 0; i < modals.length; i++) {
        var eachModal = modals[i];
        eachModal.addEventListener("click", e => {
            const evTarget = e.target;
            if(evTarget.classList.contains("modal_overlay")) {
                evTarget.style.display = "none"
            }
        })
    }
    //-------------------------------------------------------------------

    function fin_btn(obj){
        var boxNum = obj.id.slice(3);
        var slide = document.getElementById("fin_slide" + boxNum);
        var img = document.getElementById("arrow" + boxNum);
        if(img.style.transform === "rotate(270deg)"){
            img.style.transform = "rotate(90deg)";
        }
        else{
            img.style.transform = "rotate(270deg)";
        }
        if(slide.style.display === "flex"){
            slide.style.display = "none";
        }
        else{
            slide.style.display = "flex";
        }
    }
    $('document').ready(function(){
        if('<%=datelist.size()%>' == '0'){
            $('.main_body_none').css('display', 'flex');
            $('.main_body_yes').css('display','none');
        }
        else{
            $('.main_body_none').css('display', 'none');
            $('.main_body_yes').css('display','flex');
        }
    })
    // 새로고침 시 get parameter 초기화
    history.replaceState({}, null, location.pathname);
</script>
</body>
</html>