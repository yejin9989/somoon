<%--
  Created by IntelliJ IDEA.
  User: YejinLEE
  Date: 2021-05-07
  Time: 오후 5:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        #somun_navbar{
            float: left;
            width: 100%;
            height: 38px;
            text-align: center;
            padding: 16px 0 6px;
            /*line-height:30px;*/
        }
        #somun_logo{
            /*border: 1px solid blue;*/
            display: inline-block;
            /*background: url("https://somoonhouse.com/img/somunhouselogo.png") no-repeat;*/
            width: max-content;
            float:left;
            position: relative;
            font-weight: bold;
            color: #31b1f2;
            font-size: 36px;
            left: 4%;
        }
        #alert{
            display: inline-block;
            float:right;
            right: 4%;
            position: relative;
        }
        #somun_logo a{
            color: #31b1f2;
        }
        #somun_logo a:visited{
            color: #31b1f2;
        }
        #somun_logo a:hover{
            color: #31b1f2;
        }
        #somun_logo a:active{
            color: #31b1f2;
        }
    </style>
</head>
<body>
<div id="somun_navbar">
    <div id="somun_logo"><a href="index.jsp"><img style="height:30px;"src="https://somoonhouse.com/otherimg/index/somunlogo.jpg"></a></div>
    <div id="alert"><a href="alert.jsp"><img style="height:30px;"src="https://somoonhouse.com/otherimg/index/alert.jpg"></a></div>
</div>
</body>
</html>
