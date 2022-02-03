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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/review.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homepage_header.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
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
    <jsp:include page="/homepage_pc_header.jsp" flush="false" />
    <jsp:include page="/homepage_mob_header.jsp" flush="false" />
    <div class="body_container" id="reviewContainer">
        <div class="container">
            <div class="reviewShowContainer">
                <div class="reviewShowUpperTextContainer">
                    <span class="intro">소문난집에서 인테리어하고 대박나세요!</span>
                    <div class="right"><span>평균 만족도 </span><span class="num">4.9</span></div>
                </div>
                <div class="reviewShowBox">
                    <div class="reviewPart">
                        <div class="line">
                            <div class="chart">
                                <div class="point"></div>
                                <div class="lineBar"></div>
                            </div>
                        </div>
                    </div>
                    <div class="reviewPart">
                        <div class="line">
                            <div class="chart">
                                <div class="point"></div>
                                <div class="lineBar"></div>
                            </div>
                        </div>
                    </div>
                    <div class="reviewPart">
                        <div class="line">
                            <div class="chart">
                                <div class="point"></div>
                                <div class="lineBar"></div>
                            </div>
                        </div>
                    </div>
                    <div class="reviewPart">
                        <div class="line">
                            <div class="chart">
                                <div class="point"></div>
                                <div class="lineBar"></div>
                            </div>
                        </div>
                    </div>
                    <div class="reviewPart">
                        <div class="line">
                            <div class="chart">
                                <div class="point"></div>
                                <div class="lineBar"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--div class="reviewNumBox">
                    <div>1</div>
                    <div>2</div>
                    <div>3</div>
                    <div>4</div>
                    <div>5</div>
                </div-->
            </div>
            <div class="reviewRealContainer" id="reviewRealContainer">
                <div class="reviewRealUpperTextContainer"><span>고객님들의 생생 후기!</span></div>
                <!-- 사진 있는 후기 먼저 보여줘야함 -->
                <!--div class="reviewRealBox">
                    <div class="upper">
                        <span class="num">4.9</span>
                        <div class="infoDiv">
                            <span class="info">김○○님</span><span class="mid">|</span><span class="info">OROKOS 인테리어</span>
                        </div>
                    </div>
                    <div class="imgs">
                        <div>
                            <img src="https://somoonhouse.com/otherimg/assets/dog1.jpg?raw=true" />
                        </div>
                        <div>
                            <img src="https://somoonhouse.com/otherimg/assets/dog2.jpg?raw=true" />
                        </div>
                        <div>
                            <img src="https://somoonhouse.com/otherimg/assets/cat1.jpg?raw=true" />
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
                </div-->
            </div>
        </div>
    </div>
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
    <script src="./consultReviewData.js"></script>
<script>
    let data = [10, 8, 20, 400, 512];
    var highData = 0;
    data.forEach((prop) => {
        if(prop > highData){
            highData = prop;
        }
    })
    var maxData = Math.round((highData / 9) * 10);
    let percentData = data.map((prop) => {
        return Math.floor((0.97 - (prop / maxData)) * 1000) / 10;
    })

    var chart = document.getElementsByClassName("chart");
    for(var i = 0; i < chart.length; i++){
        chart[i].style.top = percentData[i] + "%";
    }


    var reviewRealContainer = document.getElementById("reviewRealContainer");

    const makeNoImgReviewBox = (prop) => {
        let reviewBox, reviewBoxUpper, upperNum, infoDiv, info, infoMid, reviewText, reviewTextSpan;
        reviewBox = createEle("div", "reviewRealBox");
        reviewBoxUpper = createEle("div", "upper");
        upperNum = createEle("span", "num");
        infoDiv = createEle("div", "infoDiv");
        info = createEle("span", "info");
        infoMid = createEle("span", "mid");
        reviewText = createEle("div", "text");
        reviewTextSpan = createEle("span");

        const str = prop.content.replaceAll('\\n', '<br/>');
        upperNum.innerHTML = prop.point;
        //info.innerHTML =
        //infoMid.innerHTML = '|';
        reviewTextSpan.innerHTML = str;

        reviewRealContainer.appendChild(reviewBox);
        reviewBox.appendChild(reviewBoxUpper);
        reviewBox.appendChild(reviewText);
        reviewBoxUpper.appendChild(upperNum);
        reviewBoxUpper.appendChild(infoDiv);
        //infoDiv.appendChild(info);
        //infoDiv.appendChild(infoMid);
        //infoDiv.appendChild(info);
        reviewText.appendChild(reviewTextSpan);
    }



</script>
</body>
</html>