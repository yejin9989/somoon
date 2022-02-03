<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    //필요한 변수 선언
    int i, j;
    String mylog = "";

    //파라미터 가져오기
    //String param = request.getParameter("param");

    // 파라미터
    String assigned_id = "";
    String state = "";
    String contract_date = "";
    String contract_img_path = "";
    String contract_price = "";

    // 파일관련 변수
    String file1 = "";

    // multipartRequest 설정
    int maxSize = 1024*1024*5;
    String encType = "UTF-8";

    // 파일이 저장될 서버의 실제 폴더 경로. ServletContext 이용
    String realFolder = "";

    // webApp 상의 폴더명. 이 폴더에 해당하는 실제 경로 찾아 realFolder 로 매핑시킴
    String saveFile = "otherimg/contract";

    ServletContext sContext = getServletContext();
    realFolder = sContext.getRealPath(saveFile);

    //DB 관련 객체 선언
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
    String sql = "";

    try{
        // upload
        MultipartRequest multi = null;
        multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

        // get, set inputs
        assigned_id = multi.getParameter("assigned_id")+"";
        state = ""; //완료 상태 번호넣어주기
        contract_date = multi.getParameter("contract_date")+"";
        contract_price = multi.getParameter("contract_price")+"";

        // get file
        Enumeration<?> files = multi.getFileNames();
        file1 = (String)files.nextElement();
        contract_img_path = multi.getFilesystemName(file1);

    } catch(Exception e) {
        e.printStackTrace();
    }

    // check input validity
    int error = 0;
    if(contract_date.equals("NULL")) {
        %><script>alert("계약 일시를 입력해주시길 바랍니다."); window,history.back();</script><%
        error++;
    }
    else if(contract_price.equals("0")) {
        %><script>alert("계약 금액을 입력해주시길 바랍니다."); window,history.back();</script><%
        error++;
    }

    if(contract_img_path != null) {
        file1 = "https://somoonhouse.com/otherimg/contract/" + contract_img_path;
        //out.print("filename : " + file1);
    }
    else{
        %><script>alert("계약서를 업로드 해주시길 바랍니다."); window,history.back();</script><%
        error++;
    }

    if(error == 0){
        //DB에 계약일시, 파일명, 계약금액 넣고 상태 업데이트
        query = "UPDATE ASSIGNED " +
                "SET Contract_date = now(), contract_img_path = ?, contract_price = ?, state = 8 " +
                "WHERE Assigned_id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, file1);
        pstmt.setString(2, contract_price);
        pstmt.setString(3, assigned_id);
        //out.print(pstmt);
        pstmt.executeUpdate();
        pstmt.close();

        //out.print("contract_date : " + contract_date + " contract_price: " + contract_price);
        %>
        <script>
        alert('등록을 완료했습니다.');
        location.href = "newTest1.jsp";
        </script>
        <%
    }
    else{
        %>
        <script>
        alert('등록을 실패했습니다.');
        history.back();
        </script>
        <%
    }
    conn.close();
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
    <!-- 사용자 행동 정보 수집 코드 시작 - Meta, GA -->
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
    <!-- 사용자 행동 정보 수집 코드 끝 - Meta, GA -->
</head>
<body>
<%=mylog%>
<%
    if(pstmt != null) {
        pstmt.close();
    }
    if(rs != null){
        rs.close();
    }
    if(conn != null){
        conn.close();
    }
    query = "";
%>



<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    //새 스크립트 작성
    //window.close();
</script>
</body>
</html>