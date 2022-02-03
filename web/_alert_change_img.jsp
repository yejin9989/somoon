<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar,java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page language="java" import="myPackage.DBUtil" %>
<%@ page language="java" import="myPackage.Link" %>
<%@ page language="java" import="myPackage.GetImage" %>
<%@ page import="java.io.File" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <%
        String file1 = "";
        String realFolder = "";
        String filename1 = "";
        int maxSize = 1024*1024*5;
        String encType = "UTF-8";
        String savefile = "otherimg"; //ohterimg/alert 폴더에는 저장을 못하더라... 이유가 뭘까용
        ServletContext scontext = getServletContext();
        realFolder = scontext.getRealPath(savefile);

        Connection conn = DBUtil.getMySQLConnection();
        try{
            MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
            Enumeration<?> files = multi.getFileNames();
            file1 = (String)files.nextElement();
            filename1 = multi.getFilesystemName(file1);
        } catch(Exception e) {
            e.printStackTrace();
        }

        out.println("filename : " + filename1 + "\n");
        if(filename1 != null)
            file1 = "https://somoonhouse.com/otherimg" + "/" + filename1;
        out.println("filename : " + file1 + "\n");

        //이전 파일명 가져오기
        PreparedStatement pstmt = null;
        String sql = "SELECT * FROM ALERT WHERE Id = 1";
        ArrayList<String> previmgs = new ArrayList<String>();
        pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while(rs.next()){
            previmgs.add(rs.getString("Path"));
        }

        //이미지들 다 삭제
        for(String path : previmgs){
            path = path.replace("%25", "%");
            path = path.replace("https://somoonhouse.com/", "");
            File file = new File("/somunhouse/tomcat/webapps/ROOT/"+path);
            out.println("파일처리시작");
            if(file.exists()) {
                if(file.delete()){
                    out.println(path + "파일삭제 성공");
                }
            }
            else {
                out.println(path + "파일이 존재하지 않습니다.");
            }
        }

        //db에서 파일명 삭제
        sql = "DELETE FROM ALERT WHERE Id = 1";
        pstmt = conn.prepareStatement(sql);
        pstmt.executeUpdate();

        //db에 파일명 추가
        sql = "INSERT INTO ALERT VALUES(1, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, file1);
        pstmt.executeUpdate();
        pstmt.close();
    %>
    <script>
        alert('등록을 완료했습니다.');
        window,close();
    </script>
    <%
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