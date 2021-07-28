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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newTest0.css"/>
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
        <div class="main_container">
            <div class="date_container">
                <span>2021.06.02</span>
            </div>
            <div class="box_container">
                <div class="main_box">
                    <div class="text_container">
                        <div class="text"><span class="fir">주거 프라임</span></div>
                        <div class="text">
                            <span class="sec_sec">아파트 32평</span>
                        </div>
                        <div class="text">
                            <span class="thr">대구 남구 어쩌구</span>
                        </div>
                        <div class="text">
                            <span class="thr">1개월 이내 / 8천만원 이하</span>
                        </div>
                        <div class="text">
                            <a href="#"><span class="for">없음</span></a>
                        </div>
                    </div>
                    <div class="under_container">
                        <a href="newTestPartnerNew.jsp" target="_self">
                            <div class="side_container">
                                <div class="img_container">
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/distri.png?raw=true" />
                                </div>
                                <div class="text_container distri">
                                    <span>수락</span>
                                </div>
                            </div>
                        </a>
                        <a href="newTestPartnerNew.jsp" target="_self">
                            <div class="side_container">
                                <div class="img_container">
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancle.png?raw=true" />
                                </div>
                                <div class="text_container">
                                    <span>거절</span>
                                </div>
                                <div class="text_container_wait">
                                    <span>남은 시간(2시간 40분)</span>
                                </div>
                            </div>
                        </a>
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
                            <span class="sec_sec">아파트 40평</span>
                        </div>
                        <div class="text">
                            <span class="thr">대구 남구 어쩌구</span>
                        </div>
                        <div class="text">
                            <span class="thr">1개월 이내 / 8천만원 이하</span>
                        </div>
                        <div class="text">
                            <a href="https://blog.naver.com/gudwls1498/220218687283"><span class="for">월성동 e편한세상월배 34평</span></a>
                        </div>
                    </div>
                    <div class="under_container">
                        <div class="side_container" onclick="acept()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/distri.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>수락</span>
                            </div>
                        </div>
                        <div class="side_container" onclick="cancle()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancle.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>거절</span>
                            </div>
                            <div class="text_container_wait">
                                <span>남은 시간(2시간 40분)</span>
                            </div>
                        </div>
                    </div>
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
    const acept = () =>{
        alert("수락했습니다.")
    }
    const cancle = () =>{
        alert("거절했습니다.")
    }
</script>
</body>
</html>