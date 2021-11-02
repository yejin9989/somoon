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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/interior_info.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
<jsp:include page="/homepage_pc_header.jsp" flush="false" />
<jsp:include page="/homepage_mob_header.jsp" flush="false" />
<div class="body_container">
    <div class="interior_info_box">
        <!-- 배경 사진 들어가는 div 큰 화면일 땐 250 250 이었다가 작은 화면으로 바뀌면 배경화면처럼 들어가야함.-->
        <div class="background">
            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/moonstar.jpeg?raw=true" />
        </div>
        <!-- 회사명 들어가는 div 큰 화면일 땐 오른쪽 위에 위치하다가 작은 화면으로 바뀌면 배경사진 밑에 한줄 차지해야하고 스크롤 하면서 자연스럽게 위에 fixed해서 붙어야함-->
        <div class="info_title" id="info_title">
            <span class="title_name">한빛디자인<span class="title_sub">계약 3건 · 상담 12건</span></span>
            <span class="title_submit">상담 신청</span>
        </div>
        <div class="info_title_block" id="info_title_block"></div>
        <!-- detail 큰 화면일 땐 오른쪽 아래에 위치 작은 화면으로 바뀌면 회사명 div 밑에 붙어야하고, fixed 하지 않아도 됨-->
        <div class="detail">
            <div class="info">
                <div class="title">대표자</div>
                <div class="sub">임재한</div>
            </div>
            <div class="info">
                <div class="title">경력</div>
                <div class="sub">200년</div>
            </div>
            <div class="info">
                <div class="title">주소</div>
                <div class="sub addr">대구 북구 대현로 19길 54 가나다라마바사가나다라마바사가나다라마바사가나다라마바사</div>
            </div>
        </div>
    </div>

    <!-- 각 업체별 사례 -->
    <div class="interior_info_case">
        <div class="upper">
            <span>업체 시공 사례</span>
        </div>
        <div class="lower">
            <div class="slider">
                <a href="https://github.com" class="case_container">
                    <div class="box">
                        <div class="box_upper">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog1.jpg?raw=true" />
                        </div>
                        <div class="box_lower">
                            <span class="title">대구 수성구 수성동 수성보성타운</span>
                            <span class="sub">아파트 | 49평형</span>
                        </div>
                    </div>
                </a>
                <a href="https://github.com" class="case_container">
                    <div class="box">
                        <div class="box_upper">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog1.jpg?raw=true" />
                        </div>
                        <div class="box_lower">
                            <span class="title">대구 수성구 수성동 수성보성타운</span>
                            <span class="sub">아파트 | 49평형</span>
                        </div>
                    </div>
                </a>
                <a href="https://github.com" class="case_container">
                    <div class="box">
                        <div class="box_upper">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog1.jpg?raw=true" />
                        </div>
                        <div class="box_lower">
                            <span class="title">대구 수성구 수성동 수성보성타운</span>
                            <span class="sub">아파트 | 49평형</span>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <!-- 후기 : 후기 페이지에 있는 거 가져오기 -->
    <!--div class="interior_info_review">
        <div class="reviewUpperTextContainer"><span>고객 후기</span></div>
        <div class="reviewBoxContainer">
            <div class="reviewBox">
                <div class="upper">
                    <span class="num">4.9</span>
                    <div class="infoDiv">
                        <span class="info">김○○님</span>
                    </div>
                </div>
                <div class="imgs">
                    <div>
                        <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog1.jpg?raw=true" />
                    </div>
                    <div>
                        <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog2.jpg?raw=true" />
                    </div>
                    <div>
                        <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cat1.jpg?raw=true" />
                    </div>
                    <div class="lastImg"></div>
                </div>
                <div class="text">
                <span>
                    이번에 로또 1등 당첨 되면서 집을 보러 가게 됐는데
                    인테리어가 마음에 안들어서 OROKOS 인테리어에 맡겼는데
                    일 정말 잘하더라고요~~! 여기 강추합니다! 대박.
                </span>
                </div>
            </div>
            <div class="reviewBox">
                <div class="upper">
                    <span class="num">4.9</span>
                    <div class="infoDiv">
                        <span class="info">김○○님</span>
                    </div>
                </div>
                <div class="imgs">
                    <div>
                        <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog1.jpg?raw=true" />
                    </div>
                    <div>
                        <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog2.jpg?raw=true" />
                    </div>
                    <div>
                        <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cat1.jpg?raw=true" />
                    </div>
                    <div class="lastImg"></div>
                </div>
                <div class="text">
                <span>
                    이번에 로또 1등 당첨 되면서 집을 보러 가게 됐는데
                    인테리어가 마음에 안들어서 OROKOS 인테리어에 맡겼는데
                    일 정말 잘하더라고요~~! 여기 강추합니다! 대박.
                </span>
                </div>
            </div>
        </div>
    </div-->
</div>
<jsp:include page="/newTestFooter.jsp" flush="false" />

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
    /*
    const info_title = document.getElementById("info_title");
    const info_title_block = document.getElementById("info_title_block");
    let isForMobile = window.innerWidth > 700 ? false : true;
    window.addEventListener('resize', (event) => {
        isForMobile = event.currentTarget.innerWidth > 700 ? false : true;
    })
    window.onscroll = () => {
        if(isForMobile){
            if(document.documentElement.scrollTop >= 250 && info_title.style.position !== "fixed"){
                info_title.style.position = "fixed";
                info_title_block.style.display = "flex";
            }
            if(document.documentElement.scrollTop < 250 && info_title.style.position === "fixed"){
                info_title.style.position = null;
                info_title_block.style.display = "none";
            }
        }
        else{
            if(info_title.style.position === "fixed"){
                info_title.style.position = "";
                info_title_block.style.display = "none";
            }
        }
    }
    */
</script>
</body>
</html>