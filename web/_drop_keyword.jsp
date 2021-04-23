<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar,java.util.*" %>
<%@ page language="java" import="myPackage.DBUtil" %>
<%@ page language="java" import="myPackage.Link" %>
<%@ page language="java" import="myPackage.GetImage" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <%
        /*로그인된 세션 아이디(추후개발) 가져오기, 현재 페이지 저장
        String id = session.getAttribute("s_id")+"";
        String now = "_attach_keyword.jsp";*/

        //DB에 사용 할 객체들 정의
        Connection conn = DBUtil.getMySQLConnection();
        PreparedStatement pstmt = null;
        Statement stmt = null;
        String query = "";
        String sql = "";
        ResultSet rs = null;

        //처리에 에러정보가 있으면 롤백
        int error = 0;

        //신청폼으로 부터 받은 데이터 불러오기, 필요한 정보 정의
        String keyword = request.getParameter("keyword");

        sql = "delete from KEYWORD_ASSIGNED where Keyword_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, keyword);

        sql = "delete from KEYWORD where Id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, keyword);

        if(error == 0){
            pstmt.executeUpdate();
        }
        else{
        }
        //확인
        //out.println(pstmt);


        //DB객체 종료
        //stmt.close();
        pstmt.close();
        conn.close();
    %>
</head>
<body>
<script>
    alert('삭제를 완료했습니다.');
    history.back();
</script>
</body>
</html>