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

        if(filename1 != null) {
            out.println("uploaded file name: " + filename1);
            file1 = "otherimg" + "/" + filename1;

        out.print("filename : " + file1);
    }
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
            out.print("sql : " + pstmt.toString());

            pstmt.close();%>
    <script>
        // alert('수정을 완료했습니다.');
        // self.close();
    </script>
    <%
        }
        conn.close();
    %>

</head>
<body>
</body>
</html>