<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
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
    ResultSet rs = null;

    //DB Select
    query = "SELECT company_num, refuse_id, refuse_reason, count(*) AS count FROM ASSIGNED GROUP BY refuse_id HAVING refuse_id IS NOT NULL";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    //통계 받아오기
    LinkedList<HashMap<String, String>> refuse = new LinkedList<HashMap<String, String>>();
    while(rs.next()){
        HashMap<String, String> id_reason = new HashMap<String, String>();
        String refuse_id = rs.getString("refuse_id")+"";
        String refuse_reason = rs.getString("refuse_reason")+"";
        String reason_count = rs.getString("count")+"";

        if(refuse_id.equals("4")){
            refuse_reason = "기타 사유";
        }
        id_reason.put("id", refuse_id);
        id_reason.put("reason", refuse_reason);
        id_reason.put("count", reason_count);
        refuse.add(id_reason);
    }

    //기타 사유 받아오기
    query = "SELECT A.refuse_reason, C.name FROM ASSIGNED AS A LEFT JOIN COMPANY AS C ON A.company_num = C.id WHERE refuse_id = 4";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    LinkedList<HashMap<String,String>> reason = new LinkedList<HashMap<String,String>>();
    while(rs.next()){
        HashMap<String,String> refuse_hm = new HashMap<String,String>();
        String refuse_reason = rs.getString("refuse_reason")+"";
        String refuse_company = rs.getString("name")+"";

        refuse_hm.put("reason", refuse_reason);
        refuse_hm.put("company", refuse_company);
        reason.add(refuse_hm);
    }

    //사유별 업체 횟수 종합하기
    query = "SELECT C.name, A.refuse_id, A.refuse_reason, count(*) AS count FROM ASSIGNED AS A LEFT JOIN COMPANY AS C ON A.company_num = C.id WHERE refuse_id IS NOT NULL GROUP BY refuse_id, company_num";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    LinkedList<HashMap<String,String>> company = new LinkedList<HashMap<String,String>>();
    while(rs.next()){
        HashMap<String,String> company_hm = new HashMap<String,String>();
        String company_name = rs.getString("name")+"";
        String refuse_id = rs.getString("refuse_id")+"";
        String refuse_reason = rs.getString("refuse_reason")+"";
        String refuse_count = rs.getString("count")+"";

        company_hm.put("name", company_name);
        company_hm.put("id", refuse_id);
        company_hm.put("reason", refuse_reason);
        company_hm.put("count", refuse_count);
        company.add(company_hm);
    }

%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newindex.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/show_reason.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
    <title>소문난집</title>
