<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<%
		request.setCharacterEncoding("UTF-8");  //한글깨지면 주석제거
		//request.setCharacterEncoding("EUC-KR");  //해당시스템의 인코딩타입이 EUC-KR일경우에
		String inputYn = request.getParameter("inputYn");
		String roadFullAddr = request.getParameter("roadFullAddr");
		String roadAddrPart1 = request.getParameter("roadAddrPart1");
		String roadAddrPart2 = request.getParameter("roadAddrPart2");
		String engAddr = request.getParameter("engAddr");
		String jibunAddr = request.getParameter("jibunAddr");
		String zipNo = request.getParameter("zipNo");
		String addrDetail = request.getParameter("addrDetail");
		String admCd    = request.getParameter("admCd");
		String rnMgtSn = request.getParameter("rnMgtSn");
		String bdMgtSn  = request.getParameter("bdMgtSn");
		String detBdNmList  = request.getParameter("detBdNmList");
		String bdNm  = request.getParameter("bdNm");
		String bdKdcd  = request.getParameter("bdKdcd");
		String siNm  = request.getParameter("siNm");
		String sggNm  = request.getParameter("sggNm");
		String emdNm  = request.getParameter("emdNm");
		String liNm  = request.getParameter("liNm");
		String rn  = request.getParameter("rn");
		String udrtYn  = request.getParameter("udrtYn");
		String buldMnnm  = request.getParameter("buldMnnm");
		String buldSlno  = request.getParameter("buldSlno");
		String mtYn  = request.getParameter("mtYn");
		String lnbrMnnm  = request.getParameter("lnbrMnnm");
		String lnbrSlno  = request.getParameter("lnbrSlno");
		String emdNo  = request.getParameter("emdNo");
		String entX  = request.getParameter("entX");
		String entY  = request.getParameter("entY");
	%>
	<!-- 사용자 행동 정보 수집 코드 시작 - Meta, GA -->
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
<script language="javascript">
	// opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("주소입력화면 소스"도 동일하게 적용시켜야 합니다.)
	//document.domain = "milymoodlounge.com";
	/*
                모의 해킹 테스트 시 팝업API를 호출하시면 IP가 차단 될 수 있습니다.
                주소팝업API를 제외하시고 테스트 하시기 바랍니다.
    */
	function init(){
		var url = location.href;
		var confmKey = "U01TX0FVVEgyMDIwMDUyNjEwMDc0MzEwOTc5Njc=";
		var resultType = "4"; // 도로명주소 검색결과 화면 출력내용, 1 : 도로명, 2 : 도로명+지번, 3 : 도로명+상세건물명, 4 : 도로명+지번+상세건물명
		var inputYn= "<%=inputYn%>";
		if(inputYn != "Y"){
			document.form.confmKey.value = confmKey;
			document.form.returnUrl.value = url;
			document.form.resultType.value = resultType;
			document.form.action="http://www.juso.go.kr/addrlink/addrCoordUrl.do"; //인터넷망
			document.form.submit();
		}else{
			opener.jusoCallBack("<%=roadFullAddr%>","<%=roadAddrPart1%>","<%=addrDetail%>","<%=roadAddrPart2%>","<%=engAddr%>","<%=jibunAddr%>","<%=zipNo%>", "<%=admCd%>", "<%=rnMgtSn%>", "<%=bdMgtSn%>", "<%=detBdNmList%>", "<%=bdNm%>", "<%=bdKdcd%>", "<%=siNm%>", "<%=sggNm%>", "<%=emdNm%>", "<%=liNm%>", "<%=rn%>", "<%=udrtYn%>", "<%=buldMnnm%>", "<%=buldSlno%>", "<%=mtYn%>", "<%=lnbrMnnm%>", "<%=lnbrSlno%>", "<%=emdNo%>", "<%=entX%>", "<%=entY%>");
			window.close();
		}
	}
</script>
<body onload="init();">
<form id="form" name="form" method="post">
	<input type="hidden" id="confmKey" name="confmKey" value=""/>
	<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
	<input type="hidden" id="resultType" name="resultType" value=""/>
	<!-- 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 START-->
	<!--
    <input type="hidden" id="encodingType" name="encodingType" value="EUC-KR"/>
     -->
	<!-- 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 END-->
</form>
</body>
</html>