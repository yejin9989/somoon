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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homepage_mob.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
<div class="body_container_Mob">
    <div class="header">
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
    </div>
    <div class="container">
        <div class="banner">
            <div class="img_container">
                <div class="bannerBox">
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cat1.jpg?raw=true" />
                </div>
                <div class="bannerBox">
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cat2.jpg?raw=true" />
                </div>
                <div class="bannerBox">
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cat3.jpg?raw=true" />
                </div>
                <div class="bannerBox">
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cat4.jpg?raw=true" />
                </div>
            </div>
        </div>
        <div class="area_part">
            <div class="upper">
                <span>인테리어 스타일이 궁금하다면?</span>
            </div>
            <div class="lower" id="slider_container">
                <div class="slider" id="area_slider">
                    <a class="area" href="https://somoonhouse.com/newindex.jsp?theme_id=1">
                        <div>
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog4.jpg?raw=true" />
                        </div>
                        <span>모던</span>
                    </a>
                    <a class="area" href="https://somoonhouse.com/newindex.jsp?theme_id=1">
                        <div>
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog4.jpg?raw=true" />
                        </div>
                        <span>화이트</span>
                    </a>
                    <a class="area" href="https://somoonhouse.com/newindex.jsp?theme_id=1">
                        <div>
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog4.jpg?raw=true" />
                        </div>
                        <span>침실</span>
                    </a>
                    <a class="area" href="https://somoonhouse.com/newindex.jsp?theme_id=1">
                        <div>
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog4.jpg?raw=true" />
                        </div>
                        <span>화장실</span>
                    </a>
                    <a class="area" href="https://somoonhouse.com/newindex.jsp?theme_id=1">
                        <div>
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog4.jpg?raw=true" />
                        </div>
                        <span>현관</span>
                    </a>
                    <a class="area" href="https://somoonhouse.com/newindex.jsp?theme_id=1">
                        <div>
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog4.jpg?raw=true" />
                        </div>
                        <span>복도</span>
                    </a>
                    <a class="area" href="https://somoonhouse.com/newindex.jsp?theme_id=1">
                        <div>
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog4.jpg?raw=true" />
                        </div>
                        <span>베란다</span>
                    </a>
                </div>
            </div>
        </div>
        <div class="best_inter">
            <div class="upper">
                <span>BEST 인테리어</span>
                <a href="https://somoonhouse.com/newindex.jsp?theme_id=1">
                    <span class="more">더보기</span>
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/arrow.png?raw=true" />
                </a>
            </div>
            <div class="lower">
                <div class="slider">
                    <a href="https://github.com" class="best_container">
                        <div class="box">
                            <div class="box_upper">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog1.jpg?raw=true" />
                            </div>
                            <div class="box_lower">
                                <span class="title">대구 수성구 수성동 수성보성타운</span>
                                <span class="sub">아파트 | 49평형 | 거실 + 주방 | 남다른디자인</span>
                            </div>
                        </div>
                    </a>
                    <a href="https://github.com" class="best_container">
                        <div class="box">
                            <div class="box_upper">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog2.jpg?raw=true" />
                            </div>
                            <div class="box_lower">
                                <span class="title">대구 수성구 수성동 수성보성타운</span>
                                <span class="sub">아파트 | 49평형 | 거실 + 주방 | 남다른디자인</span>
                            </div>
                        </div>
                    </a>
                    <a href="https://github.com" class="best_container">
                        <div class="box">
                            <div class="box_upper"></div>
                            <div class="box_lower">
                                <span class="title">대구 수성구 수성동 수성보성타운</span>
                                <span class="sub">아파트 | 49평형 | 거실 + 주방 | 남다른디자인</span>
                            </div>
                        </div>
                    </a>
                    <a href="https://github.com" class="best_container">
                        <div class="box">
                            <div class="box_upper"></div>
                            <div class="box_lower">
                                <span class="title">대구 수성구 수성동 수성보성타운</span>
                                <span class="sub">아파트 | 49평형 | 거실 + 주방 | 남다른디자인</span>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        <div class="review">
            <div class="upper">
                <span>소문난집 이용후기</span>
            </div>
            <div class="lower">
                <div class="slider">
                    <div class="reviewBox">
                        <div class="top">
                            <div class="star">
                                <div class="block"></div>
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                            </div>
                            <span class="grade">4.8</span>
                        </div>
                        <div class="text">
                            <pre>
                            좋은 업체 소개해주셔서 감사합니다
                            오늘 점심은 혜화문식당입니다
                            </pre>
                        </div>
                        <div class="bot">
                            <span class="address">대구 북구 대현동 <span>&nbsp 김** 님</span></span>
                            <div class="under">
                                <div class="comBox">견적업체</div>
                                <span>굿하우스 / 바르다인테리어디자인 / 아이비디자인</span>
                            </div>
                        </div>
                    </div>
                    <div class="reviewBox">
                        <div class="top">
                            <div class="star">
                                <div class="block"></div>
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                            </div>
                            <span class="grade">4.2</span>
                        </div>
                        <div class="text">
                            <pre>
                            좋은 업체 소개해주셔서 감사합니다
                            오늘 점심은 혜화문식당입니다
                            </pre>
                        </div>
                        <div class="bot">
                            <span class="address">대구 북구 대현동 <span>&nbsp 김** 님</span></span>
                            <div class="under">
                                <div class="comBox">견적업체</div>
                                <span>굿하우스 / 바르다인테리어디자인 / 아이비디자인</span>
                            </div>
                        </div>
                    </div>
                    <div class="reviewBox">
                        <div class="top">
                            <div class="star">
                                <div class="block"></div>
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                            </div>
                            <span class="grade">4.5</span>
                        </div>
                        <div class="text">
                            <pre>
                            좋은 업체 소개해주셔서 감사합니다
                            오늘 점심은 혜화문식당입니다
                            </pre>
                        </div>
                        <div class="bot">
                            <span class="address">대구 북구 대현동 <span>&nbsp 김** 님</span></span>
                            <div class="under">
                                <div class="comBox">견적업체</div>
                                <span>굿하우스 / 바르다인테리어디자인 / 아이비디자인</span>
                            </div>
                        </div>
                    </div>
                    <div class="reviewBox">
                        <div class="top">
                            <div class="star">
                                <div class="block"></div>
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                            </div>
                            <span class="grade">4.1</span>
                        </div>
                        <div class="text">
                            <pre>
                            좋은 업체 소개해주셔서 감사합니다
                            오늘 점심은 혜화문식당입니다
                            </pre>
                        </div>
                        <div class="bot">
                            <span class="address">대구 북구 대현동 <span>&nbsp 김** 님</span></span>
                            <div class="under">
                                <div class="comBox">견적업체</div>
                                <span>굿하우스 / 바르다인테리어디자인 / 아이비디자인</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="style">
            <div class="upper">
                <div class="left">
                    <span>공사 금액부터 시공까지 자세히 알아보세요</span>
                    <!-- span class="sub">공사 항목부터 시공까지 자세히 알아보세요</span -->
                </div>
                <a class="right" href="https://somoonhouse.com/newindex.jsp?theme_id=1">
                    <span>더보기</span>
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/arrow.png?raw=true" />
                </a>
            </div>
            <div class="lower">
                <div class="slider">
                    <a href="https://github.com" class="style_container">
                        <div class="box">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog5.jpg?raw=true" />
                        </div>
                        <div class="text">
                            <div class="txt fir">
                                <span class="fir_title">아이비디자인</span>
                                <div class="fir_box">
                                    <span class="fir_sub">A/S 1년</span>
                                </div>
                                <div class="fir_box">
                                    <span class="fir_sub">응답우수</span>
                                </div>
                            </div>
                            <span class="txt sec">서변동 서변월드메르디앙</span>
                            <div class="txt thr">
                                <div class="thr_img">
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star.png?raw=true" />
                                </div>
                                <span>4.8</span>
                                <div class="thr_img">
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/heart2.png?raw=true" />
                                </div>
                                <span>177</span>
                            </div>
                            <div class="txt fiv">
                                <span>33평</span>
                                <div class="sidebar"></div>
                                <span>600만원</span>
                            </div>
                            <!-- span class="txt for">#북유럽 #모던 #화이트인테리어</span -->
                        </div>
                    </a>
                    <a href="https://github.com" class="style_container">
                        <div class="box">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog5.jpg?raw=true" />
                        </div>
                        <div class="text">
                            <div class="txt fir">
                                <span class="fir_title">아이비디자인</span>
                                <div class="fir_box">
                                    <span class="fir_sub">A/S 1년</span>
                                </div>
                                <div class="fir_box">
                                    <span class="fir_sub">응답우수</span>
                                </div>
                            </div>
                            <span class="txt sec">서변동 서변월드메르디앙</span>
                            <div class="txt thr">
                                <div class="thr_img">
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star.png?raw=true" />
                                </div>
                                <span>4.8</span>
                                <div class="thr_img">
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/heart2.png?raw=true" />
                                </div>
                                <span>177</span>
                            </div>
                            <div class="txt fiv">
                                <span>33평</span>
                                <div class="sidebar"></div>
                                <span>600만원</span>
                            </div>
                            <!-- span class="txt for">#북유럽 #모던 #화이트인테리어</span -->
                        </div>
                    </a>
                    <a href="https://github.com" class="style_container">
                        <div class="box">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/dog5.jpg?raw=true" />
                        </div>
                        <div class="text">
                            <div class="txt fir">
                                <span class="fir_title">아이비디자인</span>
                                <div class="fir_box">
                                    <span class="fir_sub">A/S 1년</span>
                                </div>
                                <div class="fir_box">
                                    <span class="fir_sub">응답우수</span>
                                </div>
                            </div>
                            <span class="txt sec">서변동 서변월드메르디앙</span>
                            <div class="txt thr">
                                <div class="thr_img">
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star.png?raw=true" />
                                </div>
                                <span>4.8</span>
                                <div class="thr_img">
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/heart2.png?raw=true" />
                                </div>
                                <span>177</span>
                            </div>
                            <div class="txt fiv">
                                <span>33평</span>
                                <div class="sidebar"></div>
                                <span>600만원</span>
                            </div>
                            <!-- span class="txt for">#북유럽 #모던 #화이트인테리어</span -->
                        </div>
                    </a>
                </div>
            </div>
        </div>
        <div class="free">
            <a href="https://somoonhouse.com/remodeling_form.jsp?item_num=0">
                <div class="free_text">
                    <span>우리 집 리모델링 비용은 ?</span>
                    <div class="text_lower">
                        <span class="lower_text">무료 견적 받으러 가기</span>
                        <div class="lower_img">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/arrow2.png?raw=true" />
                        </div>
                    </div>
                </div>
                <div class="free_img">
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/chat.png?raw=true" />
                </div>
            </a>
        </div>
        <div class="insta">
            <a class="title" href="https://www.instagram.com/somoonhouse/">
                <div class="icon">
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/insta.png?raw=true" />
                </div>
                <span>somoonhouse_official</span>
            </a>
            <span class="sub">소문난집 인스타그램에서<br/>
                다양한 이벤트와 소식을 확인하세요.</span>
            <div class="follow">
                <div class="follow_img">
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/heart4.png?raw=true" />
                </div>
                <span>1.2K</span>
            </div>
            <div class="imgs">
                <a href="https://www.instagram.com/somoonhouse/">
                    <div class="a"></div>
                    <div class="b"></div>
                    <div class="b"></div>
                    <div class="a"></div>
                </a>
            </div>
        </div>
        <a class="findA" href="https://somoonhouse.com/banner1.jsp?id=3">
            <div class="find">
                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/with.png?raw=true" />
            </div>
        </a>
    </div>
