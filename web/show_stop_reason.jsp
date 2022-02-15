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
    query = "SELECT reason_id, stop_reason, count(*) AS count FROM apply_stop_reason GROUP BY reason_id";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    //통계 받아오기
    LinkedList<HashMap<String, String>> stop = new LinkedList<HashMap<String, String>>();
    while(rs.next()){
        HashMap<String, String> id_reason = new HashMap<String, String>();
        String reason_id = rs.getString("reason_id")+"";
        String stop_reason = rs.getString("stop_reason")+"";
        String reason_count = rs.getString("count")+"";

        if(reason_id.equals("3")){
            stop_reason = "기타 사유";
        }
        id_reason.put("id", reason_id);
        id_reason.put("reason", stop_reason);
        id_reason.put("count", reason_count);
        stop.add(id_reason);
    }

    //기타 사유 받아오기
    query = "SELECT stop_reason FROM apply_stop_reason WHERE reason_id = 3";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    LinkedList<String> reason = new LinkedList<String>();
    while(rs.next()){
        String stop_reason = rs.getString("stop_reason")+"";
        reason.add(stop_reason);
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
            <h1>고객 상담신청 중단 사유 확인</h1>

            <h3>거절 사유 비율</h3>

            <div class="chart">
                <%
                    for(int idx =0; idx < stop.size(); idx++){
                        HashMap<String, String> hm = stop.get(idx);
                %>
                <div class="chart-bar" id="reason<%out.println(hm.get("id"));%>" data-deg=<%out.println(hm.get("count"));%>></div>
                <%
                    }
                %>
            </div>
            <div class="chart_exp">
                <%
                    for(int idx =0; idx < stop.size(); idx++){
                        HashMap<String, String> hm = stop.get(idx);
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
                        String rsn = reason.get(idx);
                %>
                <div class = "reason"> - <% out.println(rsn);%></div>
                <%
                    }
                %>
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
    var color = ['#9986dd', '#fbb871', '#f599dc']; //색상
    var newDeg = []; //차트 deg
    var totalNum = 0;

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
            newDeg[num]+'deg '+newDeg[num+1]+'deg, #f599dc '+
            newDeg[1]+'deg '+newDeg[2]+'deg)';
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
