<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<%@ page import="javax.swing.*" %>
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
    String ing_search = request.getParameter("ing")+"";
    if(ing_search == null || ing_search.equals("null")) ing_search = "";
    String ing_filter = request.getParameter("filter")+"";
    if(ing_filter == null || ing_filter.equals("null")) ing_filter = "100";

    //변수설정
    String[] buildingType = {"아파트", "빌라", "주택", "원룸"};
    String[] assignedState = {"상담 대기", "부재중", "상담중", "미팅 예정", "계약진행중", "계약완료"};
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
    if(ing_filter.equals("100")) {
        query += " And A.State >= 2 And A.State < 8"; // 탭에따라 이 쿼리 바꾸어주기
    }
    else {
        query += " And A.State = " + ing_filter;
    }
    if(ing_search != null && ing_search != "") {
        query += " And (R.Name Like \"%" + ing_search + "%\" OR R.Phone Like \"%" + ing_search + "%\" OR R.Address Like \"%" + ing_search + "%\")";
    }
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
        query += " And A.State >= 2 And A.State < 8";
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
                    if(!rs3.getString("URL").equals("#")){
                        temp.put("URL", "_hit.jsp?num="+rs2.getString("R.Item_num"));
                    }
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newTest.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
<%=mylog%>
<%

%>
<div class="body_container">
    <jsp:include page="/newTestHeader.jsp" flush="false" />
    <div class="body_main">
        <div class="main_header">
            <form id="form_ing" name="form_ing" method="POST" action="newTest.jsp">
                <div class="left_container">
                    <div class="left_box">
                        <div class="img_container">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/magnifying.png?raw=true" />
                        </div>
                        <div class="text_container">
                            <input class="text_input" type="text" name="ing" placeholder="전화, 고객명, 주소" value="<%=ing_search%>" />

                        </div>
                    </div>
                </div>
                <div class="right_container">
