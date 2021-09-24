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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homepage.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homepage_header.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
    <div class="body_container">
        <jsp:include page="/homepage_pc_header.jsp" flush="false" />
        <jsp:include page="/homepage_mob_header.jsp" flush="false" />
        <div class="container">
            <div class="banner">
                <div class="img_container">
                    <div class="turn before" onclick="bannerLeft()">
                        <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/arrow.png?raw=true" />
                    </div>
                    <div class="bannerBox">
                        <img class="bannerImg" src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cat1.jpg?raw=true" />
                    </div>
                    <div class="bannerBox">
                        <img class="bannerImg" src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cat2.jpg?raw=true" />
                    </div>
                    <div class="bannerBox">
                        <img class="bannerImg" src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cat3.jpg?raw=true" />
                    </div>
                    <div class="bannerBox">
                        <img class="bannerImg" src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cat4.jpg?raw=true" />
                    </div>
                    <div class="turn after" onclick="bannerRight()">
                        <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/arrow.png?raw=true" />
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
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
                            <span>베란다</span>
                        </a>
                    </div>
                </div>
            </div>
            <div class="best_inter">
                <div class="upper">
                    <span>BEST 인테리어</span>
                    <div>
                        <a href="https://somoonhouse.com/newindex.jsp?theme_id=1">
                            <span>더보기</span>
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/arrow.png?raw=true" />
                        </a>
                    </div>
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
                                <div class="box_upper">
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
                                </div>
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
                    <div class="boxes" id="reviewBox">
                        <div class="reviewBox sub">
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
좋은 업체 소개해주셔서 감사합니다~~
미팅했던 두 곳은 진정성 있게 봐주셨습니다
번창하세요~~
소문난집 화이팅~~
오늘 점심은 혜화문식당입니다
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
                        <div class="reviewBox main">
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
좋은 업체 소개해주셔서 감사합니다~~
미팅했던 두 곳은 진정성 있게 봐주셨습니다
번창하세요~~
소문난집 화이팅~~
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
                        <div class="reviewBox sub">
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
좋은 업체 소개해주셔서 감사합니다~~
미팅했던 두 곳은 진정성 있게 봐주셨습니다
번창하세요~~
소문난집 화이팅~~
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
                        <div class="reviewBox sub">
                            <div class="top">
                                <div class="star">
                                    <div class="block"></div>
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                </div>
                                <span class="grade">4.9</span>
                            </div>
                            <div class="text">
<pre>
좋은 업체 소개해주셔서 감사합니다~~
미팅했던 두 곳은 진정성 있게 봐주셨습니다
번창하세요~~
소문난집 화이팅~~
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
                        <div class="reviewBox sub">
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
좋은 업체 소개해주셔서 감사합니다~~
미팅했던 두 곳은 진정성 있게 봐주셨습니다
번창하세요~~
소문난집 화이팅~~
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
                        <div class="reviewBox sub">
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
좋은 업체 소개해주셔서 감사합니다~~
미팅했던 두 곳은 진정성 있게 봐주셨습니다
번창하세요~~
소문난집 화이팅~~
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
                        <div class="reviewBox sub">
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
좋은 업체 소개해주셔서 감사합니다~~
미팅했던 두 곳은 진정성 있게 봐주셨습니다
번창하세요~~
소문난집 화이팅~~
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
                        <div class="reviewBox sub">
                            <div class="top">
                                <div class="star">
                                    <div class="block"></div>
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                </div>
                                <span class="grade">4.9</span>
                            </div>
                            <div class="text">
<pre>
좋은 업체 소개해주셔서 감사합니다~~
미팅했던 두 곳은 진정성 있게 봐주셨습니다
번창하세요~~
소문난집 화이팅~~
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
                        <div class="reviewBox sub">
                            <div class="top">
                                <div class="star">
                                    <div class="block"></div>
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/star2.png?raw=true" />
                                </div>
                                <span class="grade">5.0</span>
                            </div>
                            <div class="text">