</head>
<body>
<div id="container">
    <jsp:include page="/homepage_pc_header.jsp" flush="false" />
    <jsp:include page="/homepage_mob_header.jsp" flush="false" />
    <div id="content">
        <div class="reason_container">
            <h1>업체 신규건 거절 사유 확인</h1>

            <h3>거절 사유 비율</h3>

            <div class="chart">
            <%
                for(int idx =0; idx < refuse.size(); idx++){
                    HashMap<String, String> hm = refuse.get(idx);
            %>
                <div class="chart-bar" id="reason<%out.println(hm.get("id"));%>" data-deg=<%out.println(hm.get("count"));%>></div>
            <%
                }
            %>
            </div>
            <div class="chart_exp">
                <%
                    for(int idx =0; idx < refuse.size(); idx++){
                        HashMap<String, String> hm = refuse.get(idx);
                %>
                <div class = chart_color id="color<%out.println(hm.get("id"));%>"></div>
                <div class = chart_reason><%out.println(hm.get("reason"));%> : <%out.println(hm.get("count"));%>건</div>
                <div></div>
                <%
                    }
                %>
            </div>

            <h3>기타 사유 확인</h3>
            <a href="javascript:reason_show();">펼쳐보기</a>
            <div id = "etc_reason_container" style="display: none">
                <%
                    for(int idx = 0; idx < reason.size(); idx++){
                        HashMap<String,String> rsn = reason.get(idx);
                %>
                <div class = "reason"> - <% out.println(rsn.get("company"));%> : <% out.println(rsn.get("reason"));%></div>
                <%
                    }
                %>
            </div>

            <h3>사례별 기업 확인</h3>
            <div>
                <a href="javascript:company_show(1);">고객 예산 부족</a><br><br>
                <a href="javascript:company_show(2);">공사 일정 마감</a><br><br>
                <a href="javascript:company_show(3);">해당 지역 불가</a><br><br>
                <a href="javascript:company_show(4);">기타 사유</a><br><br>
                <div class="comp_rsn" id="company_reason1" style="display: none;">
                    <h4>고객 예산 부족</h4>
                    <%
                        for(int idx = 0; idx < company.size(); idx++){
                            HashMap<String,String> cpny = company.get(idx);
                            if(cpny.get("id").equals("1")){
                    %>
                    <div class = "reason"> - <% out.println(cpny.get("name"));%> : <% out.println(cpny.get("count"));%>회</div>
                    <%
                            }
                        }
                    %>
                </div>
                <div class="comp_rsn" id="company_reason2" style="display: none;">
                    <h4>공사 일정 마감</h4>
                    <%
                        for(int idx = 0; idx < company.size(); idx++){
                            HashMap<String,String> cpny = company.get(idx);
                            if(cpny.get("id").equals("2")){
                    %>
                    <div class = "reason"> - <% out.println(cpny.get("name"));%> : <% out.println(cpny.get("count"));%>회</div>
                    <%
                            }
                        }
                    %>
                </div>
                <div class="comp_rsn" id="company_reason3" style="display: none;">
                    <h4>해당 지역 불가</h4>
                    <%
                        for(int idx = 0; idx < company.size(); idx++){
                            HashMap<String,String> cpny = company.get(idx);
                            if(cpny.get("id").equals("3")){
                    %>
                    <div class = "reason"> - <% out.println(cpny.get("name"));%> : <% out.println(cpny.get("count"));%>회</div>
                    <%
                            }
                        }
                    %>
                </div>
                <div class="comp_rsn" id="company_reason4" style="display: none;">
                    <h4>기타 사유</h4>
                    <%
                        for(int idx = 0; idx < company.size(); idx++){
                            HashMap<String,String> cpny = company.get(idx);
                            if(cpny.get("id").equals("4")){
                    %>
                    <div class = "reason"> - <% out.println(cpny.get("name"));%> : <% out.println(cpny.get("count"));%>회</div>
                    <%
                            }
                        }
                    %>
                </div>
                <div class="comp_rsn" id="company_reason5"></div>
            </div>


        </div>
    </div>
</div>
<%
    if (pstmt != null) {
        pstmt.close();

    }
%>

</body>
<script>
    var _chart = document.querySelector('.chart');
    var _chartBar = document.querySelectorAll('.chart-bar');
    var _chartColor = document.querySelectorAll('.chart_color');
    var color = ['#9986dd', '#fbb871', '#bd72ac', '#f599dc']; //색상
    var newDeg = []; //차트 deg
    var totalNum = 0;

    function company_show(i){
        var _class = document.getElementsByClassName("comp_rsn");
        var _cmp = document.getElementById('company_reason'+i);

        for(var i=0; i<_class.length; i++){
            _class[i].style.display = 'none';
        }

        if(_cmp.style.display === 'none'){
            _cmp.style.display = 'block';
        }
        else{
            _cmp.style.display = 'none';
        }
    }

    function index_color(){
        for (var i = 0; i < _chartColor.length; i++) {
            _chartColor[i].style.backgroundColor = color[i];
        }
    }

    function total_sum(){
        for( var i=0;i<_chartBar.length;i++){
            var _tot = _chartBar[i].dataset.deg
            _tot = parseInt(_tot);
            totalNum += _tot;
        }
    }

    function chartDraw(){
        var totdeg =0;
        for( var i=0;i<_chartBar.length;i++){
            var _num = _chartBar[i].dataset.deg
            var _deg = _num / totalNum * 360
            totdeg += _deg
            newDeg.push( totdeg )
        }

        var num = newDeg.length - newDeg.length;
        _chart.style.background = 'conic-gradient(#9986dd '+
            newDeg[num]+'deg, #fbb871 '+
            newDeg[num]+'deg '+newDeg[num+1]+'deg, #bd72ac '+
            newDeg[1]+'deg '+newDeg[2]+'deg, #f599dc '+
            newDeg[2]+'deg )';
    }

    function reason_show(){
        var _etc = document.getElementById('etc_reason_container');

        if(_etc.style.display === 'none'){
            _etc.style.display = 'block';
        }
        else{
            _etc.style.display = 'none';
        }
    }

    total_sum();
    chartDraw();
    index_color();

</script>
</html>