<%--                    <div class="right_box">--%>
<%--                        <div class="text_container">--%>
<%--                            <span>전체보기</span>--%>
<%--                        </div>--%>
<%--                        <div class="img_container">--%>
<%--                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/underDirection.png?raw=true" />--%>
<%--                        </div>--%>
<%--                    </div>--%>
                    <div class="right_box">
                        <div class="text_container">
                            <select class="filter" type="text" name="filter" />
                                <option value="100" selected>전체보기</option>
                                <%for (int j = 0; j < assignedState.length; j++) {
                                    String selected = "";
                                     if(j+2 == Integer.parseInt(ing_filter))
                                         selected = "selected";
                                %>
                                <option value="<%=j+2%>" <%=selected%>><%=assignedState[j]%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                    <input type="submit" value="검색" />
                </div>
            </form>
        </div>
        <div class="main_container">
            <%for (int i = 0; i < datelist.size(); i++) {%>
            <div class="date_container">
                <span><%=datelist.get(i).getDate()%></span> <!--span>2021.06.02</span-->
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
                            <span class="sec_fir">성함</span>
                            <span class="sec_sec"><%=apply.get("Name")%></span><!--span class="sec_sec">정진성</span-->
                        </div>
                        <div class="text">
                            <span class="sec_fir">주거</span>
                            <span class="sec_sec"><%=apply.get("Building_type")%> <%=apply.get("Area")%>평</span><!--span class="sec_sec">아파트 32평</span-->
                        </div>
                        <div class="text">
                            <span class="sec_fir">주소</span>
                            <span class="thr"><%=apply.get("Address")%></span><!--span class="thr">대구 남구 어쩌구</span-->
                        </div>
                        <div class="text">
                            <span class="sec_fir">예정일</span>
                            <span class="thr"><%=apply.get("Due")%></span><!--span class="thr">1개월 이내</span-->
                        </div>
                        <div class="text">
                            <span class="sec_fir">예산</span>
                            <span class="thr"><%=apply.get("Budget")%></span><!--span class="thr">8천만원 이하</span-->
                        </div>
                        <div class="text">
                            <span class="sec_fir">신청한 디자인</span>
                            <a href="<%=apply.get("URL")%>"><span class="for"><%=apply.get("Title")%></span></a>
                        </div>
                        <div class="text">
                            <select class="fiv" type="text" name="state<%=apply.get("Number")%>" placeholder="2차 상담 방법 입력" />
                            <%for (int j = 0; j < assignedState.length; j++) {
                                String selected = "";
                                if(j+2 == Integer.parseInt(String.valueOf(apply.get("State"))))
                                    selected = "selected";%>
                                <option value="<%=j+2%>" <%=selected%>><%=assignedState[j]%></option>
                            <%}%>
                            </select>
                            <button class="fiv_btn" onclick="save(this)" id="stt<%=apply.get("Number")%>">저장</button>
                        </div>
                    </div>
                    <div class="under_container">
                        <div class="side_container" onclick="calling()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/call.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span><a href="tel:<%=apply.get("Phone")%>">전화</a></span>
                            </div>
                        </div>
                        <div class="side_container" onclick="massage()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/talk.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span><a href="tel:<%=apply.get("Phone")%>">문자</a></span>
                            </div>
                        </div>
                        <div class="side_container" id="com<%=apply.get("Number")%>" onclick="open_modal(this)">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/check3.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>완료</span>
                            </div>
                        </div>
                        <div class="side_container" id="fin<%=apply.get("Number")%>" onclick="open_modal_non_fin(this)">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel2.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>중단</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal_container_fin" id="modal_container_fin">
                <form method="post">
                    <div class="modal_box">
                        <div class="item_container">
                            <span class="item_span">계약 일시</span>
                            <div class="select_date">
                                <input type="date" required/>
                            </div>
                            <span class="item_span">계약금</span>
                            <div class="input_pay">
                                <input type="text" placeholder="계약금을 입력해주세요" required/>
                            </div>
                            <span class="item_span">계약서 업로드</span>
                            <input class="file" type="file" required/>
                        </div>
                        <div class="btn_container">
                            <button type="submit"><span>완 료</span></button>
                        </div>
                        <div class="modal_cancel" onclick="close_modal()">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel.png?raw=true" />
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal_container_non_fin" id="modal_container_non_fin">
                <form method="post">
                    <div class="modal_box">
                        <div class="item_container">
                            <span class="item_span">중단 단계</span>
                            <div class="stop_step">
                                <div class="input_box">
                                    <input type="radio" name="step" value="1" required/>
                                    <span>전화 통화 전 마무리</span>
                                </div>
                                <div class="input_box">
                                    <input type="radio" name="step" value="2" />
                                    <span>전화 통화 후 마무리</span>
                                </div>
                                <div class="input_box">
                                    <input type="radio" name="step" value="3" />
                                    <span>방문 상담 후 마무리</span>
                                </div>
                                <div class="input_box">
                                    <input type="radio" name="step" value="4" />
                                    <span>견적 산출 후 마무리</span>
                                </div>
                                <div class="input_box">
                                    <input type="radio" name="step" value="5" />
                                    <span>계약 전 마무리</span>
                                </div>
                            </div>
                            <span class="item_span">중단 사유</span>
                            <div class="stop_why">
                                <input type="text" placeholder="중단 사유를 입력해주세요" required/>
                            </div>
                        </div>
                        <div class="btn_container">
                            <button type="submit"><span>중 단</span></button>
                        </div>
                        <div class="modal_cancel" onclick="close_modal_non_fin()">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel.png?raw=true" />
                        </div>
                    </div>
                </form>
            </div>
            <%
                }
            }
            %>
        </div>
        <div class="main_container">
            <div class="date_container">
                <span>2021.06.02</span>
            </div>
            <div class="box_container">
                <div class="main_box">
                    <div class="text_container">
                        <div class="text"><span class="fir">주거 프라임</span></div>
                        <div class="text">
                            <span class="sec_fir">성함</span>
                            <span class="sec_sec">정진성</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">주거</span>
                            <span class="sec_sec">아파트 32평</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">주소</span>
                            <span class="thr">대구 남구 어쩌구</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">예정일</span>
                            <span class="thr">1개월 이내</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">예산</span>
                            <span class="thr">8천만원 이하</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">신청한 디자인</span>
                            <a href="https://blog.naver.com/gudwls1498/220218687283"><span class="for">월성동 e편한세상월배 34평</span></a>
                        </div>
                        <div class="text">
                            <input class="fiv" type="text" placeholder="2차 상담 방법 입력" />
                            <button class="fiv_btn" onclick="save()">저장</button>
                        </div>
                    </div>
                    <div class="under_container">
                        <div class="side_container" onclick="calling()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/call.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>전화</span>
                            </div>
                        </div>
                        <div class="side_container" onclick="massage()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/talk.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>문자</span>
                            </div>
                        </div>
                        <div class="side_container" onclick="open_modal()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/check3.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>완료</span>
                            </div>
                        </div>
                        <div class="side_container" onclick="open_modal_non_fin()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel2.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>중단</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal_container_fin" id="modal_container_fin">
                <form method="post">
                    <div class="modal_box">
                        <div class="item_container">
                            <span class="item_span">계약 일시</span>
                            <div class="select_date">
                                <input type="date" required/>
                            </div>
                            <span class="item_span">계약금</span>
                            <div class="input_pay">
                                <input type="text" placeholder="계약금을 입력해주세요" required/>
                            </div>
                            <span class="item_span">계약서 업로드</span>
                            <input class="file" type="file" required/>
                        </div>
                        <div class="btn_container">
                            <button type="submit"><span>완 료</span></button>
                        </div>
                        <div class="modal_cancel" onclick="close_modal()">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel.png?raw=true" />
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal_container_non_fin" id="modal_container_non_fin">
                <form method="post">
                    <div class="modal_box">
                        <div class="item_container">
                            <span class="item_span">중단 단계</span>
                            <div class="stop_step">
                                <div class="input_box">
                                    <input type="radio" name="step" value="1" required/>
                                    <span>전화 통화 전 마무리</span>
                                </div>
                                <div class="input_box">
                                    <input type="radio" name="step" value="2" />
                                    <span>전화 통화 후 마무리</span>
                                </div>
                                <div class="input_box">
                                    <input type="radio" name="step" value="3" />
                                    <span>방문 상담 후 마무리</span>
                                </div>
                                <div class="input_box">
                                    <input type="radio" name="step" value="4" />
                                    <span>견적 산출 후 마무리</span>
                                </div>
                                <div class="input_box">
                                    <input type="radio" name="step" value="5" />
                                    <span>계약 전 마무리</span>
                                </div>
                            </div>
                            <span class="item_span">중단 사유</span>
                            <div class="stop_why">
                                <input type="text" placeholder="중단 사유를 입력해주세요" required/>
                            </div>
                        </div>
                        <div class="btn_container">
                            <button type="submit"><span>중 단</span></button>
                        </div>
                        <div class="modal_cancel" onclick="close_modal_non_fin()">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel.png?raw=true" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="main_container">
            <div class="date_container">
                <span>2021.06.02</span>
            </div>
            <div class="box_container">
                <div class="main_box">
                    <div class="text_container">
                        <div class="text"><span class="fir">주거 프라임</span></div>
                        <div class="text">
                            <span class="sec_fir">성함</span>
                            <span class="sec_sec">정진성</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">주거</span>
                            <span class="sec_sec">아파트 32평</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">주소</span>
                            <span class="thr">대구 남구 어쩌구</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">예정일</span>
                            <span class="thr">1개월 이내</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">예산</span>
                            <span class="thr">8천만원 이하</span>
                        </div>
                        <div class="text">
                            <span class="sec_fir">신청한 디자인</span>
                            <a href="https://blog.naver.com/gudwls1498/220218687283"><span class="for">월성동 e편한세상월배 34평</span></a>
                        </div>
                        <div class="text">
                            <input class="fiv" type="text" placeholder="2차 상담 방법 입력" />
                            <button class="fiv_btn" onclick="save()">저장</button>
                        </div>
                    </div>
                    <div class="under_container">
                        <div class="side_container" onclick="calling()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/call.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>전화</span>
                            </div>
                        </div>
                        <div class="side_container" onclick="massage()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/talk.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>문자</span>
                            </div>
                        </div>
                        <div class="side_container" onclick="open_modal()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/check3.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>완료</span>
                            </div>
                        </div>
                        <div class="side_container" onclick="open_modal_non_fin()">
                            <div class="img_container">
                                <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel2.png?raw=true" />
                            </div>
                            <div class="text_container">
                                <span>중단</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal_container_fin" id="modal_container_fin">
                <form method="post">
                    <div class="modal_box">
                        <div class="item_container">
                            <span class="item_span">계약 일시</span>
                            <div class="select_date">
                                <input type="date" required/>
                            </div>
                            <span class="item_span">계약금</span>
                            <div class="input_pay">
                                <input type="text" placeholder="계약금을 입력해주세요" required/>
                            </div>
                            <span class="item_span">계약서 업로드</span>
                            <input class="file" type="file" required/>
                        </div>
                        <div class="btn_container">
                            <button type="submit"><span>완 료</span></button>
                        </div>
                        <div class="modal_cancel" onclick="close_modal()">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel.png?raw=true" />
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal_container_non_fin" id="modal_container_non_fin">
                <form method="post">
                    <div class="modal_box">
                        <div class="item_container">
                            <span class="item_span">중단 단계</span>
                            <div class="stop_step">
                                <div class="input_box">
                                    <input type="radio" name="step" value="1" required/>
                                    <span>전화 통화 전 마무리</span>
                                </div>
                                <div class="input_box">
                                    <input type="radio" name="step" value="2" />
                                    <span>전화 통화 후 마무리</span>
                                </div>
                                <div class="input_box">
                                    <input type="radio" name="step" value="3" />
                                    <span>방문 상담 후 마무리</span>
                                </div>
                                <div class="input_box">
                                    <input type="radio" name="step" value="4" />
                                    <span>견적 산출 후 마무리</span>
                                </div>
                                <div class="input_box">
                                    <input type="radio" name="step" value="5" />
                                    <span>계약 전 마무리</span>
                                </div>
                            </div>
                            <span class="item_span">중단 사유</span>
                            <div class="stop_why">
                                <input type="text" placeholder="중단 사유를 입력해주세요" required/>
                            </div>
                        </div>
                        <div class="btn_container">
                            <button type="submit"><span>중 단</span></button>
                        </div>
                        <div class="modal_cancel" onclick="close_modal_non_fin()">
                            <img src="https://github.com/Yoonlang/web-programming/blob/master/html/assets/cancel.png?raw=true" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="/newTestFooter.jsp" flush="false" />
