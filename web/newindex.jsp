<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 31536000);
%>
<%
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
%>
<%
//키워드 받아오기
    query = "select * from KEYWORD";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    ArrayList<String> keyword = new ArrayList<String>();
    while(rs.next()) {
        keyword.add(rs.getString("Name"));
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="SHORTCUT ICON" href="https://somoonhouse.com/img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newindex.css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title>
</head>
<body>
<div id="container">
    <div>
        <span id="topBtn">top</span>
        <span id="applyBtn"><div>상담<br>신청</div></span>
    </div>
    <script>
        var topEle = $('#topBtn');
        var delay = 1000;
        topEle.on('click', function(){
            $('html, body').stop().animate({scrollTop:0}, delay);
        })
    </script>
    <script>
        var applyEle = $('#applyBtn');
        applyEle.on('click', function(){
            location.href = "remodeling_form.jsp?item_num=0";
        })
    </script>
    <div id="somun_navbar">
        <div id="somun_logo"><a href="index.jsp"><img style="height:30px;"src="https://somoonhouse.com/otherimg/index/somunlogo.jpg"></a></div>
        <div id="alert"><a href="alert.jsp"><img style="height:30px;"src="https://somoonhouse.com/otherimg/index/alert.jpg"></a></div>
    </div>
    <div id="main">
        <div id="recommend">
            <div id="ref">소문 pick 추천 사례</div>
            <div class="center">
                <%
                    //추천 사례 받아오기
                    query = "select * from RECOMMEND order by Number ASC";
                    pstmt = conn.prepareStatement(query);
                    rs = pstmt.executeQuery();
                    String recitem[][] = new String[100][18];
                    int i = 0;
                    while(rs.next()){
                        recitem[i][0] = rs.getString("Number");
                        recitem[i][3] = rs.getString("Path");
                        String imgstr = rs.getString("Rec_img");
                %>
                <div>
                    <div class="center_img">
                        <div>
                            <a href = "<%=recitem[i][3]%>" target="_self">
                                <img src="<%=imgstr%>" class="eotkd">
                                </a>
                        </div>
                    </div>
                </div>
                <%
                        i++;
                    }
                %>
            </div>
        </div>
        <div id="somun_search">
            <div class = "search_item" id="search_item2">
                <form action="index.jsp" method="GET">
                    <%
                        String[] request_areas = request.getParameterValues("Daegu");
                        if(request_areas==null || request_areas[0].equals("undefined")){
                            request_areas = new String[9];
                            request_areas[0] = "all";
                        }
                    %>
                    <!-- input type="radio" name="Daegu" id="all" value="all"><label for="all" class="mylabel">대구전체</label-->
                    <div class="ajax_click">
                        <input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="jung-gu" value="141"<%if(Arrays.asList(request_areas).contains("141")) out.println("checked");%>><label for="jung-gu" class="mylabel">중구</label>
                        <input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="dong-gu" value="142"<%if(Arrays.asList(request_areas).contains("142")) out.println("checked");%>><label for="dong-gu" class="mylabel">동구</label>
                        <input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="seo-gu" value="143"<%if(Arrays.asList(request_areas).contains("143")) out.println("checked");%>><label for="seo-gu" class="mylabel">서구</label>
                        <input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="nam-gu" value="144"<%if(Arrays.asList(request_areas).contains("144")) out.println("checked");%>><label for="nam-gu" class="mylabel">남구</label>
                        <input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="buk-gu" value="145"<%if(Arrays.asList(request_areas).contains("145")) out.println("checked");%>><label for="buk-gu" class="mylabel">북구</label>
                        <input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="suseong-gu" value="146"<%if(Arrays.asList(request_areas).contains("146")) out.println("checked");%>><label for="suseong-gu" class="mylabel">수성구</label>
                        <input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="dalseo-gu" value="147"<%if(Arrays.asList(request_areas).contains("147")) out.println("checked");%>><label for="dalseo-gu" class="mylabel">달서구</label>
                        <input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="dalseong-gun" value="148"<%if(Arrays.asList(request_areas).contains("148")) out.println("checked");%>><label for="dalseong-gun" class="mylabel">달성군</label>
                        <input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="kyeongbook" value="15"<%if(Arrays.asList(request_areas).contains("15")) out.println("checked");%>><label for="kyeongbook" class="mylabel">경북</label>
                    </div>
                </form>
            </div>
        </div>
        <div>
            <form id="form" name="form" method="POST" action="index.jsp">
                <div id="searcharea">
                    <input type="text" id="bdNm"  name="bdNm" placeholder="아파트명, 회사명으로 사례를 찾아보세요"/>
                    <input type="button" onClick="goPopup();" value="주소찾기" id="jusobtn"/>
                    <input id="search" type="submit" value="">
                </div>
                <%String classes = "0"; %>
                <input type="hidden" style="width:40px;height:30px;" id="building" name="building" />
                <input type="hidden"  style="width:500px;" id="jibunAddr"  name="jibunAddr" />
                <input type="hidden"  style="width:500px;" id="roadFullAddr"  name="roadFullAddr" />
                <input type="hidden"  style="width:500px;" id="roadAddrPart1"  name="roadAddrPart1" />
                <input type="hidden"  style="width:500px;" id="addrDetail"  name="addrDetail" />
                <input type="hidden"  style="width:500px;" id="roadAddrPart2"  name="roadAddrPart2" />
                <input type="hidden"  style="width:500px;" id="engAddr"  name="engAddr" />
                <input type="hidden"  style="width:500px;" id="zipNo"  name="zipNo" />
                <input type="hidden"  style="width:500px;" id="admCd"  name="admCd" />
                <input type="hidden"  style="width:500px;" id="rnMgtSn"  name="rnMgtSn" />
                <input type="hidden"  style="width:500px;" id="bdMgtSn"  name="bdMgtSn" />
                <input type="hidden"  style="width:500px;" id="detBdNmList"  name="detBdNmList" />
                <input type="hidden"  style="width:500px;" id="bdKdcd"  name="bdKdcd" />
                <input type="hidden"  style="width:500px;" id="siNm"  name="siNm" />
                <input type="hidden"  style="width:500px;" id="sggNm"  name="sggNm" />
                <input type="hidden"  style="width:500px;" id="emdNm"  name="emdNm" />
                <input type="hidden"  style="width:500px;" id="liNm"  name="liNm" />
                <input type="hidden"  style="width:500px;" id="rn"  name="rn" />
                <input type="hidden"  style="width:500px;" id="udrtYn"  name="udrtYn" />
                <input type="hidden"  style="width:500px;" id="buldMnnm"  name="buldMnnm" />
                <input type="hidden"  style="width:500px;" id="buldSlno"  name="buldSlno" />
                <input type="hidden"  style="width:500px;" id="mtYn"  name="mtYn" />
                <input type="hidden"  style="width:500px;" id="lnbrMnnm"  name="lnbrMnnm" />
                <input type="hidden"  style="width:500px;" id="lnbrSlno"  name="lnbrSlno" />
                <input type="hidden"  style="width:500px;" id="emdNo"  name="emdNo" />
                <input type="hidden"  style="width:500px;" id="entX"  name="entX" />
                <input type="hidden"  style="width:500px;" id="entY"  name="entY" />
            </form>
            <div id="content" style="float:left;width:100%;">

                <%
                    String clientId = "G8MVoxXfGciyZW5dF4p1";//애플리케이션 클라이언트 아이디값";
                    String redirectURI = URLEncoder.encode("http://somoonhouse.com/callback.jsp", "UTF-8");
                    SecureRandom random = new SecureRandom();
                    String state = new BigInteger(130, random).toString();
                    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
                    apiURL += "&client_id=" + clientId;
                    apiURL += "&redirect_uri=" + redirectURI;
                    apiURL += "&state=" + state;
                    session.setAttribute("state", state);
                %>
                <%
                    // 세션 생성 create session
                    session.setAttribute("page", "index.jsp"); // 현재 페이지 current page
                    // 세션 가져오기 get session
                    String pagenumstr = request.getParameter("pagenumstr")+"";
                    if(pagenumstr == null || pagenumstr.equals("null") || pagenumstr.equals("undefined")) pagenumstr = "1";
                    String now = session.getAttribute("page")+""; // 현재 페이지 current page
                    String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
                    String name = session.getAttribute("name")+"";
                    String attr = request.getParameter("attr")+"";
                    String itemname = request.getParameter("itemname")+"";
                    String tag = request.getParameter("tag")+"";
                %>
                <%
                    conn = DBUtil.getMySQLConnection();
                    rs = null;
                    pstmt = null;
                    query = "";
                    //CSRF 방지를 위한 상태 토큰 검증
                    //세션 또는 별도의 저장 공간에 저장된 상태 토큰과 콜백으로 전달받은 state 파라미터 값이 일치해야 함
                    //콜백 응답에서 state 파라미터의 값을 가져옴
                    state = request.getParameter("state");
                %>
                <%
                    if(s_id.equals("100"))
                    {%>
                <div style="width:100%;text-align:center;margin-bottom:20px;">
                    <button onclick="goRecItemUpload();" style="width:150px;height:45px;margin:40px 15px;border-radius:5px; background-color:#29aef2; color:white; font-size:17px; border:none;">추천사례등록  ></button>
                    <button onclick="goItemUpload();" style="width:150px;height:45px;margin:40px 15px;border-radius:5px; background-color:#29aef2; color:white; font-size:17px; border:none;">사례등록  ></button>
                </div>
                <%}%>
                <div id="keyword">
                    <!--이런 인테리어는 어떠세요? 소문난집 인기키워드-->
                    <h2>이런 인테리어는 어떠세요?</h2>
                    <h3>소문난집 인기 키워드</h3>
                    <ul>
                        <%
                            for(i=0; i<keyword.size(); i++){
                                out.print("<li id='keyword"+i+"'>");
                                out.print("<a href='" + "index.jsp?keyword=" + i + "'>");
                                out.print(keyword.get(i));
                                out.print("</a>");
                                out.print("</li>");
                            }
                        %>
                        <%
                        if(s_id.equals("100")){
                            out.print("<li id='keyword"+i+"'>");
                            out.print("<a href='add_keyword.jsp' target='_blank'>");
                            out.print("+");
                            out.print("</a>");
                            out.print("</li>");
                        }
                        %>
                    </ul>
                </div>
                <div class="banner" id="banner1"><img src="https://somoonhouse.com/otherimg/index/banner1.jpg"></div>
                <div><!--인기사례 4칸-->
                    <h2>달서구 인기사례</h2>
                    <div><!--4칸짜리 틀-->
                        <div><!--한 블럭-->
                            <div>이미지</div>
                            <div>설명</div>
                        </div>
                        <div><!--한 블럭-->
                            <div>이미지</div>
                            <div>설명</div>
                        </div>
                        <div><!--한 블럭-->
                            <div>이미지</div>
                            <div>설명</div>
                        </div>
                        <div><!--한 블럭-->
                            <div>이미지</div>
                            <div>설명</div>
                        </div>
                    </div>
                </div>
                <div class="banner" id="banner1"><img src="https://somoonhouse.com/otherimg/index/banner2.jpg"></div>
                <div>
                    <!--소문난집 이용후기-->
                    <h2>소문난집 이용후기</h2>
                    <div>
                        이미지칸
                    </div>
                </div>
                <div><!--인기사례 4칸-->
                    <h2>달서구 인기사례</h2>
                    <div><!--4칸짜리 틀-->
                        <div><!--한 블럭-->
                            <div>이미지</div>
                            <div>설명</div>
                        </div>
                        <div><!--한 블럭-->
                            <div>이미지</div>
                            <div>설명</div>
                        </div>
                        <div><!--한 블럭-->
                            <div>이미지</div>
                            <div>설명</div>
                        </div>
                        <div><!--한 블럭-->
                            <div>이미지</div>
                            <div>설명</div>
                        </div>
                    </div>
                </div>
                <div class="banner" id="banner1"><img src="https://somoonhouse.com/otherimg/index/banner3.jpg"></div>
            </div>
        </div>
    </div>
    <footer>푸터</footer>
</div>
    <%
        if(pstmt != null) {
            pstmt.close();
            rs.close();
            query = "";
            conn.close();
        }
    %>
    <!-- jsp:include page="footer.jsp" flush="false"/ -->
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script>
        function ajax_click(obj){
            var a = $(obj).attr("class");
            <%String ApArt = session.getAttribute("apartment") + "";%>
            var Daegu = $("input[name='Daegu']:checked").val();
            location.href = "index.jsp?Daegu="+Daegu;
        }
    </script>
    <script>
        function frame(){
            var div = $(".center div"); // 이미지를 감싸는 div
            var img = $(".eotkd"); // 이미지
            var divWidth = div[0].offsetWidth
            var divHeight = div[0].offsetHeight-10;
            if(divWidth >= 510){
                divHeight -= 10;
                divWidth -= 120;
                //alert("넓");
            }
            else{
                divWidth -= 110;
                //alert("안넓");
            }
            var divAspect = divHeight / divWidth; // div의 가로세로비는 알고 있는 값이다 세로/가로
            //alert("divWidth : "+ divWidth);
            //alert("divHeight : " + divHeight);
            for(var i=0; i<img.length; i++){
                var imgAspect = img[i].height / img[i].width;
                if (imgAspect <= divAspect) {
                    // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
                    var imgWidthActual = divHeight / imgAspect;
                    var imgWidthToBe = divHeight / divAspect;
                    var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2);
                    img[i].style.cssText = 'width: auto; height: 100%; margin-left: '
                        + marginLeft + 'px;';
                    //alert('납');
                    //alert('imgWidthToBe' + imgWidthToBe);
                    //alert('imgWidthActual' + imgWidthActual);
                } else {
                    // 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
                    var imgHeightActual = divWidth * imgAspect;
                    var imgHeightToBe = divWidth * divAspect;
                    //alert("imgHeightActual" + imgHeightActual);
                    //alert("imgHeightToBe" + imgHeightToBe);
                    var marginTop = -Math.round((imgHeightActual - imgHeightToBe) / 2);
                    img[i].style.cssText = 'width: 100%; height: auto; margin-left: 0; margin-top: '
                        + marginTop + 'px;';
                    //alert("길");
                }
            }
        }

        $(window).resize(function(){
            frame()
        });
        $(document).ready(function(){
            frame()
        });

    </script>
    <script>
        $(document).ready(function(){
            $('.center').slick({
                centerMode: true,
                centerPadding: '50px',
                slidesToShow: 1,
                autoplay: true,
                autoplaySpeed: 3000,
                arrows: false
            });
        })
    </script>
    <script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
    <script type="text/javascript">
        if(!wcs_add) var wcs_add = {};
        wcs_add["wa"] = "3602e31fd32c7e";
        wcs_do();

        function goRecItemUpload(){
            window.open("recommend_item_upload.jsp","pop");
        }

        function goItemUpload(){
            window.open("item_upload.jsp","pop");
        }
    </script>
    <script>
        function slicky(a){
            if( $(a).hasClass('slick-initialized') ){
                $(a).slick('unslick');//슬릭해제
            }
            else{
                $(a).slick({
                    lazyLoad: 'ondemand',
                    dots: true,
                    arrows:true,
                    //autoplay: true,
                    autoplaySpeed: 2000
                });
            }
        }
    </script>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', 'G-PC15JG6KGN');
    </script>
    <script language="javascript">
        function goPopup(){
            // 주소검색을 수행할 팝업 페이지를 호출합니다.
            // 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrCoordUrl.do)를 호출하게 됩니다.
            var pop = window.open("jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
        }
        function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo,entX,entY){
            // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
            document.form.roadFullAddr.value = roadFullAddr;
            document.form.roadAddrPart1.value = roadAddrPart1;
            document.form.roadAddrPart2.value = roadAddrPart2;
            document.form.addrDetail.value = addrDetail;
            document.form.engAddr.value = engAddr;
            document.form.jibunAddr.value = jibunAddr;
            document.form.zipNo.value = zipNo;
            document.form.admCd.value = admCd;
            document.form.rnMgtSn.value = rnMgtSn;
            document.form.bdMgtSn.value = bdMgtSn;
            document.form.detBdNmList.value = detBdNmList;
            document.form.bdNm.value = bdNm;
            document.form.bdKdcd.value = bdKdcd;
            document.form.siNm.value = siNm;
            document.form.sggNm.value = sggNm;
            document.form.emdNm.value = emdNm;
            document.form.liNm.value = liNm;
            document.form.rn.value = rn;
            document.form.udrtYn.value = udrtYn;
            document.form.buldMnnm.value = buldMnnm;
            document.form.buldSlno.value = buldSlno;
            document.form.mtYn.value = mtYn;
            document.form.lnbrMnnm.value = lnbrMnnm;
            document.form.lnbrSlno.value = lnbrSlno;
            document.form.emdNo.value = emdNo;
            document.form.entX.value = entX;
            document.form.entY.value = entY;
        }
    </script>
</body>
</html>