</div>
<jsp:include page="/newTestFooter.jsp" flush="false" />
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
            <span>010-6427-2777</span>
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
    var block = document.getElementsByClassName("block");
    var grade = document.getElementsByClassName("grade");
    for(var i = 0; i < grade.length; i++){
        var gdiffNum = (5 - grade[i].textContent[0]) * 40;
        switch(10 - grade[i].textContent[2] * 1){
            case 10: break;
            case 1: gdiffNum -= 32;
                break;
            case 2: gdiffNum -= 31;
                break;
            case 3: gdiffNum -= 27;
                break;
            case 4: gdiffNum -= 24;
                break;
            case 5: gdiffNum -= 20;
                break;
            case 6: gdiffNum -= 17;
                break;
            case 7: gdiffNum -= 15;
                break;
            case 8: gdiffNum -= 13;
                break;
            case 9: gdiffNum -= 11;
                break;
        }
        block[i].style.width = gdiffNum + "px";
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
var banner = document.getElementsByClassName("bannerBox");
var bannerPos = 0;
const bannerAutoSlide = () => {
    if(bannerPos === -100 * (banner.length - 1)){
        bannerPos = 100;
    }
    bannerPos -= 100;
    for(var i = 0; i < banner.length; i++){
        banner[i].style.transform = "translateX(" + bannerPos + "%)";
    }
}
let bannerSlideTime = setInterval(bannerAutoSlide, 3000);
</script>
</body>
</html>