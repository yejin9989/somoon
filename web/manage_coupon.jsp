<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    //캐시 설정 - 이미지 캐시 폐기 기간을 늘려서 반응속도를 올림
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 31536000);

    /*
    //네이버 로그인 시 필요
    String clientId = "G8MVoxXfGciyZW5dF4p1";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://somoonhouse.com/callback.jsp", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);

    //네이버 로그인 시 CSRF 방지를 위한 상태 토큰 검증
    //세션 또는 별도의 저장 공간에 저장된 상태 토큰과 콜백으로 전달받은 state 파라미터 값이 일치해야 함
    //콜백 응답에서 state 파라미터의 값을 가져옴
    state = request.getParameter("state");
     */

    // 세션 가져오기 get session
    String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user

    //파라미터 가져오기
    String param = request.getParameter("param");

    //필요한 변수 선언
    String mylog = "";
    String[] company_state = {"미입점", "입점"};

    //DB 관련 객체 선언
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
    String sql = "";

    //DB 가져오기
    //모든 회사 불러오기
    query = "SELECT * " +
            "FROM COMPANY " +
            "WHERE State = 1 OR Id = 47";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    HashMap<String, HashMap<String, String>> company_info = new HashMap<String, HashMap<String, String>>();
    String query2;
    PreparedStatement pstmt2 = null;
    ResultSet rs2 = null;
    while(rs.next()) {
        HashMap<String, String> hm = new HashMap<String, String>();
        query2 = "SELECT SUM(Stock) FROM ISSUED_COUPON where Company_id = " + rs.getString("Id")
                + " and Expiration_date >= CURDATE()"
                + " group by Company_id";
        pstmt2 = conn.prepareStatement(query2);
        rs2 = pstmt2.executeQuery();
        hm.put("stock", "0");
        while(rs2.next()){
            hm.put("stock", rs2.getString("SUM(Stock)"));
        }
        hm.put("modify_date", rs.getString("Modify_date"));
        hm.put("profile_img", rs.getString("Profile_img"));
        hm.put("name", rs.getString("Name"));
        hm.put("state", rs.getString("State"));
        hm.put("cnt", "0");
        hm.put("phone", rs.getString("Phone"));
        company_info.put(rs.getString("Id"),hm);
    }
    pstmt2.close();
    rs2.close();

    query = "SELECT COUNT(*) cnt, c.Id " +
            "FROM REMODELING_APPLY ra, ASSIGNED a, COMPANY c " +
            "WHERE a.Company_num = c.Id " +
            "AND a.Apply_num = ra.Number " +
            "AND (a.State=0 or a.State=2) " +
            "AND ra.Apply_date>'2021-06-09' " +
            "GROUP BY c.Id";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    while(rs.next()){
        HashMap hm = company_info.get(rs.getString("c.Id"));
        if(hm != null) {
            hm.put("cnt", rs.getString("cnt"));
        }
    }
    // 회사 별 쿠폰정보 불러오기
    HashMap<String, LinkedList<HashMap<String, String>>> company_coupon = new HashMap<String, LinkedList<HashMap<String, String>>>();
    for(String company_id : company_info.keySet()){
        // 유효기간이 오늘 이전인 쿠폰 발급 정보 가져오기
        query = "select * from ISSUED_COUPON I, COUPON C where I.Coupon_id = C.Id and I.Company_id = " + company_id + " and Expiration_date >= CURDATE() and I.Stock != 0";
        pstmt = conn.prepareStatement(query);
        rs = pstmt.executeQuery();
        LinkedList<HashMap<String, String>> coupons = new LinkedList<HashMap<String, String>>();
        while(rs.next()) {
            // 쿠폰이름, 남은 건수, 발급 일자, 유효 기간
            HashMap<String, String> hm = new HashMap<String, String>();
            hm.put("name", rs.getString("C.Name"));
            hm.put("stock", rs.getString("I.Stock"));
            hm.put("quantity", rs.getString("C.Quantity"));
            hm.put("issued_date", rs.getString("I.Issued_date"));
            hm.put("expiration_date", rs.getString("Expiration_date"));
            hm.put("issued_id", rs.getString("I.Id"));
            coupons.add(hm);
        }
        company_coupon.put(company_id, coupons);
    }

    //쿠폰정보 불러오기
    query = "select * from COUPON";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    HashMap<String, HashMap<String, String>> coupon = new HashMap<>();
    while(rs.next()){
        HashMap<String, String> hm = new HashMap<String, String>();
        hm.put("name", rs.getString("Name"));
        hm.put("period", rs.getString("Period"));
        hm.put("quantity", rs.getString("Quantity"));
        hm.put("price", rs.getString("Price"));
        coupon.put(rs.getString("Id"), hm);
    }
    pstmt.close();
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/manage_coupon.css"/>
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
    <!-- 사용자 행동 정보 수집 코드 끝 - Meta, GA -->
