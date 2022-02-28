<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<%@ page import="javax.resource.cci.ResultSet" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%

    //필요한 변수 선언
    int i, j;
    String mylog = "";

    //DB에 사용 할 객체들 정의
    Connection conn = DBUtil.getMySQLConnection();
    PreparedStatement pstmt = null;
    Statement stmt = null;
    String query = "";
    String sql = "";
    java.sql.ResultSet rs = null;

    //DB Select
    query = "SELECT * FROM COMPANY_ABILITIES";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    //뱃지 받아오기
    LinkedList<HashMap<String, String>> badge = new LinkedList<HashMap<String, String>>();
    while(rs.next()){
        HashMap<String, String> badge_hm = new HashMap<String, String>();
        String title = rs.getString("Title")+"";
        String id = rs.getString("Id")+"";

        badge_hm.put("badge_title", title);
        badge_hm.put("badge_id", id);
        badge.add(badge_hm);
    }

    //DB Select
    query = "SELECT Id, Name FROM COMPANY WHERE State = 1";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    //회사 받아오기
    LinkedList<HashMap<String, String>> company = new LinkedList<HashMap<String, String>>();
    while(rs.next()){
        HashMap<String, String> comp_hm = new HashMap<String, String>();
        String id = rs.getString("Id")+"";
        String name = rs.getString("Name")+"";

        comp_hm.put("comp_name", name);
        comp_hm.put("comp_id", id);
        company.add(comp_hm);
    }

    //DB Select
    query = "SELECT * FROM SPECIALIZED";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    //회사뱃지 받아오기
    LinkedList<HashMap<String, String>> comp_badge = new LinkedList<HashMap<String, String>>();
    while(rs.next()){
        HashMap<String, String> cb_hm = new HashMap<String, String>();
        String comp_num = rs.getString("Company_num")+"";
        String abil_num = rs.getString("Ability_num")+"";

        cb_hm.put("comp_num", comp_num);
        cb_hm.put("abil_num", abil_num);
        comp_badge.add(cb_hm);
    }

%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newindex.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/add_badge.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
    <title>소문난집 - 관리자페이지(뱃지부여)</title>
</head>
<body>
<div id="container">
    <jsp:include page="/homepage_pc_header.jsp" flush="false" />
    <jsp:include page="/homepage_mob_header.jsp" flush="false" />
        <div id="content">
            <h2>업체 뱃지 부여</h2>
<%--            <h3>뱃지 확인</h3>--%>
<%--            ---------------------------------------------------------------------------------------------%>
<%--            <div class="badge_chk">--%>
<%--                <%--%>
<%--                    for(int idx =0; idx < badge.size(); idx++){--%>
<%--                        HashMap<String, String> hm = badge.get(idx);--%>
<%--                %>--%>
<%--                <span class = badge><%out.print(hm.get("badge_id"));%>. <%out.print(hm.get("badge_title"));%>&#9;</span>--%>
<%--                <%--%>
<%--                        if((idx+1)%5==0){%><br><br><%}--%>
<%--                    }--%>
<%--                %>--%>
<%--            </div>--%>
<%--            ---------------------------------------------------------------------------------------------%>
            <h3>뱃지 부여</h3>
            <h4>업체 선택</h4>
            <form action = "_add_badge.jsp" method="post">
                <select name="companySelect" id="select_comp" onchange="check_badge(this)">
                    <%
                        for (HashMap<String, String> hm : company) {
                    %>
                    <option value="<%out.print(hm.get("comp_id"));%>"><%out.print(hm.get("comp_name"));%></option>
                    <%
                        }
                    %>
                </select>

                <div class="badge_container">
                    <%
                        for (HashMap<String, String> hm2 : badge) {
                    %>
                    <div class="badge_item">
                        <input type="checkbox" name = "abilitySelect" class="badge_check" value="<%out.print(hm2.get("badge_id"));%>"><%out.print(hm2.get("badge_id"));%>. <%out.print(hm2.get("badge_title"));%> </input>
                    </div>
                    <%
                        }
                    %>
                </div>
                <input type="submit" id="badge_sbm"/>
            </form>
        </div>
</div>
<script>
    var array = new Array();
    function create_hm(){
        <%
        for (HashMap<String, String> hm3 : comp_badge) {
        %>
        var hashmap = new Map();
        hashmap.set("comp_num", "<%=hm3.get("comp_num")%>");
        hashmap.set("abil_num", "<%=hm3.get("abil_num")%>");
        array.push(hashmap);
        <%
        }
        %>
    }

    function check_badge(e) {
        create_hm();
        var checkbox = document.getElementsByClassName("badge_check");
        // document.querySelectorAll(".badge_check").forEach(function(v, i) {v.checked = false;});
        for(var j = 0; j< checkbox.length; j++){
            checkbox[j].removeAttribute("checked");
        }
        for(var i = 0; i < array.length; i++){
            if(array[i].get("comp_num")===e.value){
                var num = Number(array[i].get("abil_num"))-1;
                console.log(num);
                console.log(checkbox[num]);
                checkbox[num].setAttribute("checked", "checked");
            }
        }
    }
    check_badge(document.getElementById("select_comp"));
</script>
</body>
</html>
