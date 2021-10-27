<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    //캐시 설정 - 이미지 캐시 폐기 기간을 늘려서 반응속도를 올림
    response.setHeader("Cache-Control", "no-cache")  ,;
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/interiors.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>

<div class="body_container">
    <jsp:include page="/homepage_pc_header.jsp" flush="false" />
    <jsp:include page="/homepage_mob_header.jsp" flush="false" />
    <div class="interior_container">
        <!-- div class="upper" id="interior_upper">
            <div class="searchBoxContainer">
                <form id="form_done" name="form_done" method="POST" action="newTest1.jsp">
                    <div class="searchBox" id="searchBox">
                        <div class="img_container">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/magnifying.png?raw=true" />
                        </div>
                        <div class="text_container">
                            <input class="text_input" id="searchTextInput" type="text" placeholder="" value=""/>
                            <input class="searchSubmit" type="submit" />
                        </div>
                    </div>
                </form>
            </div>
            <div class="filter" id="filter">
                <button onclick="openFilterSlider()">필터</button>
            </div>
            <div class="filterSlider" id="filterSlider">
            </div>
        </div>
        <div id="upperShadow"></div -->
        <div>소문난집 파트너스에 신청하세요!
            소문난집 파트너스 목록
        </div>
        <div class="interior_body">테스트</div>
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
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'G-PC15JG6KGN');
</script>
<script>
    const tagData = {
        area : ["중구", "동구", "서구", "남구", "북구", "수성구", "달서구", "달성군", "경북"],
        hashtag : ["모던", "화이트", "블랙", "미니멀"]
    }

    var upper = document.getElementById("interior_upper");
    upper.style.top = "102px";
    handler.set = (obj, prop, value) => {
        obj[prop] = value;
        value ?
            upper.style.top = "102px"
            :
            upper.style.top = "0";
    }

    const upperShadow = document.getElementById("upperShadow");
    upperShadow.style.height = upper.clientHeight + "px";

    const openFilterSlider = () => {
        var filterSlider = document.getElementById("filterSlider");
        if(filterSlider.style.display === "flex"){
            filterSlider.style.display = "none";
            upperShadow.style.height = upper.clientHeight + "px";
        }
        else{
            filterSlider.style.display = "flex";
            upperShadow.style.height = upper.clientHeight + "px";
        }
    }

    const searchTextInput = document.getElementById("searchTextInput");
    const searchBox = document.getElementById("searchBox");
    searchTextInput.addEventListener('focus', () => {
        searchBox.style.background = "#fff";
    })
    searchTextInput.addEventListener('blur', () => {
        searchBox.style.background = "#fafafa";
    })


    const filter = document.getElementById("filter");
    const filterSlider = document.getElementById("filterSlider");
    console.log(tagData[0]);

    var i = 0;
    for(i; i < tagData.area.length; i++){
        filter.innerHTML +=
            "<div class='nowTagBox' onclick='clickToNone(this, " + i + ")'>" +
            "<div class='leftTag sideTag'></div>" +
            "<div class='nowTag tag" + i + "'>" + tagData.area[i] +
            "<div>X</div></div>" +
            "<div class='rightTag sideTag'></div></div>";
        filterSlider.innerHTML +=
            "<div class='allTagBox' onclick='test(this, " + i + ")'>" +
            "<div class='leftTag sideTag'></div>" +
            "<div class='allTag tag" + i + "'>" + tagData.area[i] +
            "<div class='onOff'>X</div>" +
            "</div><div class='rightTag sideTag'></div></div>";
    }
    for(var j = 0, i; j < tagData.hashtag.length; i++, j++){
        filter.innerHTML +=
            "<div class='nowTagBox' onclick='clickToNone(this, " + i + ")'>" +
            "<div class='leftTag sideTag'></div>" +
            "<div class='nowTag tag" + i + "'>" + tagData.hashtag[j] +
            "<div>X</div></div>" +
            "<div class='rightTag sideTag'></div></div>";
        filterSlider.innerHTML +=
            "<div class='allTagBox' onclick='test(this, " + i + ")'>" +
            "<div class='leftTag sideTag'></div>" +
            "<div class='allTag tag" + i + "'>" + tagData.hashtag[j] +
            "<div class='onOff'>X</div>" +
            "</div><div class='rightTag sideTag'></div></div>";
    }

    var nowTag = document.getElementsByClassName("nowTag");
    var allTag = document.getElementsByClassName("allTag");
    var nowTagBox = document.getElementsByClassName("nowTagBox");
    var allTagBox = document.getElementsByClassName("allTagBox");
    var onOff = document.getElementsByClassName("onOff");
    var leftTag = document.getElementsByClassName("leftTag");
    var rightTag = document.getElementsByClassName("rightTag");
    const clickToNone = (prop, index) => {
        nowTagBox[index].style.display = "none";
        onOff[index].style.visibility = "hidden";
    }
    const test = (prop, index) => {
        if(onOff[index].style.visibility === "visible"){
            onOff[index].style.visibility = "hidden";
            nowTagBox[index].style.display = "none";
        }
        else{
            onOff[index].style.visibility = "visible";
            nowTagBox[index].style.display = "flex";
        }
    }

</script>
</body>
</html>