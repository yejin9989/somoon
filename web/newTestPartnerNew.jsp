<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    //필요한 변수 선언
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
    query = "select * from COUPON where Id > 1"; // 이벤트 쿠폰은 제외한 상품
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    HashMap<String, HashMap<String, String>> coupon = new HashMap<String, HashMap<String, String>>();
    while(rs.next()) {
        HashMap<String, String> hm = new HashMap<String, String>();
        hm.put("name", rs.getString("Name"));
        hm.put("period", rs.getString("Period"));
        hm.put("quantity", rs.getString("Quantity"));
        hm.put("origin", rs.getString("Origin"));
        hm.put("extra", rs.getString("Extra"));
        hm.put("price", rs.getString("Price"));
        coupon.put(rs.getString("Id"), hm);
    }
    pstmt.close();
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
                <%
                for(String key: coupon.keySet()){
                    HashMap item = coupon.get(key);
        %>
                <div class="goods_container">
                    <div class="goods_left_box">
                        <div class="text_area">
                            <span class="upper_text"><%=item.get("name")%></span><!--span class="upper_text">주거 프라임</span-->
                        </div>
                        <div class="text_area">
                            <span class="mid_text">결제일로부터 <span class="mid_date_text"><%=item.get("period")%>일간</span></span>
                        </div>
                        <div class="text_area">
                            <span class="lower_text">전체 <%=item.get("quantity")%>건 <span class="lower_text_inner">(기본
                                <%=item.get("origin")%>건
                                + 보완 <%=item.get("extra")%>건)</span></span>
                        </div>
                    </div>
                    <div class="goods_mid_box">
                        <span><%=item.get("price")%>원</span>
                        <span class="vat">(VAT 포함)</span>
                    </div>
                    <div class="goods_right_box" id="<%=key%>" onclick="open_modal(this)">
                        <span>신청하기</span>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
        <%
            for(String key: coupon.keySet()){
                HashMap item = coupon.get(key);
        %>
        <div class="modal_container" id="modal_container<%=key%>">
            <div class="modal_box_before" id="modal_box_before<%=key%>">
                <div class="item_container">
                    <span class="item_span">선택한 상품</span>
                    <div class="select_item">
                        <div class="text_area">
                            <span class="upper_text"><%=item.get("name")%> (<%=item.get("origin")%>건)</span>
                        </div>
                        <div class="text_area">
                            <span class="mid_text">결제일로부터 <span class="mid_date_text"><%=item.get("period")%>일간</span>
                        </div>
                        <div class="text_area">
                            <span class="lower_text">전체 <%=item.get("quantity")%>건 <span class="lower_text_inner">(기본
                                <%=item.get("origin")%>건
                                + 보완 <%=item.get("extra")%>건)</span></span>
                        </div>
                    </div>
                    <span class="item_span">가격 : <%=item.get("price")%>원</span>
                    <span class="item_span">결제 방법 선택</span>
                    <div class="choice_item">
                        <input type="radio" checked/> <span class="item_span">계좌이체</span>
                    </div>
                </div>
                <div class="btn_container">
                    <button id="next<%=key%>" onclick="modal_next(this)"><span>신 청 하 기</span></button>
                </div>
                <div class="modal_cancel" id="cancel<%=key%>" onclick="close_modal(this)">
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel.png?raw=true" />
                </div>
            </div>
            <div class="modal_box_after" id="modal_box_after<%=key%>">
                <div class="item_container">
                    <span class="item_span">입금 받을 계좌</span>
                    <span class="item_span">예금주 : 길영민(밀리무드)</span>
                    <span class="item_span fir">국민은행 616101-04-263999</span>
                    <span class="item_span sec">입금자 명의를 회사명으로 입금 해주세요.</span>
                    <span class="item_span sec">ex) 홍길동인테리어</span>
                    <span class="item_span thr">입금자 명의 관련 문의 : 010-4399-7660</span>
                </div>
                <div class="btn_container">
                    <button id="prev<%=key%>" onclick="modal_previous(this)"><span>신 청 취 소</span></button>
                </div>
                <div class="modal_cancel" id="close<%=key%>" onclick="close_modal(this)">
                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel.png?raw=true" />
                </div>
            </div>
        </div>
        <%}%>
    </div>
    <jsp:include page="/newTestFooter.jsp" flush="false" />
</div>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
<script>
    function open_modal(obj){
        var key = $(obj).attr("id");
        var modal = document.getElementById("modal_container"+key);
        modal.style.display = "flex"
    }
    function close_modal(obj){
        var key = $(obj).attr("id").replaceAll("cancel", "").replaceAll("close", "");
        var modal = document.getElementById("modal_container"+key);
        modal.style.display = "none"
    }
    function modal_next(obj){
        var key = $(obj).attr("id").replaceAll("next", "");
        var before_modal = document.getElementById("modal_box_before"+key);
        var after_modal = document.getElementById("modal_box_after"+key);
        before_modal.style.display = "none";
        after_modal.style.display = "block";
    }
    function modal_previous(obj){
        var key = $(obj).attr("id").replaceAll("prev", "");
        var before_modal = document.getElementById("modal_box_before"+key);
        var after_modal = document.getElementById("modal_box_after"+key);
        after_modal.style.display = "none";
        before_modal.style.display = "block";
    }
</script>
</body>
</html>