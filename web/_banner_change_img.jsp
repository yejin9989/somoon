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
        // get banner id
        String id = request.getParameter("id")+"";

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

        // update image
        PreparedStatement pstmt = null;
        String sql = "Update BANNER_IMG set Path = ? where Id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, file1);
        pstmt.setString(2, id);
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
</head>
<body>
</body>
</html>