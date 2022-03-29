<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
    String s_id = session.getAttribute("s_id") + "";// 현재 사용자 current user

    //파라미터 가져오기
    String r_state = request.getParameter("state");

    //리뷰담는 클래스 선언
    class Reviews {
        HashMap<String, HashMap<String, String>> reviews;
        HashMap<String, LinkedList<String>> imgs;

        void setReviews(HashMap reviews) {
            this.reviews = reviews;
        }

        void setImgs(HashMap imgs) {
            this.imgs = imgs;
        }

        HashMap getReviews() {
            return this.reviews;
        }

        HashMap getImgs() {
            return this.imgs;
        }
    }

    //필요한 변수 선언
    int i, j;
    String mylog = "";
    int rate1 = 0, rate2 = 0, rate3 = 0 ,rate4 =0, rate5 = 0;
    float rate_total = 0;

    //DB 관련 객체 선언
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null, rs1 = null;
    PreparedStatement pstmt = null, pstmt1 = null;
    String query, query1;
    String sql = "";

    //DB 가져오기 예시
//    query = "select rev *, img img from client_review as rev INNER JOIN client_review_img as img ON rev.id = img.id";
    LinkedList<Reviews> rev_list = new LinkedList<Reviews>();
    query = "SELECT * FROM client_review";
    if(r_state != null){
        query = query + " WHERE state = " + r_state;
    }
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    while (rs.next()) {

        HashMap<String, HashMap<String, String>> reviews = new HashMap<String, HashMap<String, String>>();
        HashMap<String, LinkedList<String>> imgs = new HashMap<String, LinkedList<String>>();
        Reviews rev_tot = new Reviews();

        String id = rs.getString("id")+"";
        String client = rs.getString("remodeling_apply_id")+"";
        String company = rs.getString("company_id")+"";

        HashMap<String, String> rev = new HashMap<String, String>();
        String state = rs.getString("state")+"";
        String rate = rs.getString("rate")+"";
        String text = rs.getString("text")+"";
        String submit_date = rs.getString("submit_date");
//        submit_date = submit_date.substring(0,submit_date.lastIndexOf("."));
        text = text.replaceAll("\r\n", "<br/>");
        if (state.equals("0")) {
            state = "상담평가";
        } else {
            state = "시공평가";
        }
        rev.put("state", state);
        rev.put("rate", rate);
        rev.put("text", text);
        rev.put("submit_date", submit_date);

        query1 = "SELECT Name FROM COMPANY WHERE Id = " + company;
        pstmt1 = conn.prepareStatement(query1);
        rs1 = pstmt1.executeQuery();
        while (rs1.next()) {
            String pname = rs1.getString("Name") + "";

            rev.put("comp_id",company);
            rev.put("company", pname);
        }

        query1 = "SELECT Name,Phone FROM REMODELING_APPLY WHERE Number = " + client;
        pstmt1 = conn.prepareStatement(query1);
        rs1 = pstmt1.executeQuery();
        while (rs1.next()) {
            String cname = rs1.getString("Name") + "";
            String phone = rs1.getString("Phone") + "";
            phone = phone.substring(phone.length()-4, phone.length());

            rev.put("cli_id",client);
            rev.put("client", cname);
            rev.put("pass",phone);
        }

        reviews.put(id, rev);


        LinkedList<String> img = new LinkedList<String>();
        String rev_id = rs.getString("id") + "";
        query1 = "SELECT * FROM client_review_img WHERE id = " + rev_id;
        pstmt1 = conn.prepareStatement(query1);
        rs1 = pstmt1.executeQuery();
        int num = 0;
        while (rs1.next()) {
            img.add(rs1.getString("img") + "");
        }

        imgs.put(id, img);

        rev_tot.setReviews(reviews);
        rev_tot.setImgs(imgs);

        rev_list.add(rev_tot);
    }
    pstmt.close();
//    pstmt1.close();

