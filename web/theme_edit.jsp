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
<%
    int i;
    String mylog = "";
%>
<%
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
%>
<%
    //테마 두가지 받아오기, 테마번호, 테마이름
    LinkedList<HashMap<String, String>> theme = new LinkedList<HashMap<String, String>>();
    query = "select * from THEME order by Id ASC";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    i = 0;
    while(rs.next()){
        HashMap<String, String> mymap = new HashMap<String, String>();
        mymap.put("Id", rs.getString("Id"));
        mymap.put("Name", rs.getString("Name"));
        if(rs.getString("Display").equals("1")){
            mymap.put("Display", "checked");
        }
        else
            mymap.put("Display", "");
        theme.add(mymap);
        mylog += "테마" + i + mymap + "\n";
        i++;
    }
    pstmt.close();

    //테마별 사례/대표사례 개수 가져오기
    HashMap<String, HashMap<String, String>> theme_count = new HashMap<String, HashMap<String, String>>();
    for(i=0;i<theme.size();i++){
        HashMap<String, String> mymap = new HashMap<String, String>();
        //대표사례개수
        query = "select count(*) from THEME T, THEME_ASSIGNED A where T.Id = ? and A.Theme_id = T.Id and A.Display=1 group by T.Id";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, theme.get(i).get("Id"));
        rs = pstmt.executeQuery();
        while(rs.next()){
            mymap.put("Display_item", rs.getString("count(*)"));
        }
        //일반사례개수
        query = "select count(*) from THEME T, THEME_ASSIGNED A where T.Id = ? and A.Theme_id = T.Id group by T.Id";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, theme.get(i).get("Id"));
        rs = pstmt.executeQuery();
        while(rs.next()){
            mymap.put("General_item", rs.getString("count(*)"));
        }
        theme_count.put(theme.get(i).get("Id"), mymap);
    }
%>
        <!DOCTYPE html>
<html>
<head><meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/theme_edit.css"/>
</head>
<body>
최소 두개는 설정해야 함.<br>
한 테마당 최소 네개의 대표사례가 있어야함.<br>
위 조건을 만족 못할 시 설정 불가.<br>
개수를 클릭하면 대표사례/사례를 관리할 수 있음<br>
테마 삭제시 해당 테마에 등록되있는 사례정보도 삭제(사례자체가 삭제되는건 아님)<br>
<div>
    <table>
        <thead>
            <tr>
                <td>대표테마설정</td><td>테마이름</td><td>대표사례개수</td><td>사례개수</td><td>삭제</td>
            </tr>
        </thead>
        <tbody>
                <%
                for(i=0; i<theme.size(); i++){
                    %><tr>
                    <td><input type="checkbox" value="<%=theme.get(i).get("Id")%>" <%=theme.get(i).get("Display")%>></td>
                    <td><%=theme.get(i).get("Name")%></td>
                    <td class="display-items" id="display<%=theme.get(i).get("Id")%>"><%=theme_count.get(theme.get(i).get("Id")).get("Display_item")%></td>
                    <td class="general-items" id="general<%=theme.get(i).get("Id")%>"><%=theme_count.get(theme.get(i).get("Id")).get("General_item")%></td>
                    <td class="delete-theme" id="theme<%=theme.get(i).get("Id")%>">X</td>
                    </tr><%
                }
                %>
        </tbody>
    </table>
</div>
<form action="_theme_upload.jsp" method="post">
    테마제목:<input type="text" name="theme_name">
    <input type="submit" class="submitBtn" value="테마추가">
</form>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    $('.delete-theme').click(function(){
        var theme_id = $(this).attr('id');
        theme_id = theme_id.replaceAll('theme', '');
        location.href = '_theme_drop.jsp?'+'theme_id='+theme_id;
    })
    $('.general-items').click(function(){
        var theme_id = $(this).attr('id');
        theme_id = theme_id.replaceAll('general', '');
        location.href = 'theme_general_item_upload.jsp?'+'theme_id='+theme_id;
    })
    $('.display-items').click(function(){
        var theme_id = $(this).attr('id');
        theme_id = theme_id.replaceAll('display', '');
        location.href = 'theme_display_item_upload.jsp?'+'theme_id='+theme_id;
    })
</script>
</body>
</html>