<pre>
좋은 업체 소개해주셔서 감사합니다~~
미팅했던 두 곳은 진정성 있게 봐주셨습니다
번창하세요~~
소문난집 화이팅~~
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
                    <div class="btn_container">
                        <div class="left" onclick="goLeft()">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/arrow.png?raw=true" />
                        </div>
                        <div class="right" onclick="goRight()">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/arrow.png?raw=true" />
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
        <div class="container">
            <div class="insta">
                <div class="title">
                    <div class="icon">
                        <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/insta.png?raw=true" />
                    </div>
                    <span>somoonhouse_official</span>
                </div>
                <span class="sub">소문난집 인스타그램에서 <br>다양한 이벤트와 소식을 확인하세요.</span>
                <div class="follow">
                    <div class="follow_img">
                        <img
                                src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/heart4.png?raw=true" />
                    </div>
                    <span>1.2K</span>
                </div>
                <div class="imgs">
                    <a href="https://www.instagram.com/somoonhouse/">
                        <div class="a"></div>
                        <div class="b"></div>
                        <div class="a"></div>
                        <div class="b"></div>
                        <div class="b"></div>
                        <div class="a"></div>
                        <div class="b"></div>
                        <div class="a"></div>
                    </a>
                </div>
            </div>
        </div>
        <a class="findA" href="https://somoonhouse.com/banner1.jsp?id=3">
            <div class="find">
                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/with.png?raw=true" />
            </div>
        </a>
    </div>
    <jsp:include page="/newTestFooter.jsp" flush="false" />
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


    // banner 이미지 정보가 로드 되고나면 진행해야함.
    var bannerMinHeight = 987654321;
    var bannerImgs = document.getElementsByClassName("bannerImg");
    for(var i = 0; i < bannerImgs.length; i++){
        if(bannerImgs[i].naturalHeight < bannerMinHeight){
            bannerMinHeight = bannerImgs[i].naturalHeight;
        }
    }

    const abs = (a) => {
        return a >= 0 ? a : -1 * a;
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

    var reviewBox = document.getElementById("reviewBox");
    var boxes = document.getElementsByClassName("reviewBox");
    var mainBoxNum;
    var PCPos = Math.round(-660 + (reviewBox.clientWidth - 660) / 2);
    var MobPos = Math.round(-400 + (reviewBox.clientWidth - 400) / 2);
    if(matchMedia("(max-width: 700px)").matches){
        for(var i = 0; i < boxes.length; i++){
            if(boxes[i].className === "reviewBox main"){
                mainBoxNum = i;
            }
            boxes[i].style.transform = "translateX(" + MobPos + "px)";
        }
    }
    else{
        for(var i = 0; i < boxes.length; i++){
            if(boxes[i].className === "reviewBox main"){
                mainBoxNum = i;
            }
            boxes[i].style.transform = "translateX(" + PCPos + "px)";
        }
    }
    const goLeft = () => {
        if(mainBoxNum === 0){
            PCPos -= boxes.length * 660;
            MobPos -= boxes.length * 400;
        }
        PCPos += 660;
        MobPos += 400;
        if(matchMedia("(max-width: 700px)").matches){
            for(var i = 0; i < boxes.length; i++){
                if(boxes[i].className === "reviewBox main"){
                    mainBoxNum = i;
                }
                boxes[i].style.transform = "translateX(" + MobPos + "px)";
            }
            boxes[mainBoxNum].className = "reviewBox sub";
            mainBoxNum === 0 ? mainBoxNum = boxes.length - 1 : mainBoxNum--;
            boxes[mainBoxNum].className = "reviewBox main";
        }
        else{
            for(var i = 0; i < boxes.length; i++){
                if(boxes[i].className === "reviewBox main"){
                    mainBoxNum = i;
                }
                boxes[i].style.transform = "translateX(" + PCPos + "px)";
            }
            boxes[mainBoxNum].className = "reviewBox sub";
            mainBoxNum === 0 ? mainBoxNum = boxes.length - 1 : mainBoxNum--;
            boxes[mainBoxNum].className = "reviewBox main";
        }
    }
    const goRight = () => {
        if(mainBoxNum === boxes.length - 1){
            MobPos += boxes.length * 400;
            PCPos += boxes.length * 660;
        }
        MobPos -= 400;
        PCPos -= 660;
        if(matchMedia("(max-width: 700px)").matches){
            for(var i = 0; i < boxes.length; i++){
                if(boxes[i].className === "reviewBox main"){
                    mainBoxNum = i;
                }
                boxes[i].style.transform = "translateX(" + MobPos + "px)";
            }
            boxes[mainBoxNum].className = "reviewBox sub";
            mainBoxNum === boxes.length - 1 ? mainBoxNum = 0 : mainBoxNum++;
            boxes[mainBoxNum].className = "reviewBox main";
        }
        else{
            for(var i = 0; i < boxes.length; i++){
                if(boxes[i].className === "reviewBox main"){
                    mainBoxNum = i;
                }
                boxes[i].style.transform = "translateX(" + PCPos + "px)";
            }
            boxes[mainBoxNum].className = "reviewBox sub";
            mainBoxNum === boxes.length - 1 ? mainBoxNum = 0 : mainBoxNum++;
            boxes[mainBoxNum].className = "reviewBox main";
        }
    }
    var isSmall = reviewBox.clientWidth >= 684 ? false : true;
    const observer = new ResizeObserver((prop) => {
        if(prop[0].contentRect.width >= 684){
            if(isSmall){
                isSmall = false;
                for(var i = 0; i < boxes.length; i++){
                    boxes[i].style.transform = "translateX(" + PCPos + "px)";
                }
            }
            else{
                PCPos = Math.round(-660 + (reviewBox.clientWidth - 660) / 2 - 660 * (mainBoxNum - 1));
                for(var i = 0; i < boxes.length; i++){
                    boxes[i].style.transform = "translateX(" + PCPos + "px)";
                }
            }
        }
        else{
            if(!isSmall){
                isSmall = true;
                for(var i = 0; i < boxes.length; i++){
                    boxes[i].style.transform = "translateX(" + MobPos + "px)";
                }
            }
            else{
                MobPos = Math.round(-400 + (reviewBox.clientWidth - 400) / 2 - 400 * (mainBoxNum - 1));
                for(var i = 0; i < boxes.length; i++){
                    boxes[i].style.transform = "translateX(" + MobPos + "px)";
                }
            }
        }
    })
    observer.observe(reviewBox);

    var banner = document.getElementsByClassName("bannerBox");
    var bannerPos = 0;
    const bannerLeft = () => {
        if(bannerPos === 0){
            bannerPos = banner.length * -100;
        }
        bannerPos += 100;
        for(var i = 0; i < banner.length; i++){
            banner[i].style.transform = "translateX(" + bannerPos + "%)";
        }
    }
    const bannerRight = () => {
        if(bannerPos === -100 * (banner.length - 1)){
            bannerPos = 100;
        }
        bannerPos -= 100;
        for(var i = 0; i < banner.length; i++){
            banner[i].style.transform = "translateX(" + bannerPos + "%)";
        }
    }
    let wait = -1;
    var turn = document.getElementsByClassName("turn");
    turn[0].addEventListener("click", () => {
        if(wait === bannerSlideTime) return;
        clearInterval(bannerSlideTime);
        wait = bannerSlideTime;
        setTimeout(() => {
            bannerSlideTime = setInterval(bannerAutoSlide, 3000);
        }, 5000);
    })
    turn[1].addEventListener("click", () => {
        if(wait === bannerSlideTime) return;
        clearInterval(bannerSlideTime);
        wait = bannerSlideTime;
        setTimeout(() => {
            bannerSlideTime = setInterval(bannerAutoSlide, 3000);
        }, 5000);
    })
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
    if (window.navigator.userAgent.match(/MSIE|Internet Explorer|Trident/i)) {
        alert("Edge 또는 Chrome을 사용해주시기 바랍니다.");
        window.location = "microsoft-edge:" + window.location.href;
    }
</script>
</body>
</html>