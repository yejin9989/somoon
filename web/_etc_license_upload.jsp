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

        // 파라미터
        String type = "";
        String type_etc = "";
        String date = "";
        String file1 = "";
        String filename1 = "";

        // multipartRequest 설정
        int maxSize = 1024*1024*5;
        String encType = "UTF-8";

        // 파일이 저장될 서버의 실제 폴더 경로. ServletContext 이용
        String realFolder = "";

        // webApp 상의 폴더명. 이 폴더에 해당하는 실제 경로 찾아 realFolder 로 매핑시킴
        String saveFile = "img";

        ServletContext sContext = getServletContext();
        realFolder = sContext.getRealPath(saveFile);

        // DB connection
        Connection conn = DBUtil.getMySQLConnection();

        try{
            // upload
            MultipartRequest multi = null;
            multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

            // get inputs
            type = multi.getParameter("type")+"";
            if(type.equals("")) type = "NULL";
            if(type.equals("0")) {
                type_etc = multi.getParameter("type-etc") + "";
                if (type_etc.equals("")) type_etc = "NULL";
            }
            date = multi.getParameter("date")+"";
            if(date.equals("")) date = "NULL";

            // get file
            Enumeration<?> files = multi.getFileNames();
            file1 = (String)files.nextElement();
            filename1 = multi.getFilesystemName(file1);
        } catch(Exception e) {
            e.printStackTrace();
        }

        // check input validity
        int error = 0;
        if(type.equals("NULL")) {
            %><script>alert("자격증 종류를 선택해주시길 바랍니다"); window,history.back();</script><%
            error++;
        }
        else if(type.equals("0") && type_etc.equals("NULL")) {
            %><script>alert("기타 자격증 종류를 입력해주시길 바랍니다"); window,history.back();</script><%
            error++;
        }
        else if(date.equals("NULL")) {
            %><script>alert("자격증 취득 날짜를 입력해주시길 바랍니다"); window,history.back();</script><%
            error++;
        }
        else if(filename1 == null) {
            %><script>alert("파일을 선택해주세요."); window,history.back();</script><%
            error++;
        }

        if(filename1 != null) file1 = "img" + "/" + filename1;
        out.print("filename : " + file1);

        if(error == 0) {
            String sql = "";
            PreparedStatement pstmt = null;

            if (type.equals("0")) { // 자격증 종류가 기타일 경우
                sql = "SELECT Id FROM CERTIFICATE WHERE Name = \"" + type_etc + "\"";
                pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery(sql);
                String Id = null;
                while (rs.next()) {
                    Id = rs.getString("Id");
                }
                if (Id == null) { // CERTIFICATE table 에 입력값이 없으면
                    // Insert
                    sql = "INSERT INTO CERTIFICATE VALUES(Default, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, type_etc);
                    pstmt.executeUpdate();

                    // Id 가져오기
                    sql = "SELECT Id FROM CERTIFICATE WHERE Name = \"" + type_etc + "\"";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery(sql);
                    while (rs.next()) {
                        Id = rs.getString("Id");
                    }
                }
                type = Id;
                rs.close();
            }

            // Status 0: 대기, 1: 승인, 2: 반려
            sql = "INSERT INTO COMPANY_CERTIFICATE VALUES(?, ?, ?, ?, 0, Default, Default)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, company_id); // companyId
            pstmt.setString(2, type); // 자격증 종류
            pstmt.setString(3, date); // 자격증 취득 날짜
            pstmt.setString(4, file1); // file
            pstmt.executeUpdate();

            pstmt.close();
        %>
            <script>
                alert('등록을 완료했습니다.');
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
    <!-- END Global site tag (gtag.js) - Google Analytics --><!-- Google Tag Manager -->
    <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
            new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
        j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
        'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','GTM-TQFGN2T');</script>
    <!-- End Google Tag Manager -->
    <!-- 사용자 행동 정보 수집 코드 끝 - Meta, GA -->
</head>
<body>
</body>
</html>