</head>
<body>
<div id="container">
    <!-- div>
        <span id="topBtn">top</span>
        <span id="applyBtn"><div>상담<br>신청</div></span>
    </div -->
    <jsp:include page="/homepage_pc_header.jsp" flush="false" />
    <jsp:include page="/homepage_mob_header.jsp" flush="false" />
    <div id="main">
        <div class="couponHeader">회사관리</div>
            <%
                for (String id : company_info.keySet()){
                    HashMap company = company_info.get(id);
            %>
            <div class="one_container">
                <div class="company_container">
                    <div class="company_left">
                        <div class="company_img">
                            <img src="<%=company.get("profile_img")%>">
                        </div>
                        <div class="company_desc">
                            <div class="company_name"><%=company.get("name")%></div>
                            <div class="company_info">
                                <div class="company_last_coupon" onclick="given(<%=id%>)">잔여
                                    <span><%=company.get("stock")%></span>건
                                </div>
                                <div class="company_last_consulting">미상담 <span><%=company.get("cnt")%></span>건</div>
                            </div>
                            <div class="company_last_login">last login <%=company.get("modify_date")%></div>
                        </div>
                    </div>
                    <div class="company_button_area">
                        <button class="company_button_issue" id="issue<%=id%>" onclick="clickPartner(this)">건수 부여</button>
                        <button class="company_button_text" onclick="alertMsgDone('<%=company.get("name")%>', '<%=company.get("phone")%>', '<%=company.get("cnt")%>');">미상담 문자 전송</button>
                        <!--button class="company_button_state"><%=company_state[Integer.parseInt(company.get("state")+"")]%></button-->
                    </div>
                </div>
                <div class="partner_container" id="partner<%=id%>">
                    <%for(String key : coupon.keySet()){
                        HashMap item = coupon.get(key);
                    %>
                    <div class="goods_container">
                        <div class="goods_left_box">
                            <div class="text_area">
                                <span class="upper_text"><%=item.get("name")%></span><!--span class="upper_text">주거 프라임</span-->
                            </div>
                            <div class="text_area">
                                <span class="mid_text">기간 <span class="mid_date_text"><%=item.get("period")%>일</span></span>
                            </div>
                            <div class="text_area">
                                <span class="lower_text">배분 <%=item.get("quantity")%>건</span>
                            </div>
                        </div>
                        <div class="goods_mid_box">
                            <span><%=item.get("price")%>원</span>
                        </div>
                        <div class="goods_right_box" id="<%=id%>_<%=key%>">
                            <span>발급하기</span>
                        </div>
                    </div>
                    <%}%>
                </div>
                <div class="modal_background" id="modal_background<%=id%>" onclick="clickModalBackground()">
                    <div class="modal" id="modal<%=id%>" onclick="clickModal()">
                        <div class="main_header">
                            <span><%=company.get("name")%></span>
                        </div>
                        <div class="main_container">
                            <div class="sub_text"><span>총 잔여 건수</span></div>
                            <div class="goods_container">
                                <span class="left_item"><%=company.get("stock")%>건</span>
                            </div>
                            <div class="sub_text"><span>이용중인 상품</span></div>
                            <%
                                LinkedList<HashMap<String, String>> list = company_coupon.get(id);
                                for(HashMap<String, String> hm : list){
                            %>
                            <div class="goods_container">
                                <div class="text_area">
                                    <span class="upper_text"><%=hm.get("name")%></span>
                                </div>
                                <div class="text_area">
                                    <span class="mid_text">기간 <span class="mid_date_text"><%=hm.get("issued_date")%>~<%=hm.get("expiration_date")%></span></span>
                                </div>
                                <div class="text_area">
                                    <span class="lower_text">잔여 <%=hm.get("stock")%>건/전체 <%=hm.get("quantity")%>건</span>
                                </div>
                                <div class="return" onclick="cancelProduct('<%=hm.get("name")%>', '<%=hm.get("issued_id")%>')">
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/X.png?raw=true" />
                                </div>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
            <%}%>
        </div>
    </div>
    <footer>
        <jsp:include page="newTestFooter.jsp" flush="false"/>
    </footer>
</div>
<%
    if(pstmt != null) {
        pstmt.close();
        rs.close();
        query = "";
        conn.close();
    }
%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    const cancelProduct = (title, id) => {
        if(confirm(title + "상품을 회수하시겠습니까?")){
            location.href = "_manage_coupon_delete_coupon.jsp?issued_id="+id;
        }
    }
    var modalBackground;
    var modal;
    const given = (prop) => {
        modalBackground = document.getElementById("modal_background" + prop);
        modal = document.getElementById("modal" + prop);
        if(modalBackground.style.display === "flex"){
            modalBackground.style.display = "none";
        }
        else{
            modalBackground.style.display = "flex";
        }
        if(modal.style.display === "flex"){
            modal.style.display = "none";
        }
        else{
            modal.style.display = "flex";
        }
    }
    var isNone = 0;
    const clickModalBackground = () => {
        if(isNone){
            isNone = 0;
            return;
        }
        else{
            if(modalBackground.style.display === "flex"){
                modalBackground.style.display = "none";
            }
            else{
                modalBackground.style.display = "flex";
            }
            if(modal.style.display === "flex"){
                modal.style.display = "none";
            }
            else{
                modal.style.display = "flex";
            }
        }
    }
    const clickModal = () => {
        isNone = 1;
    }

    const clickPartner = (prop) => {
        let idNum = prop.id.slice(5);
        var partnerContainer = document.getElementById("partner" + idNum);
        if(partnerContainer.style.display === "flex"){
            partnerContainer.style.display = "none";
        }
        else{
            partnerContainer.style.display = "flex";
        }
    }
</script>
<script>
    // $(".company-list").click(function(){
    //     var div_id = $(this).attr('id');
    //     var company_id = div_id.replace("com", "");
    //     alertMsgDone()
    // })
    function alertMsgDone(name, phone, cnt) {
        window.open("_send_cs_msg.jsp?name="+name+"&phone="+phone+"&cnt="+cnt,"pop","width=400,height=200");
    }
</script>
<script>
    $('.goods_right_box').click(function(){
        const id = $(this).attr('id');
        const company_id = id.slice(0, id.indexOf('_'));
        const coupon_id = id.slice(id.indexOf('_')+1);
        location.href = "_manage_coupon.jsp?company_id="+company_id+"&coupon_id="+coupon_id;
    })
</script>
</body>
</html>