%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/review.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homepage_header.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
    <title>소문난집</title>
    <!-- 사용자 행동 정보 수집 코드 시작 - Meta, GA -->
    <!-- 모든 페이지에 하나씩만 포함되어 있어야 합니다. 위치는 </head> 바로 위로 통일 -->
    <!-- Meta Pixel Code -->
    <script>
        !function (f, b, e, v, n, t, s) {
            if (f.fbq) return;
            n = f.fbq = function () {
                n.callMethod ?
                    n.callMethod.apply(n, arguments) : n.queue.push(arguments)
            };
            if (!f._fbq) f._fbq = n;
            n.push = n;
            n.loaded = !0;
            n.version = '2.0';
            n.queue = [];
            t = b.createElement(e);
            t.async = !0;
            t.src = v;
            s = b.getElementsByTagName(e)[0];
            s.parentNode.insertBefore(t, s)
        }(window, document, 'script',
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

        function gtag() {
            dataLayer.push(arguments);
        }

        gtag('js', new Date());
        gtag('config', 'G-PC15JG6KGN');
    </script>
    <!-- END Global site tag (gtag.js) - Google Analytics -->
    <!-- Google Tag Manager -->
    <script>(function (w, d, s, l, i) {
        w[l] = w[l] || [];
        w[l].push({
            'gtm.start':
                new Date().getTime(), event: 'gtm.js'
        });
        var f = d.getElementsByTagName(s)[0],
            j = d.createElement(s), dl = l != 'dataLayer' ? '&l=' + l : '';
        j.async = true;
        j.src =
            'https://www.googletagmanager.com/gtm.js?id=' + i + dl;
        f.parentNode.insertBefore(j, f);
    })(window, document, 'script', 'dataLayer', 'GTM-TQFGN2T');</script>
    <!-- End Google Tag Manager -->
    <!-- 사용자 행동 정보 수집 코드 끝 - Meta, GA -->
</head>
<body>
<jsp:include page="/homepage_pc_header.jsp" flush="false"/>
<jsp:include page="/homepage_mob_header.jsp" flush="false"/>
<div class="body_container" id="reviewContainer">
    <div class="container">
        <div class="header">
            <div class="img_container">
                <img src="https://somoonhouse.com/otherimg/assets/com.png?raw=true" />
            </div>
            <span>리뷰 관리</span>
        </div>
        <div class="reviewShowContainer">
            <div class="reviewShowUpperTextContainer">
                <span class="intro"><div class="graph_btn" onclick="open_graph()">평균 평점 및 그래프 보기</div></span>
                <div id="avg_rate" class="right" style="display: none"><span>평균 평점</span><span id="rate_num" class="num"></span></div>
            </div>
            <div id="reviewShowOuterBox" style="display: none">
                <div class="reviewShowBox">
                    <div class="reviewPart">
                        <div class="line">
                            <div class="chart">
                                <div id ="point1"></div>
                                <div class="lineBar"></div>
                            </div>
                        </div>
                    </div>
                    <div class="reviewPart">
                        <div class="line">
                            <div class="chart">
                                <div id ="point2"></div>
                                <div class="lineBar"></div>
                            </div>
                        </div>
                    </div>
                    <div class="reviewPart">
                        <div class="line">
                            <div class="chart">
                                <div id ="point3"></div>
                                <div class="lineBar"></div>
                            </div>
                        </div>
                    </div>
                    <div class="reviewPart">
                        <div class="line">
                            <div class="chart">
                                <div id ="point4"></div>
                                <div class="lineBar"></div>
                            </div>
                        </div>
                    </div>
                    <div class="reviewPart">
                        <div class="line">
                            <div class="chart">
                                <div id ="point5"></div>
                                <div class="lineBar"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="reviewShowBox" id="score">
                    <div class="reviewPart">1점</div>
                    <div class="reviewPart">2점</div>
                    <div class="reviewPart">3점</div>
                    <div class="reviewPart">4점</div>
                    <div class="reviewPart">5점</div>
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
            <div class="reviewRealUpperTextContainer">
                <div id="rev_type_btn">
                    <span id="show_all" class="sel_state">전체 보기</span>
                    <span class="mid">|</span>
                    <span id="show_mid" class="sel_state">상담 평가</span>
                    <span class="mid">|</span>
                    <span id="show_fin" class="sel_state">시공 평가</span>
                </div>
            </div>
            <!-- 사진 있는 후기 먼저 보여줘야함 -->
            <%
                //Arraylist- itemlist에 있는 개수만큼 반복하기1
                for (int idx = 0; idx < rev_list.size(); idx++) {
                    for (String key : rev_list.get(idx).reviews.keySet()) {
                        HashMap review = rev_list.get(idx).reviews.get(key);
                        LinkedList image = rev_list.get(idx).imgs.get(key);
                        String rate = (String) review.get("rate");
                        switch (rate){
                            case "1":
                                rate1++;
                                rate_total+=1;
                                break;
                            case "2":
                                rate2++;
                                rate_total+=2;
                                break;
                            case "3":
                                rate3++;
                                rate_total+=3;
                                break;
                            case "4":
                                rate4++;
                                rate_total+=4;
                                break;
                            case "5":
                                rate5++;
                                rate_total+=5;
                        }
            %>
            <div class="reviewRealBox">
                <div class="upper">
                    <div class="infoDiv">
                        <span class ="rate_star">
                            <%for(int star=0; star < Integer.parseInt(review.get("rate").toString());star++){%>
                            <img src="https://somoonhouse.com/img/onStar.png"><%}
                            for(int star=0; star < 5 - Integer.parseInt(review.get("rate").toString());star++){%>
                            <img src="https://somoonhouse.com/img/noStar.png">
                            <%}%>
                        </span>
                        <span class="num"><%=review.get("rate")%>점</span>
                    </div>
                    <div class="infoDiv">
                        <span class="state"><%=review.get("state")%></span>
                        <span class="mid">|</span>
                        <span class="date">등록 일시 : <%=review.get("submit_date")%></span>
                    </div>
                    <div class="infoDiv infoDiv1">
                        <span class="cli info" id="<%=review.get("cli_id")%>"><%=review.get("client")%>(pw:<%=review.get("pass")%>)</span>
                        <span class="mid">|</span>
                        <span class="comp info" id="<%=review.get("comp_id")%>"><%=review.get("company")%></span>
                    </div>
                </div>
                <div class="imgs">
                    <%
                        Iterator<String> iter = image.iterator();
                        while (iter.hasNext()) {
                    %>
                    <div>
                        <img src="<%=iter.next()%>"/>
                    </div>
                    <%}%>
<%--                    <div class="lastImg"></div>--%>
                </div>
                <div class="text">
                    <span><%=review.get("text")%></span>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</div>
<jsp:include page="/newTestFooter.jsp" flush="false"/>
<%
    if (pstmt != null) {
        pstmt.close();
        rs.close();
        query = "";
        conn.close();
    }
%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<%--    <script src="./consultReviewData.js"></script>--%>
<script>
    //평점별 그래프 그리기
    let data = [<%=rate1%>, <%=rate2%>, <%=rate3%>, <%=rate4%>, <%=rate5%>];
    for(let i = 0; i<5; i++){
        document.getElementById("point"+(i+1).toString()).innerHTML = data[i];
    }
    var highData = 0;
    data.forEach((prop) => {
        if (prop > highData) {
            highData = prop;
        }
    })
    var maxData = Math.round((highData / 10) * 9);
    let percentData = data.map((prop) => {
        return Math.floor((1-(prop / maxData)) * 1000)*9/100 +10;
    })

    var chart = document.getElementsByClassName("chart");
    for (i = 0; i < chart.length; i++) {
        chart[i].style.top = percentData[i] + "%";
    }

    //전체 평균 평점 계산
    let total = <%=rate_total%>, cnt1 = <%=rate1%>+<%=rate2%>+<%=rate3%>;
    let cnt2 = <%=rate4%>+<%=rate5%>;
    let cnt = cnt1+cnt2;
    let avg = Math.floor(total/cnt*10)/10;
    avg = avg.toFixed(1);
    document.getElementById("rate_num").innerHTML = avg;

    $('.comp').click(function () {
        location.href = "https://somoonhouse.com/interior_info.jsp?id=" + $(this).attr('id');
    })
    $('.cli').click(function () {
        location.href = "https://somoonhouse.com/customer_login.jsp?customer_num=" + $(this).attr('id');
    })

    const open_graph = () => {
        var graph = document.getElementById("reviewShowOuterBox");
        var avg_score = document.getElementById("avg_rate");
        if(graph.style.display === 'none'){
            graph.style.display = 'block';
            avg_score.style.display = 'inline';
        }
        else{
            graph.style.display = 'none';
            avg_score.style.display = 'none';
        }
    }
    $('#show_all').click(function () {
        location.href = "https://somoonhouse.com/review.jsp";
    })
    $('#show_mid').click(function () {
        location.href = "https://somoonhouse.com/review.jsp?state=0";
    })
    $('#show_fin').click(function () {
        location.href = "https://somoonhouse.com/review.jsp?state=1";
    })

    // var reviewRealContainer = document.getElementById("reviewRealContainer");
    //
    // const createEle = (sortOfElement, className) => {
    //     let nameOfElement = document.createElement(sortOfElement);
    //     if (className !== undefined) nameOfElement.className = className;
    //     return nameOfElement;
    // }
    // const makeNoImgReviewBox = (prop) => {
    //     let reviewBox, reviewBoxUpper, upperNum, infoDiv, info, infoMid, reviewText, reviewTextSpan;
    //     reviewBox = createEle("div", "reviewRealBox");
    //     reviewBoxUpper = createEle("div", "upper");
    //     upperNum = createEle("span", "num");
    //     infoDiv = createEle("div", "infoDiv");
    //     info = createEle("span", "info");
    //     infoMid = createEle("span", "mid");
    //     reviewText = createEle("div", "text");
    //     reviewTextSpan = createEle("span");
    //
    //     const str = prop.content.replaceAll('\\n', '<br/>');
    //     upperNum.innerHTML = prop.point;
    //     //info.innerHTML =
    //     //infoMid.innerHTML = '|';
    //     reviewTextSpan.innerHTML = str;
    //
    //     reviewRealContainer.appendChild(reviewBox);
    //     reviewBox.appendChild(reviewBoxUpper);
    //     reviewBox.appendChild(reviewText);
    //     reviewBoxUpper.appendChild(upperNum);
    //     reviewBoxUpper.appendChild(infoDiv);
    //     //infoDiv.appendChild(info);
    //     //infoDiv.appendChild(infoMid);
    //     //infoDiv.appendChild(info);
    //     reviewText.appendChild(reviewTextSpan);
    // }
</script>
</body>
</html>