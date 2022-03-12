<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page language="java" import="myPackage.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Date" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
    //필요한 변수 선언
    int i, j;
    String mylog = "";

    //파라미터 가져오기
    //String param = request.getParameter("param");

    // 파라미터
    String assign = "";
    String comp = "";
    String client = "";
    String state = "";
    String rate = "";
    String text = "";
    String img_path = "";
    String rev_id = "";
    LinkedList<String> img = new LinkedList<String>();

    // 파일관련 변수
    String file1 = "";

    // multipartRequest 설정
    int maxSize = 1024*1024*5;
    String encType = "UTF-8";

    // 파일이 저장될 서버의 실제 폴더 경로. ServletContext 이용
    String realFolder = "";

    // webApp 상의 폴더명. 이 폴더에 해당하는 실제 경로 찾아 realFolder 로 매핑시킴
    String saveFile = "otherimg/review_img";

    ServletContext sContext = getServletContext();
    realFolder = sContext.getRealPath(saveFile);

    //DB 관련 객체 선언
    Connection conn = DBUtil.getMySQLConnection();
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    String query = "";
    String sql = "";

    try{
        // upload
        MultipartRequest multi = null;
        multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

        // get, set inputs
        assign = multi.getParameter("assign")+"";
        comp = multi.getParameter("comp")+"";
        client = multi.getParameter("client")+"";
        state = multi.getParameter("state")+"";
        rate = multi.getParameter("rate")+"";
        text = multi.getParameter("text")+"";


        // get file
        Vector vec = new Vector();
        Enumeration<?> files = multi.getFileNames();
        while(files.hasMoreElements()) { //다음 요소가 있으면 계속 반복
            file1 =(String) files.nextElement();
            vec.add(file1);
        }
        //파일 순서대로 정렬
        String[] formName= new String[vec.size()];
        vec.copyInto(formName);
        Arrays.sort(formName, Collections.reverseOrder());

        for(int vecsize = 0; vecsize< formName.length; vecsize++){
            img_path = multi.getFilesystemName(formName[vecsize]);
            if(img_path != null){
                img.push(img_path);
            }
        }
    } catch(Exception e) {
        e.printStackTrace();
    }

    // check input validity
    int error = 0;
    if(comp.equals(null)||client.equals(null)||state.equals(null)||rate.equals(null)) {
    %><script>alert("잘못된 정보입니다!."); window,history.back();</script><%
        error++;
    }

//    if(img_path != null) {
//        file1 = "https://somoonhouse.com/otherimg/review_img/" + img_path;
//        //out.print("filename : " + file1);
//    }

    for(int img_list = 0; img_list < img.size(); img_list++){
        String img_p = img.get(img_list);
        img_p = "https://somoonhouse.com/otherimg/review_img/" + img_p;
        img.set(img_list,img_p);
    }

    if(error == 0){
        //DB에 계약일시, 파일명, 계약금액 넣고 상태 업데이트
        query = "INSERT INTO client_review(assign_id, state, remodeling_apply_id, company_id, rate, text) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, assign);
        pstmt.setString(2, state);
        pstmt.setString(3, client);
        pstmt.setString(4, comp);
        pstmt.setString(5, rate);
        pstmt.setString(6, text);
        pstmt.executeUpdate();

        query = "SELECT id FROM client_review WHERE assign_id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, assign);
        rs = pstmt.executeQuery();
        while (rs.next()){
            rev_id = rs.getString("id");
        }

        for(String s: img){
            query = "INSERT INTO client_review_img(id, img) VALUES (?, ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, rev_id);
            pstmt.setString(2, s);
            pstmt.executeUpdate();
        }

        pstmt.close();

        //out.print("contract_date : " + contract_date + " contract_price: " + contract_price);
%>
<script>
    alert('평가 등록을 완료했습니다.');
    // history.back();
</script>
<%
}
else{
%>
<script>
    alert('평가 등록에 실패했습니다.');
    // history.back();
</script>
<%
    }
    conn.close();
%>
<!DOCTYPE html>
<html>
<head><!-- 사용자 행동 정보 수집 코드 시작 - Meta, GA -->
    <!-- 모든 페이지에 하나씩만 포함되어 있어야 합니다. 위치는 </head> 바로 위로 통일 -->
    <!-- Meta Pixel Code -->
    <script>
        !function(f,b,e,v,n,t,s)
        {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
            n.callMethod.apply(n,arguments):n.queue.push(arguments)};
            if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
            n.queue=[];t=b.createElement(e);t.async=!0;
            t.src=v;s=b.getElementsByTagName(e)[0];
            s.parentNode.insertBefore(t,s)}(window, document,'script',
            'https://connect.facebook.net/en_US/fbevents.js');
        fbq('init', '483692416470707');
        fbq('track', 'PageView');
    </script>
    <noscript><img height="1" width="1" style="display:none"
                   src="https://www.facebook.com/tr?id=483692416470707&ev=PageView&noscript=1"
    /></noscript>
    <!-- End Meta Pixel Code -->
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', 'G-PC15JG6KGN');
    </script>
    <!-- END Global site tag (gtag.js) - Google Analytics -->
    <!-- Google Tag Manager -->
    <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
            new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
        j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
        'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','GTM-TQFGN2T');</script>
    <!-- End Google Tag Manager -->
    <!-- 사용자 행동 정보 수집 코드 끝 - Meta, GA -->
</head>
<body>
<%--<%=mylog%>--%>
<%--<%--%>
<%--    if(pstmt != null) {--%>
<%--        pstmt.close();--%>
<%--    }--%>
<%--    if(rs != null){--%>
<%--        rs.close();--%>
<%--    }--%>
<%--    if(conn != null){--%>
<%--        conn.close();--%>
<%--    }--%>
<%--    query = "";--%>
<%--%>--%>
<script>
    console.log("comp = <%=comp%>");
    console.log("client = <%=client%>");
    console.log("state = <%=state%>");
    console.log("rate = <%=rate%>");
    console.log("text = <%=text%>");
    <% for(String s: img){%>
    console.log("photo = <%=s%>");
    <%}%>
</script>
</body>
</html>
<%
    //DB개체 정리
/*
pstmt.close();
rs.close();
query="";
conn.close();
*/
%>