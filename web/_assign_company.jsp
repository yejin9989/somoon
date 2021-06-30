<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar,java.util.Date, java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page language="java" %>
<%@ page language="java" %>
<%@ page language="java" %>
<%@ page import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" %>
<%@ page import="myPackage.*" %>
<%@ page import="myPackage.MessageSend2" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<%
	/*로그인된 세션 아이디(추후개발) 가져오기, 현재 페이지 저장
	String id = session.getAttribute("s_id")+"";
	String now = "_remodeling_form.jsp";*/
	
	//DB에 사용 할 객체들 정의
	Connection conn = DBUtil.getMySQLConnection();
	PreparedStatement pstmt = null;
	Statement stmt = null;
	String query = "";
	String sql = "";
	ResultSet rs = null;
	%>
	<%
	//처리에 에러정보가 있으면 롤백
	int error = 0;
	
	//신청폼으로 부터 받은 데이터 불러오기, 필요한 정보 정의
	int num = 0;
	String[] company1 = request.getParameterValues("company");
	String apply_num = request.getParameter("apply_num");
	String state = "0";
	
	//받을 때 숫자형태가 아닌데 숫자로 입력해야하는경우 변환해주기
	//필드를 다 채웠는지의 여부를 확인해본다. 덜 채웠으면 다시 채우라하기
	if(company1 == null || company1.equals("null")){
	%>
		<script>
		alert('사례를 줄 회사를 1개 이상 선택해주세요');
		</script>
	<%
	error++;
	}
	
	//업데이트하기, company마다 하나씩
	for(String company : company1){
		sql = "INSERT INTO ASSIGNED VALUES(?, ?, ?, default, default, default)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, apply_num);
		pstmt.setString(2, company);
		pstmt.setString(3, state);
		//확인
			//out.println(pstmt);
		
		//실행
		if(error == 0){
			pstmt.executeUpdate();
		}
		else{
			%>
			<script>
			history.back();
			</script>
			<%
		}
	}


	/*처리상태
		0. 미배분
		1. 재배분필요 (시간마감, 일부수락)
		2. 배분중
		3. 전체수락
		4. 고객 취소
		5. 관리자삭제
	 */
				//처리상태 업데이트하기
				sql = "Update REMODELING_APPLY set State=2 where Number = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, apply_num);

				//실행
				if(error == 0){
					pstmt.executeUpdate();
			%>
	<script>
		alert('등록을 완료했습니다.');
		location.href = "remodeling_request.jsp";
	</script>
	<%
	}
	else{
	%>
	<script>
		history.back();
	</script>
	<%
		}

	//배분시간 업데이트하기
		sql = "Update REMODELING_APPLY set Assigned_time = now() where Number = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, apply_num);


		//실행
		if(error == 0){
			pstmt.executeUpdate();
	%>
	<script>
		alert('등록을 완료했습니다.');
		location.href = "remodeling_request.jsp";
	</script>
	<%
	}
	else{
	%>
	<script>
		history.back();
	</script>
	<%
		}

	//확인
	//out.println(pstmt);

	// send messages 문자보내기
	String company_name = "";
	String company_phone = "";
	String msg_str = "";
	MessageSend2 msg = new MessageSend2();

	for(String com : company1) {
		sql = "SELECT Name, Phone FROM COMPANY WHERE Id = '" + com +"'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			company_name = rs.getString("Name");
			company_phone = rs.getString("Phone");
		}
		msg_str = "[소문난집]\n" + company_name + "님, 새로운 상담 신청이 있습니다.  3시간내로 확인 하지 않으면 신청이 사라지오니 얼른 확인해주세요 ";


		// 업체에게 문자 보내기
		// msg.send(company_phone, msg_str, "lms");
	}
	//DB객체 종료
	//stmt.close();
	pstmt.close();
	conn.close();
	%>
</head>
<body>
</body>
</html>