<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar,java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
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
        String now = "_remodeling_form.jsp";*/

        //DB에 사용 할 객체들 정의
        Connection conn = DBUtil.getMySQLConnection();
        PreparedStatement pstmt = null;
        Statement stmt = null;
        String query = "";
        String sql = "";
        ResultSet rs = null;

        //처리에 에러정보가 있으면 롤백
        int error = 0;

        //배분중 상태인 신청들 중에서 3시간이 지난 신청 확인하기
        query = "select * from REMODELING_APPLY where State = 2 And Not Assigned_time BETWEEN DATE_ADD(NOW(), INTERVAL -3 HOUR ) AND NOW()";
        pstmt = conn.prepareStatement(query);
        rs = pstmt.executeQuery();

        LinkedList<String> not_valid_items = new LinkedList<String>();
        while(rs.next()){
            not_valid_items.add(rs.getString("Number"));
        }

        //3시간 지난 신청들의 배분 정보에서 상태(대기)가 일 시에 상태(거절)로 변경
        for (String number : not_valid_items){
            sql = "update ASSIGNED set State = 1 where State = 0 and Apply_num = " + number;
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        }

        //거절되지 않은 건(수락건)이 4개이상일 시, 신청을 전체 수락 상태로 바꾸어주기
        for(String number : not_valid_items){
            query = "select count(*) from ASSIGNED where State != 1 and Apply_num = " + number;
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();
            while(rs.next()){
                int okay = rs.getInt("count(*)");
                if(okay >= 4){
                    sql = "update REMODELING_APPLY set State = 3 where Number = " + number;
                    pstmt = conn.prepareStatement(sql);
                    pstmt.executeUpdate();
                }
                else{
                    sql = "update REMODELING_APPLY set State = 1 where Number = " + number;
                    pstmt = conn.prepareStatement(sql);
                    pstmt.executeUpdate();

                    //만약 모든 회사에 배분 되었고 수락한 회사가 4개이하라면 배분 테이블에 해당 신청건에 대해 거절한 열들을 다 지움
                    ResultSet rs2;

                    query = "select count(*) from ASSIGNED Where Apply_num = " + number;
                    pstmt = conn.prepareStatement(query);
                    rs2 = pstmt.executeQuery();
                    int assigned = 0;
                    while(rs2.next()){
                        assigned = rs2.getInt("count(*)");
                    }
                    query = "select count(*) from COMPANY where State = 1";
                    pstmt = conn.prepareStatement(query);
                    rs2 = pstmt.executeQuery();
                    int company = 0;
                    while(rs2.next()){
                        company = rs2.getInt("count(*)");
                    }

                    if(assigned >= company){ //원본
                    //if(assigned >= 4){ // 테스트
                        //거절인 행 다 지우기
                        sql = "delete from ASSIGNED where State = 1 and Number " + number;
                        pstmt = conn.prepareStatement(sql);
                        pstmt.executeUpdate();
                    }
                }
           }
        }

        //확인
        //out.println(pstmt);

        //DB객체 종료
        //stmt.close();
        pstmt.close();
        conn.close();

        String state = request.getParameter("state")+"";
        out.print("manage_request.jsp?state="+state);
        response.sendRedirect("manage_request.jsp?state="+state);

    %>
</head>
<body>
</body>
</html>