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
        // 세션의 company_id 가져오기
        String company_id = session.getAttribute("s_id")+"";

        // get banner id
        String id = request.getParameter("id")+"";

        // 파라미터
        String url = "";
        String file1 = "";
        String filename1 = "";

        // multipartRequest 설정
        int maxSize = 1024*1024*5;
        String encType = "UTF-8";

        // 파일이 저장될 서버의 실제 폴더 경로. ServletContext 이용
        String realFolder = "";

        // webApp 상의 폴더명. 이 폴더에 해당하는 실제 경로 찾아 realFolder 로 매핑시킴
        String saveFile = "otherimg";

        ServletContext sContext = getServletContext();
        realFolder = sContext.getRealPath(saveFile);

        // DB connection
        Connection conn = DBUtil.getMySQLConnection();

        try{
            // upload
            MultipartRequest multi = null;
            multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

            // get inputs
            url = multi.getParameter("url")+"";
            if(url.equals("")) url = "NULL";

            // get file
            Enumeration<?> files = multi.getFileNames();
            file1 = (String)files.nextElement();
            filename1 = multi.getFilesystemName(file1);
        } catch(Exception e) {
            e.printStackTrace();
        }

        // check input validity
        int error = 0;
        if(url.equals("NULL")) {
            %><script>alert("url을 입력해주세요."); window,history.back();</script><%
            error++;
        } else if(filename1 == null) {
            %><script>alert("파일을 선택해주세요."); window,history.back();</script><%
            error++;
        }

        if(filename1 != null) file1 = "https://somoonhouse.com/otherimg" + "/" + filename1;

        if(error == 0) {
            String sql = "";
            PreparedStatement pstmt = null;

            // Status 0: 대기, 1: 승인, 2: 반려
            sql = "Update BANNER set Image=?, Url=? where Id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, file1); // Image
            pstmt.setString(2, url); // Url
            pstmt.setString(3, id); // Id
            pstmt.executeUpdate();

            pstmt.close();%>
    <script>
        alert('수정을 완료했습니다.');
        self.close();
    </script>
    <%
        }
        conn.close();
    %>
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
</body>
</html>