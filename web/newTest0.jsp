<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    //필요한 변수 선언
    String mylog = "";

    //파라미터 가져오기
    //String param = request.getParameter("param");
    String s_id = session.getAttribute("s_id")+"";
    //String s_id = "35";

    //DB 관련 객체 선언
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
    String sql = "";

    //변수설정
    String[] buildingType = {"아파트", "빌라", "주택", "원룸"};
    class Dates{
        String date;
        HashMap<String, HashMap<String, String>> applies;
        HashMap<String, HashMap<String, String>> details;

        void setDate(String date){
            this.date = date;
        }
        void setApplies(HashMap applies){
            this.applies = applies;
        }
        void setDetails(HashMap details){
            this.details = details;
        }

        String getDate(){
            return this.date;
        }
        HashMap getApplies(){
            return this.applies;
        }
        HashMap getDetails(){
            return this.details;
        }
    }

    //DB 가져오기
    query = "SELECT distinct Apply_date FROM ASSIGNED A, REMODELING_APPLY R";
    query += " WHERE A.Company_num = " + s_id;
    query += " And R.Number = A.Apply_num";
    query += " And A.State = 0"; // 탭에따라 이 쿼리 바꾸어주기
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    LinkedList<Dates> datelist = new LinkedList<Dates>();

    while(rs.next()) {

        Dates date = new Dates();
        date.setDate(rs.getString("Apply_date"));

        HashMap<String, HashMap<String, String>> applies = new HashMap<String, HashMap<String, String>>();
        HashMap<String, HashMap<String, String>> details = new HashMap<String, HashMap<String, String>>();


        query = "SELECT * FROM ASSIGNED A, REMODELING_APPLY R";
        query += " WHERE A.Company_num = " + s_id;
        query += " And R.Number = A.Apply_num";
        query += " And A.State = 0";
        query += " And Date(Apply_date) = '" + rs.getString("Apply_date") + "'";
        pstmt = conn.prepareStatement(query);
        ResultSet rs2 = pstmt.executeQuery();

        while (rs2.next()) {
            HashMap<String, String> temp = new HashMap<String, String>();
            if(rs2.getString("Item_num").equals("0")){
                temp.put("Title", "통합 신청 버튼으로 신청했습니다.");
                temp.put("URL", "#");
            }
            else{
                query = "select * from REMODELING where Number = " + rs2.getString("Item_num");
                pstmt = conn.prepareStatement(query);
                ResultSet rs3 = pstmt.executeQuery();
                while(rs3.next()){
                    temp.put("Title", rs3.getString("Title"));
                    temp.put("URL", rs3.getString("URL"));
                }
            }
            temp.put("Number", rs2.getString("R.Number"));
            temp.put("Item_num", rs2.getString("R.Item_num"));
            temp.put("Name", rs2.getString("R.Name"));
            temp.put("Phone", rs2.getString("R.Phone"));
            temp.put("Address", rs2.getString("R.Address"));
            if(rs2.getString("R.Building_type")!=null && !rs2.getString("R.Building_type").equals("null"))
                temp.put("Building_type", buildingType[Integer.parseInt(rs2.getString("R.Building_type"))]);
            else
                temp.put("Building_type", "정보없음");
            temp.put("Area", rs2.getString("R.Area"));
            temp.put("Due", rs2.getString("R.Due"));
            temp.put("Budget", rs2.getString("R.Budget"));
            temp.put("Consulting", rs2.getString("R.Consulting"));
            temp.put("Apply_date", rs2.getString("R.Apply_date"));
            temp.put("State", rs2.getString("R.State"));
            temp.put("Calling", rs2.getString("R.Calling"));
            temp.put("Pw", rs2.getString("R.Pw"));
            temp.put("Assigned_time", rs2.getString("R.Assigned_time"));
            temp.put("State", rs2.getString("A.State"));
            temp.put("Assigned_id", rs2.getString("A.Assigned_id"));
            temp.put("Memo", rs2.getString("A.Memo"));
            temp.put("Modify_date", rs2.getString("A.Modify_date"));
            applies.put(temp.get("Number"), temp);

            //details 값 넣기
            PreparedStatement pstmt2 = null;
            query = "select * from REMODELING_APPLY ra, REMODELING_APPLY_DIV2 rad, RMDL_DIV1 rd, RMDL_DIV2 rd2 where ra.Number = ? and ra.Number = rad.Apply_num And rad.Div2_num = rd2.Id and rd2.Parent_id = rd.Id";
            pstmt2 = conn.prepareStatement(query);
            pstmt2.setString(1, temp.get("Number"));
            ResultSet rs3 = pstmt2.executeQuery();
            HashMap<String, String> hm = new HashMap<String, String>();
            while (rs3.next()) {
                hm.put(rs3.getString("rd.Name"), rs3.getString("rd2.Name"));
            }
            details.put(temp.get("Number"), hm);
        }
        date.setApplies(applies);
        date.setDetails(details);

        datelist.add(date);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newTest0.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
<div class="body_container">
    <jsp:include page="/newTestHeader.jsp" flush="false" />
    <div class="body_main">
        <div class="main_container">
            <%
                for (int i = 0; i < datelist.size(); i++) {
            %>
            <div class="date_container">
                <span><%=datelist.get(i).getDate()%></span><!--span>2021.06.02</span-->
            </div>
            <%
                for(String key : datelist.get(i).applies.keySet()){
                    HashMap apply = datelist.get(i).applies.get(key);
            %>
            <div class="box_container">
                <div class="main_box">
                    <div class="text_container">
                        <div class="text"><span class="fir">주거 프라임</span></div>
                        <div class="text">
                            <span class="sec_sec"><%=apply.get("Building_type")%> <%=apply.get("Area")%>평</span><!--span class="sec_sec">아파트 32평</span-->
                        </div>
                        <div class="text">
                            <span class="thr"><%=apply.get("Address")%></span><!--span class="thr">대구 남구 어쩌구</span-->
                        </div>
                        <div class="text">
                            <span class="thr"><%=apply.get("Due")%> / <%=apply.get("Budget")%></span><!--span class="thr">1개월 이내 / 8천만원 이하</span-->
                        </div>
                        <div class="text">
                            <a href="<%=apply.get("URL")%>>"><span class="for"><%=apply.get("Title")%></span></a><!--a href="#"><span class="for">없음</span></a-->
                        </div>
                    </div>
                    <div class="under_container">
                        <a href="#" target="_self" class="accept" id="<%=apply.get("Number")%>">
                            <div class="side_container">
                                <div class="img_container">
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/distri.png?raw=true" />
                                </div>
                                <div class="text_container distri">
                                    <span>수락</span>
                                </div>
                                <div class="text_container_wait">
                                    <span>남은 시간(<div style="display:inline-block" id="timer<%=apply.get("Number")%>"></div>)</span>
                                </div>
                            </div>
                        </a>
                        <a href="#" target="_self" class="accept" id="<%=apply.get("Number")%>">
                            <div class="side_container">
                                <div class="img_container">
                                    <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancle.png?raw=true" />
                                </div>
                                <div class="text_container">
                                    <span>거절</span>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <%}
            }
            %>
        </div>
    </div>
    <jsp:include page="/newTestFooter.jsp" flush="false" />
</div>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
<script>
    function acept(){
        alert("수락했습니다.")
    }
    function cancle(){
        alert("거절했습니다.")
    }
    $('.accept').click(function(){
        const id = $(this).attr("id");
        if( $('#timer'+id).text() == "시간종료"){
            alert("제한시간 내에 수락하지 않아 해당 신청건은 받으실 수 없습니다.");
        }
        else {
            location.href = "_newTest_company_accept.jsp?companyNum=" + "<%=s_id%>" + "&applyNum=" + id;
        }
    })
    $('.refuse').click(function(){
        const id = $(this).attr("id");
        location.href = "_newTest_company_refuse.jsp?companyNum="+"<%=s_id%>"+"&applyNum="+id;
    })
</script>
<script>
    const countDownTimer = function (id, date){
        const _vvDate = new Date(date);
        const _vDate = _vvDate.setHours(_vvDate.getHours()+3);
        const _second = 1000;
        const _minute = _second * 60;
        const _hour = _minute * 60;
        const _day = _hour * 24;
        let timer;

        function showRemaining(){
            const now = new Date();
            const distDt = _vDate - now;

            if(distDt < 0){
                clearInterval(timer);
                document.getElementById(id).textContent = "시간종료";
                return;
            }

            const days = Math.floor(distDt / _day);
            const hours = Math.floor((distDt % _day) / _hour);
            const minutes = Math.floor((distDt % _hour) / _minute);
            const seconds = Math.floor((distDt % _minute) / _second);

            //document.getElementById(id).textContent = days + '일 ';
            document.getElementById(id).textContent = hours + '시간 ';
            document.getElementById(id).textContent += minutes + '분 ';
            document.getElementById(id).textContent += seconds + '초 ';

        }

        timer = setInterval(function(){
            showRemaining()
        }, 1000);

    }


    <%
    for(int i = 0; i < datelist.size(); i++) {
        for(String key : datelist.get(i).applies.keySet()){
            HashMap apply = datelist.get(i).applies.get(key);
        %>
    var str = "<%=apply.get("Assigned_time")%>";
    var date = str.split("-"); //{2021}, {06}, {23 17:32:09.0}
    var time = (date[2].substring(date[2].indexOf(" ")+1, date[2].length)).split(":");
    date[2] = date[2].substring(0, date[2].indexOf(" "));
    countDownTimer("timer"+"<%=apply.get("Number")%>", date[1]+"/"+date[2]+"/"+date[0]+" "+time[0]+":"+time[1]);
    //countDownTimer("timer"+"<%=apply.get("Number")%>", '06/29/2021 00:00 AM');
    <%
        }
}
%>
</script>
</body>
</html>