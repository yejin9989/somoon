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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newTest2.css"/>
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
        </div>
        <div class="main_body">
            <div class="main_container">
                <div class="main_box">
                    <div class="left_box">
                        <div class="upper_container">
                            <div class="text_container">
                                <span>홍길동 | <span class="sub_text">대구 달성군 다사읍 죽곡리 15</span></span>
                            </div>
                        </div>
                        <div class="under_container">
                            <div class="under_box">
                                <span>계약 미성사 : 2021.05.18</span>
                            </div>
                        </div>
                    </div>
                    <div class="right_box">
                        <div class="img_container">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/underDirection.png?raw=true" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="main_container">
                <div class="main_box">
                    <div class="left_box">
                        <div class="upper_container">
                            <div class="text_container">
                                <span>홍길동 | <span class="sub_text">대구 달성군 다사읍 죽곡리 15</span></span>
                            </div>
                        </div>
                        <div class="under_container">
                            <div class="under_box">
                                <span>계약 미성사 : 2021.05.18</span>
                            </div>
                        </div>
                    </div>
                    <div class="right_box">
                        <div class="img_container">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/underDirection.png?raw=true" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="main_container">
                <div class="main_box">
                    <div class="left_box">
                        <div class="upper_container">
                            <div class="text_container">
                                <span>홍길동 | <span class="sub_text">대구 달성군 다사읍 죽곡리 15</span></span>
                            </div>
                        </div>
                        <div class="under_container">
                            <div class="under_box">
                                <span>계약 미성사 : 2021.05.18</span>
                            </div>
                        </div>
                    </div>
                    <div class="right_box">
                        <div class="img_container">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/underDirection.png?raw=true" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="main_container">
                <div class="main_box">
                    <div class="left_box">
                        <div class="upper_container">
                            <div class="text_container">
                                <span>홍길동 | <span class="sub_text">대구 달성군 다사읍 죽곡리 15</span></span>
                            </div>
                        </div>
                        <div class="under_container">
                            <div class="under_box">
                                <span>계약 미성사 : 2021.05.18</span>
                            </div>
                        </div>
                    </div>
                    <div class="right_box">
                        <div class="img_container">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/underDirection.png?raw=true" />
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
    //새 스크립트 작성
    //window.close();
</script>
</body>
</html>