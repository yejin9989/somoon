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
    int i, j;
    String mylog = "";

    //DB 관련 객체 선언
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
    String sql = "";

    //DB 가져오기 예시
    /*query = "select * from KEYWORD";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    HashMap<String, String> keyword = new HashMap<String, String>();
    while(rs.next()) {
        keyword.put(rs.getString("Id"), rs.getString("Name"));
    }
    pstmt.close();
     */
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homepage_header.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
<div class="upper_fixed_mob"></div>
<div class="body_container_header" id="header_mob">
    <div class="header_mob">
        <div class="header_upper">
            <div class="menu" onclick="open_slide()">
                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/menu5.png?raw=true" />
            </div>
            <div class="logo">
                <a href="https://somoonhouse.com/">
                    <img src="https://somoonhouse.com/otherimg/index/somunlogo.jpg" />
                </a>
            </div>
            <a class="instaA" href="https://www.instagram.com/somoonhouse/">
                <div class="insta">
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/instagram2.png?raw=true" />
                </div>
            </a>
        </div>
        <div class="underline"></div>
        <div class="header_lower">
            <div id="area_header" onclick="area_click()">
                <span id="area_span">지역별 인테리어</span>
                <div id="area_div">
                    <a href="https://somoonhouse.com/newindex.jsp?Daegu=141"><span>중구</span></a>
                    <a href="https://somoonhouse.com/newindex.jsp?Daegu=142"><span>동구</span></a>
                    <a href="https://somoonhouse.com/newindex.jsp?Daegu=143"><span>서구</span></a>
                    <a href="https://somoonhouse.com/newindex.jsp?Daegu=144"><span>남구</span></a>
                    <a href="https://somoonhouse.com/newindex.jsp?Daegu=145"><span>북구</span></a>
                    <a href="https://somoonhouse.com/newindex.jsp?Daegu=146"><span>수성구</span></a>
                    <a href="https://somoonhouse.com/newindex.jsp?Daegu=147"><span>달서구</span></a>
                    <a href="https://somoonhouse.com/newindex.jsp?Daegu=148"><span>달성군</span></a>
                    <a href="https://somoonhouse.com/newindex.jsp?Daegu=15"><span>경북</span></a>
                </div>
            </div>
            <a href="https://somoonhouse.com/newindex.jsp?theme_id=1">
                <span>인기 인테리어</span>
            </a>
            <!-- a>
                <span>시공 후기</span>
            </a>
            <a href="https://somoonhouse.com/banner1.jsp?id=3">
                <span>파트너스</span>
            </a -->
        </div>
        <div class="underline"></div>
    </div>
</div>
<div class="mobileFooter" id="mobileFooter">
    <span>견적 상담 받기</span>
    <div>
        <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/arrow2.png?raw=true" />
    </div>
</div>
<%
    if(pstmt != null) {
        pstmt.close();
        rs.close();
        query = "";
        conn.close();
    }
%>
<div class="menu_slide_container" id="menu_slide_container" onclick="close_slide()"></div>
<div class="menu_slide" id="menu_slide">
    <div class="close_btn" onclick="close_slide()">
        <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/X.png?raw=true" />
    </div>
    <span class="head">대구 경북 인테리어<br>전문가를 만나보세요.</span>
    <a class="cons" href="https://somoonhouse.com/remodeling_form.jsp?item_num=0">견적 상담</a>
    <a class="cons b" href="https://somoonhouse.com/banner1.jsp?id=3">시공전문가 입점문의</a>
    <a class="insta_cont" href="https://www.instagram.com/somoonhouse/">
        <div class="img_cont">
            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/insta.png?raw=true" />
        </div>
        <div class="text_cont">
            <span>소문난집 인스타그램</span>
            <div class="under">
                <span>바로가기</span>
                <div class="arrow">
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/arrow2.png?raw=true" />
                </div>
            </div>
        </div>
    </a>
    <div class="menu_container">
        <div class="menu_upper">
            <div class="upper_img">
                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/call.png?raw=true" />
            </div>
            <span>소문난집 전화문의</span>
        </div>
        <div class="menu_lower">
            <span>053-290-5959</span>
        </div>
    </div>
</div>
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

    var scrollStartPos = window.scrollY;
    var scrollPastPos = window.scrollY;
    var headerMob = document.getElementById("header_mob");
    var footer = document.getElementById("mobileFooter");
    setTimeout(() => {
        window.addEventListener('scroll', (e) => {
            var scrollMoving = scrollPastPos - window.scrollY;
            if(scrollMoving < 0){
                if(scrollPastPos > 190){
                    headerMob.style.top = "-102px";
                }
                footer.style.bottom = "-60px";
            }
            else{
                headerMob.style.top = "0";
                footer.style.bottom = "0";
            }
            scrollPastPos = window.scrollY;
        });
    }, 500)


    const open_slide = () => {
        var back = document.getElementById("menu_slide_container");
        if(back.style.display === "flex"){
            back.style.display = "none";
        }
        else{
            back.style.display = "flex";
        }
        var menu_slide = document.getElementById("menu_slide");
        if(menu_slide.style.transform !== "translateX(270px)"){
            menu_slide.style.transform = "translateX(270px)";
        }
    }
    const close_slide = () => {
        var back = document.getElementById("menu_slide_container");
        if(back.style.display === "flex"){
            back.style.display = "none";
        }
        else{
            back.style.display = "flex";
        }
        var menu_slide = document.getElementById("menu_slide");
        if(menu_slide.style.transform === "translateX(270px)"){
            menu_slide.style.transform = "translateX(0)";
        }
    }
    const area_click = () => {
        var div = document.getElementById("area_div");
        if(div.style.display === "flex"){
            div.style.display = "none";
        }
        else{
            div.style.display = "flex";
        }
    }
</script>
</body>
</html>