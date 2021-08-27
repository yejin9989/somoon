<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<%@ page import="javax.persistence.criteria.CriteriaBuilder" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
  //필요한 변수 선언
  int i, j;
  String mylog = "";

  //파라미터 가져오기
  String company_id = request.getParameter("company_id");
  String coupon_id = request.getParameter("coupon_id");
  String stock = "";

  //DB 관련 객체 선언
  Connection conn = DBUtil.getMySQLConnection();
  ResultSet rs = null;
  PreparedStatement pstmt = null;
  String query = "";
  String sql = "";

  //쿠폰발급하기
  query = "select * from COUPON where Id = ?";
  pstmt = conn.prepareStatement(query);
  pstmt.setString(1, coupon_id);
  rs = pstmt.executeQuery();
  while(rs.next()){
    stock = rs.getString("Quantity");
  }

  sql = "insert into ISSUED_COUPON values(?, ?, ?, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), default)";
  pstmt = conn.prepareStatement(sql);
  pstmt.setInt(1, Integer.parseInt(company_id));
  pstmt.setInt(2, Integer.parseInt(coupon_id));
  pstmt.setString(3, stock);
  pstmt.executeUpdate();

  pstmt.close();
  rs.close();
%>
<!DOCTYPE html>
<html>
<head>
  <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico" />
  <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newindex.css"/>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
  <title>소문난집</title>
</head>
<body>
<%=mylog%>
<%
  if(pstmt != null) {
    pstmt.close();
    rs.close();
    query = "";
    conn.close();
  }
%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
<script>
  //새 스크립트 작성
  $(document).ready(function(){
    alert("상품이 정상적으로 지급되었습니다.");
    location.href = "manage_coupon.jsp";
  });
</script>
</body>
</html>