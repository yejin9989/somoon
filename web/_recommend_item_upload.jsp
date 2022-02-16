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
        String id = session.getAttribute("s_id")+"";
        String file1[] = new String[10];
        String url = "";
        String title = "";
        request.setCharacterEncoding("UTF-8");
        String realFolder = "";
        String filename1 = "";
        int maxSize = 1024*1024*5;
        String encType = "UTF-8";
        String saveFile = "img";
        ServletContext sContext = getServletContext();
        realFolder = sContext.getRealPath(saveFile);

        Connection conn = DBUtil.getMySQLConnection();
        try{
            MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
            url = multi.getParameter("url")+"";
            if(url.equals("")) url = "NULL";
            title = multi.getParameter("title")+"";
            if(title.equals("")) title = "NULL";
            Enumeration<?> files = multi.getFileNames();
            file1[0] = (String)files.nextElement();
            filename1 = multi.getFilesystemName(file1[0]);
        } catch(Exception e) {
            e.printStackTrace();
        }
        int error=0;
        if(title.equals("NULL") || filename1 == null || url.equals("NULL") || url.equals("")){
            %><script>alert("제목,사진과 url중 하나를 입력해주시길 바랍니다"); window,history.back();</script><%
            error++;
        }
        else if(title.equals("NULL") || filename1 == null){
            Link MyLink = new Link(url);
            out.println("url: "+url);
            if(title.equals("NULL")){
                title = MyLink.getTitle();
                out.println("제목이없어요");
            }
            if(filename1 == null){
                file1 = MyLink.getImg();
                out.println("파일이없어요\n");
            }
        }

        if(filename1 != null)
            file1[0] = "img" + "/" + filename1;
    //    out.println("filename : " + file1[0] + "\n");
    if(error == 0) {
        String sql = "INSERT INTO RECOMMEND VALUES(Default, ?, Default, Default, Default, ?, ?)";
        PreparedStatement pstmt = null;
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, url);
        pstmt.setString(3, file1[0]);
        pstmt.executeUpdate();
        pstmt.close();
%>
    <script>
        alert('등록을 완료했습니다.');
        window,close();
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
</body>
</html>