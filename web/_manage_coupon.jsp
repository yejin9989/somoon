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
  <title>소문난집</title><!-- 사용자 행동 정보 수집 코드 시작 - Meta, GA -->
  <!-- 모든 페이지에 하나씩만 포함되어 있어야 합니다. 위치는 </head> 바로 위로 통일 -->
  <!-- Meta Pixel Code -->
  <script>
    !function(f,b,e,v,n,t,s)
    {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
            n.callMethod.apply(n,arguments):n.queue.push(arguments)};
      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
      n.queue=[];t=b.createElement(e);t.async=!0;
      t.src=v;s=b.getElementsByTagName(e)[0];
      s.parentNode.insertBefore(t,s)}(window, document,'script',
            'https://connect.facebook.net/en_US/fbevents.js');
    fbq('init', '483692416470707');
    fbq('track', 'PageView');
  </script>
  <noscript><img height="1" width="1" style="display:none"
                 src="https://www.facebook.com/tr?id=483692416470707&ev=PageView&noscript=1"
  /></noscript>
  <!-- End Meta Pixel Code -->
  <!-- Global site tag (gtag.js) - Google Analytics -->
  <script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'G-PC15JG6KGN');
  </script>
  <!-- END Global site tag (gtag.js) - Google Analytics -->
  <!-- Google Tag Manager -->
  <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
            new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
          j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
          'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
  })(window,document,'script','dataLayer','GTM-TQFGN2T');</script>
  <!-- End Google Tag Manager -->
  <!-- 사용자 행동 정보 수집 코드 끝 - Meta, GA -->
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
<script>
  //새 스크립트 작성
  $(document).ready(function(){
    alert("상품이 정상적으로 지급되었습니다.");
    location.href = "manage_coupon.jsp";
  });
</script>
</body>
</html>