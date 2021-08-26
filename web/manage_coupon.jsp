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
    query = "SELECT *, COUNT(*) cnt " +
            "FROM ASSIGNED a, COMPANY c, REMODELING_APPLY ra " +
            "WHERE a.Company_num = c.Id AND a.Apply_num = ra.Number AND (a.State = 0 or a.State = 2) " +
            "AND ra.Apply_date > '2021-06-09' And c.State = 1 " +
            "GROUP BY a.Company_num order by c.State desc";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    HashMap<String, HashMap<String, String>> company_info = new HashMap<String, HashMap<String, String>>();
    while(rs.next()) {
        HashMap<String, String> hm = new HashMap<String, String>();
        String query2 = "SELECT SUM(Stock) FROM ISSUED_COUPON where Company_id = " + rs.getString("c.Id")
                + " group by Company_id";
        PreparedStatement pstmt2 = conn.prepareStatement(query2);
        ResultSet rs2 = pstmt2.executeQuery();
        hm.put("stock", "0");
        while(rs2.next()){
            hm.put("stock", rs2.getString("SUM(Stock)"));
        }
        hm.put("modify_date", rs.getString("c.Modify_date"));
        hm.put("profile_img", rs.getString("c.Profile_img"));
        hm.put("name", rs.getString("c.Name"));
        hm.put("state", rs.getString("c.State"));
        hm.put("cnt", rs.getString("cnt"));
        hm.put("phone", rs.getString("c.Phone"));
        company_info.put(rs.getString("c.Id"),hm);
    }
    //회사 별 쿠폰정보 불러오기
    HashMap<String, HashMap<String, String>> company_coupon = new HashMap<String, HashMap<String, String>>();
    for(String company_id : company_info.keySet()){
        // 유효기간이 오늘 이전인 쿠폰 발급 정보 가져오기
        query = "select * from ISSUED_COUPON I, COUPON C where I.Coupon_id = C.Id and I.Company_id = " + company_id + " and Expiration_date >= CURDATE()";
        pstmt = conn.prepareStatement(query);
        rs = pstmt.executeQuery();
        while(rs.next()) {
            // 쿠폰이름, 남은 건수, 발급 일자, 유효 기간
            HashMap<String, String> hm = new HashMap<String, String>();
            hm.put("name", rs.getString("C.Name"));
            hm.put("stock", rs.getString("I.Stock"));
            hm.put("issued_date", rs.getString("I.Issued_date"));
            hm.put("expiration_date", rs.getString("Expiration_date"));
            company_coupon.put(company_id, hm);
        }
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
</head>
<body>
<div id="container">
    <!-- div>
        <span id="topBtn">top</span>
        <span id="applyBtn"><div>상담<br>신청</div></span>
    </div -->
    <navbar>
        <jsp:include page="navbar.jsp" flush="false"/>
    </navbar>
    <div id="main">
        <div class="couponHeader">회사관리</div>
        <div class="main_container">
            <%
            for (String id : company_info.keySet()){
                HashMap company = company_info.get(id);
            %>
            <div class="company_container">
                <div class="company_left">
                    <div class="company_img">
                        <img src="<%=company.get("profile_img")%>">
                    </div>
                    <div class="company_desc">
                        <div class="company_name"><%=company.get("name")%></div>
                        <div class="company_info">
                            <div class="company_last_coupon">잔여 <span><%=company.get("stock")%></span>건</div>
                            <div class="company_last_consulting">미상담 <span><%=company.get("cnt")%></span>건</div>
                        </div>
                        <div class="company_last_login">last login <%=company.get("modify_date")%></div>
                    </div>
                </div>
                <div class="company_button_area">
                    <button class="company_button_issue">건수 부여</button>
                    <button class="company_button_text">미상담 문자 전송</button>
                    <!--button class="company_button_state"><%=company_state[Integer.parseInt(company.get("state")+"")]%></button-->
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
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'G-PC15JG6KGN');
</script>
<script>
    //새 스크립트 작성
</script>
</body>
</html>