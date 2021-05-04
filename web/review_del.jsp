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
<%String s_id = session.getAttribute("s_id")+""; %>
<!DOCTYPE html>
<html>
<head><meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="css/etc_license_upload.css">
    <title>리뷰 이미지 삭제</title>
</head>
<body>
<div class="upload-popup-header">
    <h3>리뷰 이미지 삭제</h3>
    <div class="upload-popup-header-desc">
        <span>삭제할 이미지를 선택해주세요.</span>
        <%--        <span class="text-red">이미지(JPEG, PNG) 외의 파일 선택 시 반려될 수 있습니다.</span>--%>
    </div>
</div>
<form action="_review_del.jsp" method="post" style="margin-top:10px">
    <%
        // 리뷰 받아오기
        Connection conn = DBUtil.getMySQLConnection();
        String query = "select * from REVIEW order by Id ASC";
        PreparedStatement pstmt = conn.prepareStatement(query);
        ResultSet rs = pstmt.executeQuery();
        String reviews_id[] = new String[100];
        String review_url = "";
        int review_cnt = 0;
        while(rs.next()) {
            reviews_id[review_cnt] = rs.getString("Id");
            review_url = rs.getString("Image");
    %>
    <div class="review_box">
        <input class="id" id="id" name="id" type="radio" value="<%=reviews_id[review_cnt]%>" />
<%--        <span><%=reviews_id[review_cnt]%></span>--%>
        <img src="<%=review_url%>" class="review_img" style="height:300px;width:300px;" />
    </div>
    <%
            review_cnt++;
        }
    %>
    <input type="submit" class="submitBtn" value="삭제하기">
</form>
</body>
</html>