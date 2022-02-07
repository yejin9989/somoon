<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<%@ page import="javax.swing.*" %>
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
    String ing_search = request.getParameter("ing")+"";
    if(ing_search == null || ing_search.equals("null")) ing_search = "";
    String ing_filter = request.getParameter("filter")+"";
    if(ing_filter == null || ing_filter.equals("null")) ing_filter = "100";

    //변수설정
    String[] buildingType = {"아파트", "빌라", "주택", "원룸"};
    String[] assignedState = {"상담 대기", "부재중", "상담중", "미팅 예정", "계약진행중"};
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
    // 날짜별로 담기
    query = "SELECT distinct Date(Accept_time) AS Accept_date FROM ASSIGNED A, REMODELING_APPLY R";
    query += " WHERE A.Company_num = " + s_id;
    query += " And R.Number = A.Apply_num";
    query += " Order by Accept_date desc";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    LinkedList<Dates> datelist = new LinkedList<Dates>();

    // 날짜별로 신청정보 가져오기
    while(rs.next()) {

        Dates date = new Dates();
        date.setDate(rs.getString("Accept_date"));

        HashMap<String, HashMap<String, String>> applies = new HashMap<String, HashMap<String, String>>(); //신청자, 주소 정보
        HashMap<String, HashMap<String, String>> details = new HashMap<String, HashMap<String, String>>(); //신청 시공 정보

        int cnt = 0;

        query = "SELECT *, Date(Accept_time) AS Accept_date FROM ASSIGNED A, REMODELING_APPLY R";
        query += " WHERE A.Company_num = " + s_id;
        query += " And R.Number = A.Apply_num";
        query += " And R.State != 5"; // 관리자 삭제건은 보이지 않도록
        query += " And Date(Accept_time) = '" + rs.getString("Accept_date") + "'";
        if(ing_filter.equals("100")) {
            query += " And A.State >= 2 And A.State < 8"; // 탭에따라 이 쿼리 바꾸어주기
        }
        else {
            query += " And A.State = " + ing_filter;
        }
        if(ing_search != null && ing_search != "") {
            query += " And (R.Name Like \"%" + ing_search + "%\" OR R.Phone Like \"%" + ing_search + "%\" OR R.Address Like \"%" + ing_search + "%\")";
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
                    if(!rs3.getString("URL").equals("#")){
                        temp.put("URL", "_hit.jsp?num="+rs2.getString("R.Item_num"));
                    }
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
        if(!applies.isEmpty()) {
            date.setApplies(applies);
            date.setDetails(details);

            datelist.add(date);
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newTest.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집 - 진행상담 관리</title>
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
        fbq('init', '333710951988229');
        fbq('track', 'PageView');
    </script>
    <noscript><img height="1" width="1" style="display:none"
                   src="https://www.facebook.com/tr?id=333710951988229&ev=PageView&noscript=1"
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
</head>
<body>
<%=mylog%>
<%

%>
<div class="body_container">
    <jsp:include page="/newTestHeader.jsp?tab=InProgress" flush="false" />
    <div class="body_main">
        <div class="main_header">
            <form id="form_ing" name="form_ing" method="POST" action="newTest.jsp">
                <div class="left_container">
                    <div id="searchBox" class="left_box">
                        <div class="img_container">
                            <img src="https://somoonhouse.com/otherimg/assets/magnifying.png?raw=true" />
                        </div>
                        <div class="text_container">
                            <input id="text_input" class="text_input" type="text" name="ing" placeholder="전화, 고객명, 주소"
                                   value="<%=ing_search%>" />
                        </div>
                    </div>
                </div>
                <div class="right_container">
                    <div class="right_box">
                        <div class="text_container">
                            <select class="filter" type="text" name="filter">
                                <option value="100" selected>전체보기</option>
                                <%for (int j = 0; j < assignedState.length; j++) {
                                    String selected = "";
                                     if(j+2 == Integer.parseInt(ing_filter))
                                         selected = "selected";
                                %>
                                <option value="<%=j+2%>" <%=selected%>><%=assignedState[j]%></option>
                                <%}%>
                            </select>
                        </div>
                        <input type="submit" value="검색" />
                    </div>
                </div>
            </form>
        </div>
        <div class="main_body_none">
            <div class="img_container">
                <img src="https://somoonhouse.com/otherimg/assets/search2.png?raw=true" />
            </div>
            <div class="text_container">
                <span>진행중인 공사가 없습니다.</span>
            </div>
        </div>
        <div class="main_body_yes">
            <div class="main_container">
                <%for (int i = 0; i < datelist.size(); i++) {%>
                <div class="date_container">
                    <span><%=datelist.get(i).getDate()%></span> <!--span>2021.06.02</span-->
                </div>
                <%
                    for(String key : datelist.get(i).applies.keySet()){
                        HashMap apply = datelist.get(i).applies.get(key);
                %>
                <div class="box_container">
                    <div class="main_box">
                        <div class="text_container">
                            <div class="slide_container" id="slide<%=apply.get("Number")%>">
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
                            <div class="slide_btn" id="slide_btn<%=apply.get("Number")%>" onclick="slide_detail(this)">
                                <img src="https://somoonhouse.com/otherimg/assets/arrow.png?raw=true" />
                            </div>
                            <!--<div class="text"><span class="fir">주거 프라임</span></div>-->
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
                            <!--
                            <div class="text">
                                <span class="sec_fir">신청한 디자인</span>
                                <a href="<%=apply.get("URL")%>"><span class="for"><%=apply.get("Title")%></span></a>
                            </div>
                            -->
                            <div class="text">
                                <span class="sec_fir">진행 단계</span>
                                <select class="fiv" name="state<%=apply.get("Number")%>">
                                <%for (int j = 0; j < assignedState.length; j++) {
                                    String selected = "";
                                    if(j+2 == Integer.parseInt(String.valueOf(apply.get("State"))))
                                        selected = "selected";%>
                                    <option value="<%=j+2%>" <%=selected%>><%=assignedState[j]%></option>
                                <%}%>
                                </select>
                                <button class="fiv_btn" onclick="save(this)" id="stt<%=apply.get("Number")%>">저장</button>
                            </div>
                        </div>
                        <div class="under_container">
                            <div class="side_container" id="call<%=apply.get("Number")%>" onclick="change_phase(this)">
                                <div class="img_container">
                                    <img src="https://somoonhouse.com/otherimg/assets/call.png?raw=true" />
                                </div>
                                <div class="text_container">
                                    <span><a href="tel:<%=apply.get("Phone")%>">전화</a></span>
                                </div>
                            </div>
                            <div class="side_container" id="msg<%=apply.get("Number")%>" onclick="change_phase(this)">
                                <div class="img_container">
                                    <img src="https://somoonhouse.com/otherimg/assets/talk.png?raw=true" />
                                </div>
                                <div class="text_container">
                                    <span><a href="tel:<%=apply.get("Phone")%>">문자</a></span>
                                </div>
                            </div>
                            <div class="side_container" id="com<%=apply.get("Number")%>" onclick="open_modal(this)">
                                <div class="img_container">
                                    <img src="https://somoonhouse.com/otherimg/assets/check3.png?raw=true" />
                                </div>
                                <div class="text_container">
                                    <span>완료</span>
                                </div>
                            </div>
                            <div class="side_container" id="stop<%=apply.get("Number")%>" onclick="open_modal_non_fin(this)">
                                <div class="img_container">
                                    <img src="https://somoonhouse.com/otherimg/assets/cancel2.png?raw=true" />
                                </div>
                                <div class="text_container">
                                    <span>중단</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal_container_fin" id="modal_container_fin<%=apply.get("Number")%>">
                        <form action="_newTest_company_finish.jsp" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="assigned_id" value="<%=apply.get("Assigned_id")%>" />
                            <div class="modal_box">
                                <div class="item_container">
                                    <span class="item_span">계약 일시</span>
                                    <div class="select_date">
                                        <input type="date" name="contract_date" required/>
                                    </div>
                                    <span class="item_span">계약금</span>
                                    <div class="input_pay">
                                        <input type="text" name="contract_price" placeholder="계약금을 입력해주세요" required/>
                                    </div>
                                    <span class="item_span">계약서 업로드</span>
                                    <input class="file" name="filename1" type="file" required/>
                                </div>
                                <div class="btn_container">
                                    <button type="submit"><span>완 료</span></button>
                                </div>
                                <div class="modal_cancel" onclick="close_modal()">
                                    <img src="https://somoonhouse.com/otherimg/assets/cancel.png?raw=true" />
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal_container_non_fin" id="modal_container_non_fin<%=apply.get("Number")%>">
                        <form method="post" action="_newTest_company_stop.jsp">
                            <div class="modal_box">
                                <div class="item_container">
                                    <span class="item_span">중단 단계</span>
                                    <div class="stop_step">
                                        <div class="input_box">
                                            <input type="radio" name="step" value="1" required/>
                                            <span>전화 통화 전 마무리</span>
                                        </div>
                                        <div class="input_box">
                                            <input type="radio" name="step" value="2" />
                                            <span>전화 통화 후 마무리</span>
                                        </div>
                                        <div class="input_box">
                                            <input type="radio" name="step" value="3" />
                                            <span>방문 상담 후 마무리</span>
                                        </div>
                                        <div class="input_box">
                                            <input type="radio" name="step" value="4" />
                                            <span>견적 산출 후 마무리</span>
                                        </div>
                                        <div class="input_box">
                                            <input type="radio" name="step" value="5" />
                                            <span>계약 전 마무리</span>
                                        </div>
                                    </div>
                                    <span class="item_span">중단 사유</span>
                                    <div class="stop_why">
                                        <input type="text" placeholder="중단 사유를 입력해주세요" required/>
                                    </div>
                                </div>
                                <div class="btn_container">
                                    <button type="submit"><span>중 단</span></button>
                                </div>
                                <div class="modal_cancel" onclick="close_modal_non_fin()">
                                    <img src="https://somoonhouse.com/otherimg/assets/cancel.png?raw=true" />
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <%
                    }
                }
                %>
            </div>
        </div>
    </div>
    <jsp:include page="/newTestFooter.jsp" flush="false" />
</div>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    const inputBox = document.getElementById("text_input"),
        searchBox = document.getElementById("searchBox");
    inputBox.addEventListener('focus', (event) => {
        searchBox.style.background = "#fff";
        inputBox.style.background = "#fff";
    })
    inputBox.addEventListener('blur', (event) => {
        searchBox.style.background = "#fafafa";
        inputBox.style.background = "#fafafa";
    })
    function slide_detail(obj){
        var boxNum = obj.id.slice(9);
        var box = document.getElementById("slide" + boxNum);
        var btn = document.getElementById("slide_btn" + boxNum);
        /*
        if(box.style.right === "0px" || box.style.right === "0"){
            box.style.right = "-100%";
            btn.style.transform = "rotate(0)";
        }
        */
        if(box.style.right === "-45%"){
            box.style.right = "-100%";
            btn.style.transform = "rotate(0)";
        }
        else{
            box.style.right = "-45%";
            btn.style.transform = "rotate(180deg)";
        }
    }
    function save(obj){
        alert("진행단계가 저장됐습니다.");
        var id = obj.getAttribute("id").substring(3);
        var state = $('select[name=state'+id+']').val();
        location.href = '_newTest_company_change_state.jsp?companyNum='+'<%=s_id%>'+'&state='+state+'&applyNum='+id;
    }
    var modalNum;
    function open_modal(obj){
        modalNum = obj.id.slice(3);
        var modal = document.getElementById("modal_container_fin" + modalNum);
        modal.style.display = "flex"
        //location.href = "_newTest_company_change_state.jsp?companyNum="+"<%=s_id%>"+"&state=8&applyNum="+id;
    }
    function close_modal(){
        var modal = document.getElementById("modal_container_fin" + modalNum);
        modal.style.display = "none"
    }
    function open_modal_non_fin(obj){

        modalNum = obj.id.slice(4);
        var modal = document.getElementById("modal_container_non_fin" + modalNum);
        modal.style.display = "flex"
        var id = obj.getAttribute("id").substring(4);
        //location.href = "_newTest_company_change_state.jsp?companyNum="+"<%=s_id%>"+"&state=9&applyNum="+id;
    }
    function close_modal_non_fin(){
        var modal = document.getElementById("modal_container_non_fin" + modalNum);
        modal.style.display = "none"
    }

    const change_phase = (prop) => {
        const boxID = prop.id.substr(0, 3) === "msg" ?
            prop.id.substr(3, prop.id.length) :
            prop.id.substr(4, prop.id.length);
        const selectDiv = document.getElementsByName("state" + boxID);
        let selectedIndex;
        for(let i = 0; i < selectDiv[0].length; i++)
            if(selectDiv[0][i].selected) selectedIndex = i;
        if(selectedIndex === 0 || selectedIndex === 1){
            selectDiv[0][selectedIndex].selected = false;
            selectDiv[0][2].selected = true;

            $.ajax("_newTest_company_change_state.jsp?companyNum=<%=s_id%>&state=4&applyNum="+boxID+"&text=true")
            .done(function(){
                //alert("성공");
            })
            .fail(function() {
                //alert("실패");
            })
            .always(function() {
                //alert("완료");
            });
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

        //세션 없을 시 리다이렉트
        if("<%=s_id%>" == "null"){
            alert("로그인 세션이 만료되었습니다. 재로그인 해주세요.");
            location.href = "homepage.jsp";
        }
    })
    // 새로고침 시 get parameter 초기화
    history.replaceState({}, null, location.pathname);
</script>
</body>
</html>