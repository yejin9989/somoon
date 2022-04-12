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
    query = "SELECT Id, Name, As_provide, As_warranty FROM COMPANY WHERE State = 1";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    //회사 받아오기
    LinkedList<HashMap<String, String>> company = new LinkedList<HashMap<String, String>>();
    while(rs.next()){
        HashMap<String, String> comp_hm = new HashMap<String, String>();
        String id = rs.getString("Id")+"";
        String name = rs.getString("Name")+"";
        String as = rs.getString("As_provide")+"";
        String as_war = rs.getString("As_warranty")+"";

        comp_hm.put("comp_name", name);
        comp_hm.put("comp_id", id);
        comp_hm.put("comp_as", as);
        comp_hm.put("comp_as_war", as_war);
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
            <form onsubmit="add_badge();">
                <h2>업체 뱃지 부여</h2>
                <h3>업체 선택</h3>
                <select name="companySelect" id="select_comp" onchange="check_badge(this)">
                    <%
                        for (HashMap<String, String> hm : company) {
                    %>
                    <option value="<%out.print(hm.get("comp_id"));%>"><%out.print(hm.get("comp_name"));%></option>
                    <%
                        }
                    %>
                </select>

                <h3>A/S 뱃지 부여</h3>
                A/S 기간을 년 단위로 숫자만 입력해주세요.
                <div class="AS_container">
                    <input type="text" name="ASyear" id="as_year" placeholder="0">년
                </div>

                <h3>기타 뱃지 부여</h3>
                <div class="badge_container">
                    <%
                        for (HashMap<String, String> hm2 : badge) {
                    %>
                    <div class="badge_item">
                        <input type="checkbox" name = "abilitySelect" class="badge_check" value="<%out.print(hm2.get("badge_id"));%>" onchange="checking()">
                        <%out.print(hm2.get("badge_id"));%>. <%out.print(hm2.get("badge_title"));%> </input>
                    </div>
                    <%
                        }
                    %>
                </div>
                <input type="submit" id="badge_sbm" value="등록">

            </form>
        </div>
</div>
<script>
    var array_cb = new Array();
    var array_cp = new Array();
    function create_hm_cb(){
        <%
        for (HashMap<String, String> hm3 : comp_badge) {
        %>
        var hashmap = new Map();
        hashmap.set("comp_num", "<%=hm3.get("comp_num")%>");
        hashmap.set("abil_num", "<%=hm3.get("abil_num")%>");
        array_cb.push(hashmap);
        <%
        }
        %>
    }
    function create_hm_cp(){
        <%
        for (HashMap<String, String> hm : company) {
        %>
        var hashmap = new Map();
        hashmap.set("comp_id","<%=hm.get("comp_id")%>");
        hashmap.set("comp_as","<%=hm.get("comp_as")%>");
        hashmap.set("comp_as_war","<%=hm.get("comp_as_war")%>");
        array_cp.push(hashmap);
        <%
        }
        %>
    }

    const add_badge = async () => {
        await fetch("https://somunbackend.com/auth-non/badge/"+company_num+"&"+ability_num, {
            method: "POST",
            headers: {
            }
        })
            .catch((err) => {
                console.log(err);
            })
    }

    const del_badge = async () => {
        await fetch("https://somunbackend.com/auth-non/badge/"+company_num, {
            method: "DELETE",
            headers: {
            }
        })
            .catch((err) => {
                console.log(err);
            })
    }

    function badge(){
        del_badge();
        add_badge();
    }
    function check_badge(e) {
        create_hm_cb();
        create_hm_cp();
        var checkbox = document.getElementsByClassName("badge_check");
        var textbox = document.getElementById("as_year");

        textbox.value = "";
        for(var j = 0; j< checkbox.length; j++){
            checkbox[j].checked = false;
        }

        for(var k = 0; k < array_cp.length; k++){
            if(array_cp[k].get("comp_id")===e.value){
                if(array_cp[k].get("comp_as")==='1'){
                    textbox.value = array_cp[k].get("comp_as_war");
                }
            }
        }
        for(var i = 0; i < array_cb.length; i++){
            if(array_cb[i].get("comp_num")===e.value){
                var num = Number(array_cb[i].get("abil_num"))-1;
                checkbox[num].checked = true;
            }
        }
    }

    check_badge(document.getElementById("select_comp"));
</script>
</body>
</html>
