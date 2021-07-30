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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newTestBoard.css"/>
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
        <div class="board_title">
            <span>익명게시판</span>
        </div>
        <div class="board_body">
            <div class="board_header">
                <div class="sub num">No</div>
                <div class="sub title">제목</div>
                <div class="sub date">작성시간</div>
                <div class="sub like">공감</div>
            </div>
            <a href="newTestWritten.jsp" target="_self">
                <div class="board_content">
                    <div class="sub num">1</div>
                    <div class="sub title">반갑습니다</div>
                    <div class="sub date">2021-12-17</div>
                    <div class="sub like">0</div>
                </div>
            </a>
            <a href="newTestWritten.jsp" target="_self">
                <div class="board_content">
                    <div class="sub num">1</div>
                    <div class="sub title">반갑습니다</div>
                    <div class="sub date">2021-12-17</div>
                    <div class="sub like">0</div>
                </div>
            </a>
        </div>
        <div class="board_footer">
            <button onclick="location.href = 'newTestWriting.jsp'"><span>글쓰기</span></button>
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