</div>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
<script>
    const save = (obj) => {
        //alert("상담 방법 저장");
        var id = obj.getAttribute("id").substring(3,);
        var state = $('select[name=state'+id+']').val();
        location.href = '_newTest_company_change_state.jsp?companyNum='+'<%=s_id%>'+'&state='+state+'&applyNum='+id;
    }
    const calling = () => {
        alert("전화 걸기");
    }
    const massage = () => {
        alert("문자 보내기");
    }
    const open_modal = (obj) => {
        /*
        var modal = document.getElementById("modal_container_fin");
        modal.style.display = "flex"
        */
        var id = obj.getAttribute("id").substring(3,);
        location.href = "_newTest_company_change_state.jsp?companyNum="+"<%=s_id%>"+"&state=8&applyNum="+id;
    }
    const close_modal = () => {
        var modal = document.getElementById("modal_container_fin");
        modal.style.display = "none"
    }
    const open_modal_non_fin = (obj) => {
        /*
        var modal = document.getElementById("modal_container_non_fin");
        modal.style.display = "flex"
         */
        var id = obj.getAttribute("id").substring(3,);
        location.href = "_newTest_company_change_state.jsp?companyNum="+"<%=s_id%>"+"&state=9&applyNum="+id;
    }
    const close_modal_non_fin = () => {
        var modal = document.getElementById("modal_container_non_fin");
        modal.style.display = "none"
    }
    // 새로고침 시 get parameter 초기화
    history.replaceState({}, null, location.pathname);
</script>
</body>
</html>