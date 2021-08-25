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

    //DB 관련 객체 선언
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
    String sql = "";

    //DB 가져오기 예시
    query = "select * from ISSUED_COUPON I, COMPANY C where I.Company_id = C.Id";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    HashMap<String, String> keyword = new HashMap<String, String>();
    while(rs.next()) {
        keyword.put(rs.getString("Id"), rs.getString("Name"));
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
            <div class="company_container">
                <div class="company_left">
                    <div class="company_img">
                        <img src="https://somoonhouse.com/sources/anonymous.jpg">
                    </div>
                    <div class="company_desc">
                        <div class="company_name">JYP 인테리어</div>
                        <div class="company_info">
                            <div class="company_last_coupon">잔여 <span>3</span>건</div>
                            <div class="company_last_consulting">미상담 <span>1</span>건</div>
                        </div>
                        <div class="company_last_login">last login 21.08.24</div>
                    </div>
                </div>
                <div class="company_button_area">
                    <button class="company_button_issue">건수 부여</button>
                    <button class="company_button_text">미상담 문자 전송</button>
                </div>
            </div>
            <div class="company_container">
                <div class="company_left">
                    <div class="company_img">
                        <img src="https://somoonhouse.com/sources/anonymous.jpg">
                    </div>
                    <div class="company_desc">
                        <div class="company_name">JYP 인테리어</div>
                        <div class="company_info">
                            <div class="company_last_coupon">잔여 <span>3</span>건</div>
                            <div class="company_last_consulting">미상담 <span>1</span>건</div>
                        </div>
                        <div class="company_last_login">last login 21.08.24</div>
                    </div>
                </div>
                <div class="company_button_area">
                    <button class="company_button_issue">건수 부여</button>
                    <button class="company_button_text">미상담 문자 전송</button>
                </div>
            </div>
            <div class="company_container">
                <div class="company_left">
                    <div class="company_img">
                        <img src="https://somoonhouse.com/sources/anonymous.jpg">
                    </div>
                    <div class="company_desc">
                        <div class="company_name">JYP 인테리어</div>
                        <div class="company_info">
                            <div class="company_last_coupon">잔여 <span>3</span>건</div>
                            <div class="company_last_consulting">미상담 <span>1</span>건</div>
                        </div>
                        <div class="company_last_login">last login 21.08.24</div>
                    </div>
                </div>
                <div class="company_button_area">
                    <button class="company_button_issue">건수 부여</button>
                    <button class="company_button_text">미상담 문자 전송</button>
                </div>
            </div>
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