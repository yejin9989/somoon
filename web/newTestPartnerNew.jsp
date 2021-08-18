<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    //필요한 변수 선언
    int i, j;
    String mylog = "";

    //파라미터 가져오기
    //String param = request.getParameter("param");

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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newTestPartnerNew.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
<%=mylog%>
<%
%>
<div class="body_container">
    <jsp:include page="/newTestHeader.jsp" flush="false" />
    <div class="body_main">
        <div class="main_header">
            <div class="img_container">
                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/com.png?raw=true" />
            </div>
            <span>소문난집 파트너를 위한 상품</span>
        </div>
        <div class="main_container">
            <div class="partner_container">
                <div class="goods_container">
                    <div class="goods_left_box">
                        <div class="text_area">
                            <span class="upper_text">주거 프라임</span>
                        </div>
                        <div class="text_area">
                            <span class="mid_text">기간 <span class="mid_date_text">2021.06.01 ~ 2021.06.30</span></span>
                        </div>
                        <div class="text_area">
                            <span class="lower_text">배분 5건</span>
                        </div>
                    </div>
                    <div class="goods_mid_box">
                        <span>34,500원</span>
                    </div>
                    <div class="goods_right_box" onclick="open_modal()">
                        <span>신청하기</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal_container" id="modal_container">
            <div class="modal_box_before" id="modal_box_before">
                <div class="item_container">
                    <span class="item_span">선택한 상품</span>
                    <div class="select_item">
                        <div class="text_area">
                            <span class="upper_text">주거 프라임</span>
                        </div>
                        <div class="text_area">
                            <span class="mid_text">기간 <span class="mid_date_text">2021.06.01 ~ 2021.06.30</span></span>
                        </div>
                        <div class="text_area">
                            <span class="lower_text">배분 5건</span>
                        </div>
                    </div>
                    <span class="item_span">가격 : 34,500원</span>
                    <span class="item_span">결제 방법 선택</span>
                    <div class="choice_item">
                        <input type="radio" checked/> <span class="item_span">계좌이체</span>
                    </div>
                </div>
                <div class="btn_container">
                    <button onclick="modal_next()"><span>신 청 하 기</span></button>
                </div>
                <div class="modal_cancel" onclick="close_modal()">
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel.png?raw=true" />
                </div>
            </div>
            <div class="modal_box_after" id="modal_box_after">
                <div class="item_container">
                    <span class="item_span">입금 받을 계좌</span>
                    <span class="item_span fir">대구은행 1234-1234-12344</span>
                    <span class="item_span sec">입금자 명의를 회사명으로 입금 해주세요.</span>
                    <span class="item_span sec">ex) 홍길동인테리어</span>
                    <span class="item_span thr">입금자 명의 관련 문의 : 010-1234-1234</span>
                </div>
                <div class="btn_container">
                    <button onclick="modal_previous()"><span>신 청 취 소</span></button>
                </div>
                <div class="modal_cancel" onclick="close_modal()">
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel.png?raw=true" />
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/newTestFooter.jsp" flush="false" />
</div>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
<script>
    function open_modal(){
        var modal = document.getElementById("modal_container");
        modal.style.display = "flex"
    }
    function close_modal(){
        var modal = document.getElementById("modal_container");
        modal.style.display = "none"
    }
    function modal_next(){
        var before_modal = document.getElementById("modal_box_before");
        var after_modal = document.getElementById("modal_box_after");
        before_modal.style.display = "none";
        after_modal.style.display = "block";
    }
    function modal_previous(){
        var before_modal = document.getElementById("modal_box_before");
        var after_modal = document.getElementById("modal_box_after");
        after_modal.style.display = "none";
        before_modal.style.display = "block";
    }
</script>
</body>
</html>