<%--
  Created by IntelliJ IDEA.
  User: YejinLEE
  Date: 2021-04-08
  Time: 오후 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>사진교체</title>
    <style>
        label{
            border-radius: 17px;
            color: white;
            background: #3e70ff;
            text-align: center;
            cursor: pointer;
            padding: 0 10px;
            display: inline-block;
            height: 98px;
        }
        label div{
            font-weight: bold;
            font-size: 11pt;
        }
        label img{
            width: 50px;
            height: 43px;
            margin: 10px;
        }
        input[type="file"], input[type="submit"]{/* 파일 필드 숨기기 */
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip:rect(0,0,0,0);
            border: 0;
        }
        #buttons{
            display: inline-block;
        }
        body{
            text-align:center;
        }
        img{
            display: block;
        }
    </style>
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
    <!-- 사용자 행동 정보 수집 코드 끝 - Meta, GA -->
</head>
<body>
<form action="_alert_change_img.jsp" method="post" enctype="multipart/form-data">
    <img style="width: 316px;" id="preview-image" src="https://dummyimage.com/500x500/ffffff/000000.png&text=preview+image">
    <div id="buttons">
        <label for="change">
            <img src="https://somoonhouse.com/icon/photo.png">
            <div>파일 선택</div>
        </label>
        <label for="submit">
            <img src="https://somoonhouse.com/icon/upload.png">
            <div>업로드</div>
        </label>
    </div>
    <input type="file" id="change" name="filename1">
    <input type="submit" id="submit">
</form>
<script>
    function readImage(input) {
        // 인풋 태그에 파일이 있는 경우
        if(input.files && input.files[0]) {
            // 이미지 파일인지 검사 (생략)
            // FileReader 인스턴스 생성
            const reader = new FileReader()
            // 이미지가 로드가 된 경우
            reader.onload = e => {
                const previewImage = document.getElementById("preview-image")
                previewImage.src = e.target.result
            }
            // reader가 이미지 읽도록 하기
            reader.readAsDataURL(input.files[0])
        }
    }
    // input file에 change 이벤트 부여
    const inputImage = document.getElementById("change")
    inputImage.addEventListener("change", e => {
        readImage(e.target)
    })
</script>
</body>
</html>
