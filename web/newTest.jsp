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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newTest.css"/>
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
            <div class="left_container">
                <div class="left_box">
                    <div class="img_container">
                        <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/magnifying.png?raw=true" />
                    </div>
                    <div class="text_container">
                        <input class="text_input" type="text" placeholder="전화, 고객명, 주소" />
                    </div>
                </div>
            </div>
            <div class="right_container">
                <div class="right_box">
                    <div class="text_container">
                        <span>전체보기</span>
                    </div>
                    <div class="img_container">
                        <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/underDirection.png?raw=true" />
                    </div>
                </div>
            </div>
        </div>
        <div class="main_container">
            <div class="date_container">
                <span>2021.06.02</span>
            </div>
            <div class="box_container">
                <div class="main_box">
                    <div class="text_container">
                        <div class="text"><span class="fir">주거 프라임</span></div>
                        <div class="text">
                            <span class="sec_fir">성함</span>
                            <span class="sec_sec">정진성</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">주거</span>
                            <span class="sec_sec">아파트 32평</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">주소</span>
                            <span class="thr">대구 남구 어쩌구</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">예정일</span>
                            <span class="thr">1개월 이내</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">예산</span>
                            <span class="thr">8천만원 이하</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">신청한 디자인</span>
                            <a href="https://blog.naver.com/gudwls1498/220218687283"><span class="for">월성동 e편한세상월배 34평</span></a>
                        </div>
                        <div class="text">
                            <input class="fiv" type="text" placeholder="2차 상담 방법을 입력해주세요" />
                            <button class="fiv_btn" onclick="save()">저장</button>
                        </div>
                    </div>
                    <div class="under_container">
                        <div class="side_container" onclick="calling()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/call.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>전화</span>
                            </div>
                        </div>
                        <div class="side_container" onclick="massage()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/talk.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>문자</span>
                            </div>
                        </div>
                        <div class="side_container" onclick="open_modal()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/check3.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>완료</span>
                            </div>
                        </div>
                        <div class="side_container" onclick="open_modal_non_fin()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel2.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>중단</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal_container_fin" id="modal_container_fin">
                <form method="post">
                    <div class="modal_box">
                        <div class="item_container">
                            <span class="item_span">계약 일시</span>
                            <div class="select_date">
                                <input type="date" />
                            </div>
                            <span class="item_span">계약금</span>
                            <div class="input_pay">
                                <input type="text" placeholder="계약금 입력해주세요" />
                            </div>
                            <span class="item_span">계약서 업로드</span>
                            <input class="file" type="file" />
                        </div>
                        <div class="btn_container">
                            <button type="submit"><span>완 료</span></button>
                        </div>
                        <div class="modal_cancel" onclick="close_modal()">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel.png?raw=true" />
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal_container_non_fin" id="modal_container_non_fin">
                <form method="post">
                    <div class="modal_box">
                        <div class="item_container">
                            <span class="item_span">중단 단계</span>
                            <div class="select_date">
                                <input type="date" />
                            </div>
                            <span class="item_span">중단 사유</span>
                            <div class="input_pay">
                                <input type="text" placeholder="계약금 입력해주세요" />
                            </div>
                        </div>
                        <div class="btn_container">
                            <button type="submit"><span>중 단</span></button>
                        </div>
                        <div class="modal_cancel" onclick="close_modal_non_fin()">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel.png?raw=true" />
                        </div>
                    </div>
                </form>
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
    const save = () => {
        alert("상담 방법 저장");
    }
    const calling = () => {
        alert("전화 걸기");
    }
    const massage = () => {
        alert("문자 보내기");
    }
    const recall = () => {
        alert("전화 다시 걸기");
    }
    const open_modal = () => {
        var modal = document.getElementById("modal_container_fin");
        modal.style.display = "flex"
    }
    const close_modal = () => {
        var modal = document.getElementById("modal_container_fin");
        modal.style.display = "none"
    }
    const open_modal_non_fin = () => {
        var modal = document.getElementById("modal_container_non_fin");
        modal.style.display = "flex"
    }
    const close_modal_non_fin = () => {
        var modal = document.getElementById("modal_container_non_fin");
        modal.style.display = "none"
    }
</script>
</body>
</html>